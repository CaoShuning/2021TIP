function [u_dy, kernel] = destripeDeblur(y_gray,lambda, gamma, MK)

%%% 参数设置
% gamma = opt.gamma;
% % % tau = opts.tau;
% lambda = opt.lambda;
% eta = opts.eta;
% kernel_size = opt.kernel_size; %预设模糊核大小
kernel_size = MK;
%% Set kernel size for coarsest levels
% ret = sqrt(0.5);
% maxitr = max(floor(log(5/min(kernel_size))/log(ret)),0);
% scale_num = maxitr + 1; %多尺度的尺度总数
% % fprintf('Number of maximum scale is %d\n', scale_num);
% retv = ret.^(0 : maxitr);
% klist = ceil(kernel_size*retv);
% klist = klist + (mod(klist,2)==0);

%% set kernel size for coarsest level - must be odd
minsize = max(3, 2*floor(((kernel_size - 1)/16)) + 1); %最小迭代PSF3x3
% fprintf('Kernel size at coarsest level is %d\n', minsize);

% determine number of scales 确定尺度的个数
resize_step = sqrt(2);
scale_num = 1;
tmp = minsize;
while(tmp < kernel_size)
    klist(scale_num) = tmp;
    scale_num = scale_num + 1;
    tmp = ceil(tmp * resize_step);
    if (mod(tmp, 2) == 0)
        tmp = tmp + 1;
    end;
end;
klist(scale_num) = kernel_size;
maxitr = scale_num - 1;
ret = sqrt(0.5);
retv = ret.^(0 : maxitr);
temp_klist = klist;
klist = temp_klist(end:-1:1); %将klist的元素反过来排列
% fprintf('Number of maximum scale is %d\n', scale_num);

%%% derivative filters
% dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
% tic
%% =============== 多尺度框架下估计模糊核 =========================
for s = scale_num:-1:1 %从最粗尺度到最细尺度
    ksize_c = klist(s);
%     fprintf('Current scale is %d ', s);
%     fprintf('and the kernel size is %d x %d\n', ksize_c,ksize_c);
    
    %%% 产生每一个尺度上的模糊核
    if (s == scale_num) %最粗尺度上的模糊核初始化
        %kernel = init_kernel(klist(s)); %初始化模糊核为delta函数
        r = klist(s);
        kernel = init_kernel(r);
%         kernel = imresize(kernel, [r r], 'bilinear'); %真实PSF作为初始化输入
    else
        % Upsample kernel from previous level to next finer level
        kernel = resizeKer(kernel,1/ret,ksize_c,ksize_c);
    end
    
    %%% 每一个尺度上的退化图像
    cret = retv(s); %每一个尺度上的采样率
    blurred_gray = downSmpImC(y_gray, cret);
    
    %%% 每一个尺度上的退化图像的梯度图像
    blur_B_tmp = blurred_gray;
    blurred_dy = conv2(blur_B_tmp, dy, 'valid'); %沿竖直方向的模糊图像差分
    
%       blurred_dx = conv2(blur_B_tmp, dx, 'valid'); 
%         blurred_dg =  blurred_dy+blurred_dx
    
    %%% 每一个尺度上的恢复图像的上采样
    if (s == scale_num) %最粗尺度上水平和竖直方向上差分图像的初始化
%         v_dy = blurred_dy;
        u_dy = blurred_dy;
    else %倒数第2尺度上的梯度图像为上尺度恢复图像的上采样
        % upscale the estimated derivative image from previous level
        u_dy = imresize(u_dy, size(blurred_dy), 'bilinear');
    end
%     tic
    %% ====== 内部图像和模糊核的交替迭代 ========================
    for i = 1:5 %
%         fprintf(2,'\nOuter  L0-Regularized imag in the scale: %d\n',s);
        
        %%% 图像恢复
        [u_dy] = img_estimation(blurred_dy, u_dy, kernel, lambda);
        lambda = 0.9*lambda;
        %% Update salient edges
%         u_dy(:,end) = 0;  u_dy(end,:) = 0;
%         u_dy1 = u_dy./norm(u_dy(:));
        
        %% Kernel estimation
%         fprintf('Estimating the blur kernel via FFT\n');
        kernel = psf_estimation(blurred_dy, u_dy, gamma, [ksize_c, ksize_c]);
        kernel =  prunenoise(kernel);
        
        %% 显示中间结果
%         figure(4); imshow(mat2gray(u_dy)); title(sprintf('scale:%d',s)); drawnow;
%         figure(5); imagesc(kernel); colormap(gray); drawnow;
%         figure(6);
%         [row,col] = size(kernel);
%         [X,Y] = meshgrid(1:row,1:col);
%         mesh(X,Y,kernel);
%         axis([1 row 1 col 0 max(kernel(:))]);
%         set(gca,'fontsize',16);
        
        %% Center the kernel
        [u_dy, kernel] = center_kernel_separate(u_dy, kernel);
        kernel(kernel(:)<0) = 0;
        sumk = sum(kernel(:));
        kernel = kernel./sumk;
        
        %         kernel = adjust_psf_center(kernel);
        %         kernel(kernel(:)<0) = 0;
        %         sumk = sum(kernel(:));
        %         kernel = kernel./sumk;
        
    end
%     toc
end
% toc
%% Center the kernel
kernel = adjust_psf_center(kernel);
kernel(kernel(:)<0) = 0;
sumk = sum(kernel(:));
kernel = kernel./sumk;


%% Threshold the kernel
% kernel(kernel<0)=0;
% max_k=max(kernel(:));
% thr=max_k/20;
% kernel(kernel<thr)=0;
% kernel=kernel./sum(kernel(:));
end
function [k] = init_kernel(minsize)
  k = zeros(minsize, minsize);
  k((minsize - 1)/2, (minsize - 1)/2:(minsize - 1)/2+1) = 1/2;
end