function [u_dy] = img_estimation(blurry_dy, u_dy, h, lambda)
% ���ݶ���ָ�ģ��ͼ��
% lambda: l0�������򻯲���

%% pad image
H = size(blurry_dy,1);    W = size(blurry_dy,2);
blurry_dy_pad = wrap_boundary_liu(blurry_dy, opt_fft_size([H W]+size(h)-1));

% H = size(u_dy,1);    W = size(u_dy,2);
u_dy_pad = wrap_boundary_liu(u_dy, opt_fft_size([H W]+size(h)-1));

%% PSF ��FFT��
Fh = psf2otf(h, size(blurry_dy_pad));

%% �������������� Parameters setting
max_tau = 2^7; %2^5
max_beta = 2^6;    %2^6

%%% d ������
%%% tau: ������ͷ�����, lambda: l0�ݶ�Լ�����򻯲���
tau = 2*lambda;       %Initilize tau: for gradient
% tau = 200*lambda;   
while tau < max_tau
    %%%=============== ���㸨������ d ������ ================================
    %�������� d
    d_temp = conv2c(u_dy_pad, h) - blurry_dy_pad; %����
    d = max(abs(d_temp) - 1/tau, 0).* sign(d_temp);
%     Fd = tau*fft2(d_temp)/(1+tau);
%     d = ifft2(Fd);
    
    %% === �������� p ���ݶ�ͼ�� nabla_y u  ������ =====
    %%% beta: ͼ��l0�����ͷ�����, lambda_0: ͼ��l0�������򻯲���
    beta = 2*lambda; %��ֵbeta��ʼֵ
    while beta < max_beta
        %% p ������
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
    %%% ���¸������� d �ĳͷ�����
    tau = 2*tau; %���³ͷ�����
%      tau = 2000*tau;
end
u_dy = u_dy_pad(1:H, 1:W); %����ԭʼͼ���С
end