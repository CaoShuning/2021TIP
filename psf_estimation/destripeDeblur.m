function [u_dy, kernel] = destripeDeblur(y_gray,lambda, gamma, MK)

%%% ��������
% gamma = opt.gamma;
% % % tau = opts.tau;
% lambda = opt.lambda;
% eta = opts.eta;
% kernel_size = opt.kernel_size; %Ԥ��ģ���˴�С
kernel_size = MK;
%% Set kernel size for coarsest levels
% ret = sqrt(0.5);
% maxitr = max(floor(log(5/min(kernel_size))/log(ret)),0);
% scale_num = maxitr + 1; %��߶ȵĳ߶�����
% % fprintf('Number of maximum scale is %d\n', scale_num);
% retv = ret.^(0 : maxitr);
% klist = ceil(kernel_size*retv);
% klist = klist + (mod(klist,2)==0);

%% set kernel size for coarsest level - must be odd
minsize = max(3, 2*floor(((kernel_size - 1)/16)) + 1); %��С����PSF3x3
% fprintf('Kernel size at coarsest level is %d\n', minsize);

% determine number of scales ȷ���߶ȵĸ���
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
klist = temp_klist(end:-1:1); %��klist��Ԫ�ط���������
% fprintf('Number of maximum scale is %d\n', scale_num);

%%% derivative filters
% dx = [-1 1; 0 0];
dy = [-1 0; 1 0];
% tic
%% =============== ��߶ȿ���¹���ģ���� =========================
for s = scale_num:-1:1 %����ֳ߶ȵ���ϸ�߶�
    ksize_c = klist(s);
%     fprintf('Current scale is %d ', s);
%     fprintf('and the kernel size is %d x %d\n', ksize_c,ksize_c);
    
    %%% ����ÿһ���߶��ϵ�ģ����
    if (s == scale_num) %��ֳ߶��ϵ�ģ���˳�ʼ��
        %kernel = init_kernel(klist(s)); %��ʼ��ģ����Ϊdelta����
        r = klist(s);
        kernel = init_kernel(r);
%         kernel = imresize(kernel, [r r], 'bilinear'); %��ʵPSF��Ϊ��ʼ������
    else
        % Upsample kernel from previous level to next finer level
        kernel = resizeKer(kernel,1/ret,ksize_c,ksize_c);
    end
    
    %%% ÿһ���߶��ϵ��˻�ͼ��
    cret = retv(s); %ÿһ���߶��ϵĲ�����
    blurred_gray = downSmpImC(y_gray, cret);
    
    %%% ÿһ���߶��ϵ��˻�ͼ����ݶ�ͼ��
    blur_B_tmp = blurred_gray;
    blurred_dy = conv2(blur_B_tmp, dy, 'valid'); %����ֱ�����ģ��ͼ����
    
%       blurred_dx = conv2(blur_B_tmp, dx, 'valid'); 
%         blurred_dg =  blurred_dy+blurred_dx
    
    %%% ÿһ���߶��ϵĻָ�ͼ����ϲ���
    if (s == scale_num) %��ֳ߶���ˮƽ����ֱ�����ϲ��ͼ��ĳ�ʼ��
%         v_dy = blurred_dy;
        u_dy = blurred_dy;
    else %������2�߶��ϵ��ݶ�ͼ��Ϊ�ϳ߶Ȼָ�ͼ����ϲ���
        % upscale the estimated derivative image from previous level
        u_dy = imresize(u_dy, size(blurred_dy), 'bilinear');
    end
%     tic
    %% ====== �ڲ�ͼ���ģ���˵Ľ������ ========================
    for i = 1:5 %
%         fprintf(2,'\nOuter  L0-Regularized imag in the scale: %d\n',s);
        
        %%% ͼ��ָ�
        [u_dy] = img_estimation(blurred_dy, u_dy, kernel, lambda);
        lambda = 0.9*lambda;
        %% Update salient edges
%         u_dy(:,end) = 0;  u_dy(end,:) = 0;
%         u_dy1 = u_dy./norm(u_dy(:));
        
        %% Kernel estimation
%         fprintf('Estimating the blur kernel via FFT\n');
        kernel = psf_estimation(blurred_dy, u_dy, gamma, [ksize_c, ksize_c]);
        kernel =  prunenoise(kernel);
        
        %% ��ʾ�м���
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