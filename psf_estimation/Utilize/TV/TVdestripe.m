%%% ���ڶ����������ȫ��ϡ��������ȥ�����㷨
%%% ע: �㷨����ˮƽ�������д���
%%% ��� u ʱ���� FFT
function u = TVdestripe(f,I,belta,lamda,omega1,MaxIter)

[N1,N2] = size(f);
%%% ��ʼ�� %%%
u = f; % ���⸳��ֵ
g = f; % �۲�ֵ
k = 0;
Tol = 1e-5;  %%% �����������
StopFlag = 0;
Psiy = 0;
Psix2 = 0;
by = 0;
bx2 = 0;
[M,N] = size(f);
ep = 1e-6;

%%% compute fixed quantities
[conjoDx,conjoDy,num1,Denom1,Denom2] = getC(g);
%%% ��ѭ�� 
while StopFlag == 0,

    k = k + 1;
    

     %%% (3) ʹ��FFT���½� u
    FPsiy = fft2( Psiy - by );
    FPsix2 = fft2(Psix2 - bx2);
    FGPy = conjoDy .* FPsiy;
    FGPx2 = conjoDx .*FPsix2;
    
    Denom =  belta*(Denom1 + Denom2) +2*omega1;   
    Fu = (  belta*FGPy +belta*FGPx2 + 2*omega1*fft2(g))./Denom ; 
    unew = real( ifft2( Fu ) ); % compute new u

    udiff = norm( unew(:) - u(:),2 )/norm(u(:));
    u = unew;

    %%% (2) �������� Psiy,Psix2
    temp1 = diff(u,1,1);
    dy = [temp1;temp1(N1-1,:)];
    temp2 = diff(u,1,2);
    dx2 = [temp2 temp2(:,N2-1)];
    tempf = sqrt((dx2 + bx2).^2 + (dy + by).^2  + ep);
    Psix2new = max(tempf - lamda/belta,0).*(dx2 + bx2)./tempf;
    Psiynew = max(tempf - lamda/belta,0).*(dy + by)./tempf;
    
    Psiy = Psiynew;
    Psix2 = Psix2new;
    
    %%% ���� bx, by
    by = by + u([2:M,M],:)- u - Psiy;
    bx2 = bx2 + u(:,[2:N,N]) - u - Psix2;

    %%% Stopping criterions
    if k >= MaxIter
        StopFlag = 1;
    elseif udiff <= Tol
        StopFlag = 2;
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [conjoDx,conjoDy,num1,Denom1,Denom2] = getC(g)
% compute fixed quantities
sizeI = size(g);
otfDx = psf2otf([1,-1],sizeI);
otfDy = psf2otf([1;-1],sizeI);
conjoDx = conj(otfDx);
conjoDy = conj(otfDy);
num1 = abs(otfDx).^2.*fft2(g);
Denom1 = abs(otfDx).^2;
Denom2 = abs(otfDy).^2;
