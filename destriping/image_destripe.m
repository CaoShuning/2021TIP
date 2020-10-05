function [u,S] = image_destripe(g, h, ori, opt)
% Y: �˻�ͼ��
% h: ģ����
% U: �ָ���ͼ��
% S: ���Ƶ�����

%% initialization
[m,n] = size(g);
u = g;
S  = zeros(m,n);
dx = zeros(m,n);  %ˮƽ�����ָ�������
bx = zeros(m,n);  %ˮƽ����Bregman����
dy = zeros(m,n);  %��ֱ�����ָ�������
by = zeros(m,n);  %��ֱ����Bregman����
[conjoDx,conjoDy,Denom1,Denom2] = getC(g);

Fh  = psf2otf(h, size(g));

dxf = [1,-1];
otfDx = psf2otf(dxf,size(g));
dyf = [1;-1];
otfDy = psf2otf(dyf,size(g));
% dyyf = [-1; 2; -1];
% otfDyy = psf2otf(dyyf,size(Y));

%%% ��������
alphax = opt.alphax;
alphay = opt.alphay;
alphaz = opt.alphaz;
taux = opt.taux;
tauy = opt.tauy;
tauz = opt.tauz;
% mu = opt.mu;
% gamma = 1.0;

%% Compute the weighted thresholding parameters.
Level = opt.Level;
% Level = 10;
frame = opt.frame;

wLevel = opt.wLevel;
% mu = 0.01;
% wLevel = 0.1;
miu = opt.miu;
% wLevel = 0.3;

[D,R] = GenerateFrameletFilter(frame);% choose wavelet basis by hand according to different Frame.
muLevel = getwThresh(miu,wLevel,Level,D);
bz = FraDecMultiLevel(u,D,Level);
dz = bz;
nD = length(D);
%% ======================  main =================================
PSNR_N = [];
SSIM_N = [];
N = [];
StopFlag = 0;
iter = 0;
while StopFlag == 0
    

    iter = iter + 1;
    uold = u;
    
    %% ����ͼ�� s- ������, �ò���ʵ�ֲ���GuShuhang�ļ�Ȩ����ʵ��
        Hu = conv2c(u,h); %good
        S = SVD_shrink(g, Hu, 'svds', opt );

        %% Ǳ��ͼ�� u - subproblem
        for ki=1:Level
            for ji=1:nD-1
                for jj=1:nD-1
                    C{ki}{ji,jj} = dz{ki}{ji,jj} - bz{ki}{ji,jj}; %dy-Sy
                end
            end
        end
        WTC = FraRecMultiLevel(C,R,Level); % W^T(dy-Sy)
        FWTC = fft2(WTC);
%         dy1 = [-1 0; 1 0];
%         FSy=fft2(conv2(S,dy1,'same'));
%         FW = FWTC/fft2(otfDy-FSy);
        numerator = conj(Fh).*fft2(g - S) + alphax * conjoDx.*fft2(dx-bx) + alphay * conjoDy.*fft2(dy-by) + alphaz * FWTC;
        denominator = abs(Fh).^2 + alphax*Denom1 + alphay*Denom2 + alphaz;%*FW*conj(FW);%miss FW.FW(T)
        Fu = numerator./denominator;
        u = real( ifft2( Fu ) ); %compute new u
        
        u(u<0) = min(min(u>0));
        u(u>1) = max(max(u<1));
%             u(u<0) = 0;
%         u(u>1) = 1;
        %% ˮƽ�����ָ������� dx ������
        diffx = real(ifft2(otfDx.*fft2(u))); %colomn diff, ˮƽ������,�����
%         eta1 = gamma*std(diffx(:));
%         w_ux = 1./(1 + abs(diffx).^2/eta1);
        dx = soft_shrink(diffx + bx, taux/alphax);
        
        %% ��ֱ�����ָ������� dy ������
        diffy = real(ifft2(otfDy.*fft2(u))); %colomn diff, ˮƽ������,�����
%         eta1 = gamma*std(diffx(:));
%         w_ux = 1./(1 + abs(diffx).^2/eta1);
        dy = soft_shrink(diffy + by, tauy/alphay);
        
        %% ��ֱ�����ָ������� dy ������
        C = FraDecMultiLevel(u,D,Level); %Wu
        for ki=1:Level
            for ji=1:nD-1
                for jj=1:nD-1
                    dz{ki}{ji,jj} = wthresh(C{ki}{ji,jj} + bz{ki}{ji,jj},'s',muLevel{ki}{ji,jj}.*alphaz/tauz);
                end
            end
        end
        
        %% Update bx �� by 
        bx = bx + diffx - dx;
        by = by + diffy - dy;
        
        %%% ���� bz
        for ki=1:Level
            for ji=1:nD-1
                for jj=1:nD-1
                    if ((ji~=1)||(jj~=1))||(ki==Level)
                        deltab = C{ki}{ji,jj} - dz{ki}{ji,jj};
                        bz{ki}{ji,jj} = bz{ki}{ji,jj} + deltab;
                    end
                end
            end
        end
        u(u<0) = min(min(u>0));
        u(u>1) = max(max(u<1));

%         %% ���³ͷ�����
%       if iter <= 350  
%         alphax = alphax * opt.ax;
%         taux=taux *  opt.tx;
%         alphay = alphay * opt.ay;
%         tauy = tauy * opt.ty;
%         opt.mu = opt.mu * opt.MU;
%       end

    %% ����ÿ�ε���ͼ��� PSNR
    if exist('ori','var')
        psnrn = psnr(ori, u);
        PSNR_N = [PSNR_N; psnrn];
        
    figure(1); plot(1:length(PSNR_N),PSNR_N); xlabel('Iterations');ylabel('PSNR');
    end
    if exist('ori','var')
        ssimn = ssim(ori, u);
        SSIM_N = [SSIM_N; ssimn];
        
    figure(2); plot(1:length(SSIM_N),SSIM_N); xlabel('Iterations');ylabel('SSIM');
    end
    %% stopping criterion
    RelChg_u = norm(u-uold,'fro') / norm(u,'fro');
    N = [N;RelChg_u];
     figure(3); plot(1:length(N),N,'linewidth',2); xlabel('Iterations');ylabel('NSDE');
     if rem(iter,1)==0
    figure(4);imshow(mat2gray(u)); title(sprintf('iter:%d,RelErr:%.8f',iter,RelChg_u));drawnow;
     end
    if RelChg_u < opt.tol
%         fprintf('The convergence is reached at %dth iteration!\n',iter);
        StopFlag = 1;
    elseif iter > opt.MaxIter
%         fprintf('The maximum iterations %d is reached!\n',opt.MaxIter);
        StopFlag = 2;
    end
end
        u(u<0) = min(min(u>0));
        u(u>1) = max(max(u<1));
end
% close all;

function [conjoDx,conjoDy,Denom1,Denom2] = getC(f)
% compute fixed quantities
sizeI = size(f);
otfDx = psf2otf([1,-1],sizeI);
otfDy = psf2otf([1;-1],sizeI);
conjoDx = conj(otfDx);
conjoDy = conj(otfDy);
Denom1 = abs(otfDx).^2;
Denom2 = abs(otfDy).^2;
end
