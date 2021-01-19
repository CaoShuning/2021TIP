%%% ע: �㷨����ˮƽ�������д���
%%% ��� u ʱ���� FFT
function u = UTVdestripe(f,alpha,belta,lamda,omega1,omega2,MaxIter)

[N1,N2] = size(f);
%%% ��ʼ�� %%%
u = f; % ���⸳��ֵ
g = f; % �۲�ֵ
% Psix = zeros(size(f));
% Psiy = zeros(size(f));

k = 0;
Tol = 1e-4;  %%% �����������
StopFlag = 0;
Psix = 0;
Psiy = 0;
bx = 0;
by = 0;
[M,N] = size(f);
ep = 1e-6;


%%% compute fixed quantities
[conjoDx,conjoDy,num1,Denom1,Denom2] = getC(g);
%%% ��ѭ�� 
while StopFlag == 0,

    k = k + 1;
     %%% (3) ʹ��FFT���½� u
    FPsix = fft2( Psix - bx );
    FPsiy = fft2( Psiy - by );
    FGPx = conjoDx .* FPsix;
    FGPy = conjoDy .* FPsiy; 
    Denom = alpha*Denom1 + belta*Denom2 + 2*omega1;   
    Fu = ( alpha*num1 + alpha* FGPx + belta*FGPy + 2*omega1*fft2(g))./(Denom+ep) ; %%% ���ַ�ĸ�������
    unew = real( ifft2( Fu ) ); % compute new u
  
    udiff = norm( unew(:) - u(:),2 )/norm(u(:));
    u = unew;

    %%% (1) �������� Psix
    temp = diff(u-g,1,2);
    dx = [temp temp(:,N2-1)];   % column diff
    Psixnew = shrink(dx+bx,omega2/alpha);

    
    %%% (2) �������� Psiy
    temp1 = diff(u,1,1);
    dy = [temp1;temp1(N1-1,:)];
    Psiynew = shrink(dy+by,(lamda/belta));

    %%% ���·������ Psix, Psiy
    Psix = Psixnew;
    Psiy = Psiynew;
    
    %%% ���� bx, by
    bx = bx +  (u(:,[2:N,N]) - u) - (g(:,[2:N,N])- g) - Psix;
    by = by + u([2:M,M],:)- u - Psiy;
    
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
