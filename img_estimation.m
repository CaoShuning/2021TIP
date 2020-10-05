function [u_dy] = img_estimation(blurry_dy, u_dy, h, lambda)
% 在梯度域恢复模糊图像
% lambda: l0范数正则化参数

%% pad image
H = size(blurry_dy,1);    W = size(blurry_dy,2);
blurry_dy_pad = wrap_boundary_liu(blurry_dy, opt_fft_size([H W]+size(h)-1));

% H = size(u_dy,1);    W = size(u_dy,2);
u_dy_pad = wrap_boundary_liu(u_dy, opt_fft_size([H W]+size(h)-1));

%% PSF 在FFT域
Fh = psf2otf(h, size(blurry_dy_pad));

%% 最大迭代参数设置 Parameters setting
max_tau = 2^7; %2^5
max_beta = 2^6;    %2^6

%%% d 子问题
%%% tau: 数据项惩罚参数, lambda: l0梯度约束正则化参数
tau = 2*lambda;       %Initilize tau: for gradient
% tau = 200*lambda;   
while tau < max_tau
    %%%=============== 计算辅助变量 d 子问题 ================================
    %求辅助变量 d
    d_temp = conv2c(u_dy_pad, h) - blurry_dy_pad; %出错
    d = max(abs(d_temp) - 1/tau, 0).* sign(d_temp);
%     Fd = tau*fft2(d_temp)/(1+tau);
%     d = ifft2(Fd);
    
    %% === 辅助变量 p 和梯度图像 nabla_y u  子问题 =====
    %%% beta: 图像l0范数惩罚参数, lambda_0: 图像l0范数正则化参数
    beta = 2*lambda; %赋值beta初始值
    while beta < max_beta
        %% p 子问题
%         fprintf('Estimating the auxiliary variable p \n');
        p = u_dy_pad;
        t = p.^2 < lambda/beta;
        p(t) = 0;
        
        %%% image gradient nabla_y u sub-problems
        Denormin = tau*abs(Fh).^2 + beta;
        Normin = tau*conj(Fh).*fft2(blurry_dy_pad + d) + beta*fft2(p);
        Fu_dy = Normin./Denormin;
        u_dy_pad = real(ifft2(Fu_dy));
        
        %%% Update the penalization parameter beta for the image u
        beta = 2*beta;
    end
    %%% 更新辅助变量 d 的惩罚参数
    tau = 2*tau; %更新惩罚参数
%      tau = 2000*tau;
end
u_dy = u_dy_pad(1:H, 1:W); %返回原始图像大小
end