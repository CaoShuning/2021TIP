function result = adpative_FFT( component,numlev,k )
vd = component;
for i=1:numlev
   % FFT
   fvd=fft(vd{i});
   fr{i} = fvd;
   [ysz,xsz] = size(fvd);

%mean without extreme
vert = vd{i};
ref = mean2(vert);
sd = std2(vert);
fac = zeros(1,xsz); %=(Cavg-Cavgexcluding)/Cavg
mini = min(min(vert));
extr = vert;
%if (numlev > 2)
for j=1:xsz
     clm = vert(:,j);
    Cavg = mean(clm);
    %compute 3 column mean
    if ((j~=1)&&(j~=xsz))
        clm3 = vert(:,j-1:j+1);
        avg3 = mean(clm3);
    else
        avg3 = Cavg;
    end

    csd = std(clm);
    csel = ones(ysz,1); %column pixel selection
    %extr = 0; %no of extreme pixels
    for rr=1:ysz
        dev = abs(clm(rr)-Cavg);
        dev = abs(clm(rr)-avg3);
        if (dev > k*sd)
            csel(rr)=0;
            extr(rr,j) =mini-2*sd; %assigning darkest values to extreme pixels
            %extr = extr+1;
        end
    end
    Cavg2 = sum(clm.*csel)/sum(csel);
    fac(j)=(Cavg-Cavg2)/Cavg;
   % vert2(:,j)= vert(:,j)+(ref-Cavg2);
end
%end % end if

  
   fvd(1,:)=fvd(1,:).*fac;
   fvdshft = fftshift(fvd,1);
   norm{i}=fvd;

   % inverse FFT
   vd{i} =ifft(fvd);
   result = vd;
end