%%% PMMWͬʱȥģ��ȥ����
%%% ע: �㷨����ˮƽ�������д���
%%% ��� u��f ʱ������ FFT
function [f,h,out] = Deblurdestripe(g,alpha,belta,gamma,lambda1,lambda2,lambda3,omega,MaxIter)

[N1,N2] = size(g);
%%% ��ʼ�� %%%
f = g; % ���⸳��ֵ
L = 15;
ep = 1e-6;
out.NSDE = [];
k = 0;
Tol = 1e-4;  %%% �����������
StopFlag = 0;
Psi1 = zeros(size(g));
Psi2 = zeros(size(g));
Psi3 = zeros(size(g));
by = zeros(size(g));
b1 = zeros(size(g));
b2 = zeros(size(g));

[D,R] = GenerateFrameletFilter(1);
nD = length(D);

Level = 4;
wLevel = 1/2;
mu = 0.06;
% wLevel = 0.1;
% mu = 0.01;

%Compute the weighted thresholding parameters.
muLevel = getwThresh(mu,wLevel,Level,D);
b = FraDecMultiLevel(f,D,Level);
w = b;

%%% compute fixed quantities
[otfDx,otfDy,conjoDx,conjoDy,Denom1,Denom2] = getC(g);
titleset = {'evolution of the destriped image'};
data = cell( 1, 1);
%%% ��ѭ�� 
while StopFlag == 0
    k = k + 1;
    fold = f;
    
% belta = belta*1.03;
% alpha = alpha*1.02;
    %%% ���º� h
    Demon3 = conj(fft2(f)).* fft2(g) + lambda1* conj(fft2(f)).* Denom1.* fft2(g) + gamma*conjoDx .*fft2(Psi1 - b1) + gamma*conjoDy .*fft2(Psi2 - b2);
    Num3 = conj(fft2(f)).* fft2(f) + lambda1* conj(fft2(f)).* Denom1.* fft2(f) + gamma*(Denom1 + Denom2);
    Fh = Demon3./Num3;
    h = real(otf2psf(Fh,[L,L]));
    delta_t = 0.05;
    ij = h>= delta_t*max(h(:));
    h(~ij) = 0;
    h = h./sum(sum(h));
%     if k==1
%     h1 = h;
%     end
%     if k>1
%         h = h1;
%     end
    %%% (3) �������� Psi1,Psi2
    temp1 = real(otf2psf(otfDx.*psf2otf(h,size(g))));
    temp2 = real(otf2psf(otfDy.*psf2otf(h,size(g))));
    temph = sqrt((temp1+b1).^2 + (temp2+b2).^2 + ep);
    Psi1 = max(temph - omega/gamma,0).*(temp1 + b1)./temph;
    Psi2 = max(temph - omega/gamma,0).*(temp2 + b2)./temph;
    
    %%% ���� b1 b2
    b1 = b1 + temp1 - Psi1;
    b2 = b2 + temp2 - Psi2;
    

    %%% (3) ʹ��FFT���½� f
    for ki=1:Level
        for ji=1:nD-1
            for jj=1:nD-1
                C{ki}{ji,jj} = w{ki}{ji,jj} - b{ki}{ji,jj};
            end
        end
    end

    otfH = psf2otf(h,[N1,N2]);
    Denom4 =  conj(otfH).* fft2(g) + lambda1.*conj(otfH).* Denom1.*fft2(g) + alpha.*conjoDy.*fft2(Psi3 - by)+ belta.* fft2(FraRecMultiLevel(C,R,Level)) ;
    Num4 = abs(otfH).^2 + lambda1.*conj(otfH).* Denom1.*otfH + alpha.*Denom2 + belta;
    Ff = Denom4./Num4 ;
    fnew = real( ifft2( Ff ) ); % compute new f
    f = fnew;
%     f(f<0)=min(min(f(f>0)));
%     f(f>1)=max(max(f(f<1)));
%         lambda1 = lambda1/1.3;
% 
%         lambda2 = lambda2/1.1;
%         alpha = alpha/1.1;

    fnew(fnew<0)=min(min(fnew(fnew>0)));
    fnew(fnew>1)=max(max(fnew(fnew<1)));
if mod(k,10)==0
    figure(5),imshow(fnew',[ ]);
end

    C = FraDecMultiLevel(f,D,Level);
    for ki=1:Level
        for ji=1:nD-1
            for jj=1:nD-1
                w{ki}{ji,jj} = wthresh(C{ki}{ji,jj} + b{ki}{ji,jj},'s',muLevel{ki}{ji,jj}*lambda3/belta);
            end
        end
    end
    
    for ki=1:Level
        for ji=1:nD-1
            for jj=1:nD-1
                if ((ji~=1)||(jj~=1))||(ki==Level)
                    deltab = C{ki}{ji,jj} - w{ki}{ji,jj};
                    b{ki}{ji,jj} = b{ki}{ji,jj} + deltab;
                end
            end
        end
    end
        
    %%% (1) �������� Psi3
    dy = real(ifft2(otfDy.*fft2(f)));
    tempy = abs(dy + by + ep);
    Psi3 = max(tempy - lambda2/alpha,0).*(dy + by)./tempy;

    
    %%% ���� by
    by = by + dy - Psi3;


    %%% Stopping criterions
    fdiff = norm( fold(:) - f(:),'fro')/norm(fold(:),'fro');
    out.NSDE = [out.NSDE; fdiff];
%     fprintf('loop= %d, NSDE= %.4f\n',k,fdiff);
    if k >= MaxIter
        StopFlag = 1;
    elseif fdiff <= Tol
        StopFlag = 2;
    end
    
%     data{1} = f*255;
%     if k == 1
%         evolution_figure = figure;
%         movegui(evolution_figure, 'center');
%         g(1) = imshow(data{1}, []);
%         title(titleset{1}, 'Color', 'r', 'FontSize', 11);
%     else
%         set(g(1), 'CData', data{1});
%     end
%     set(evolution_figure, 'Name', sprintf('[%d--%d]', k, MaxIter), 'NumberTitle', 'Off', 'MenuBar', 'None');
%     pause(0.005);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [otfDx,otfDy,conjoDx,conjoDy,Denom1,Denom2] = getC(g)
% compute fixed quantities
sizeI = size(g);
otfDx = psf2otf([1,-1],sizeI);
otfDy = psf2otf([1;-1],sizeI);
conjoDx = conj(otfDx);
conjoDy = conj(otfDy);
Denom1 = abs(otfDx).^2;
Denom2 = abs(otfDy).^2;