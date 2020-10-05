function res = zpad(x,sx,sy,sz)
%res = zpad(x,sx,sy)
%
%  Zero pads a 2D matrix around its center.
%
% (c) Michael Lustig 2007
if nargin == 3
    sz = 1;
end
[mx,my,mz] = size(x);
res = zeros(sx,sy,sz);


idxx = sx/2+1-mx/2 : sx/2+mx/2;
idxy = sy/2+1-my/2 : sy/2+my/2;

idxx = round(idxx);
idxy = round(idxy);
res(idxx,idxy,:) = x;

