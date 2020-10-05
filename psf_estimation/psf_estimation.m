function psf = psf_estimation(blurred_y, latent_y, weight, psf_size)
% y:  �˻�ͼ��
% h: ģ����
% u: �ָ���ͼ��, Ч����
% h: ���Ƶ�ģ����

% We use a CG method to solve the blur kernel psf
%----------------------------------------------------------------------
% these values can be pre-computed at the beginning of each level
%     blurred_f = fft2(blurred);
%     dx_f = psf2otf([1 -1 0], size(blurred));
%     dy_f = psf2otf([1;-1;0], size(blurred));
%     blurred_xf = dx_f .* blurred_f; %% FFT (Bx)
%     blurred_yf = dy_f .* blurred_f; %% FFT (By)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% latent_xf = fft2(latent_x);
latent_yf = fft2(latent_y);
% blurred_xf = fft2(blurred_x);
blurred_yf = fft2(blurred_y);

%% �����Ҷ��� compute b = sum_i w_i latent_i * blurred_i
b_f = conj(latent_yf)  .* blurred_yf;
b = real(otf2psf(b_f, psf_size)); %ת����Ԥ��PSF��С

%% ���㲿�������
p.m = conj(latent_yf)  .* latent_yf;
LapC = [0 -1 0;-1 4 -1;0 -1 0];
FC = psf2otf(LapC, size(blurred_y));
p.FCTC = conj(FC).*FC;

p.img_size = size(latent_yf);
p.psf_size = psf_size;
p.lambda = weight;

psf = ones(psf_size) / prod(psf_size); %CG����PSF��ʼ��
psf = conjgrad(psf, b, 20, 1e-5, @compute_Ax, p);

psf(psf < max(psf(:))*0.05) = 0;
psf = psf / sum(psf(:));
end

function y = compute_Ax(x, p)
% x: ����Ԥ��PSF��С��PSF
x_f = psf2otf(x, p.img_size); %PSFת����ͼ���С��Ƶ��
y1 = otf2psf(p.m .* x_f, p.psf_size); %ͼ���PSF��Ƶ���������ת����PSF��С�Ŀ���
y2 = otf2psf(p.FCTC .* x_f, p.psf_size); %C^TCh
y = y1 + p.lambda * y2;
end

