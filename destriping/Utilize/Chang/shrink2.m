function [dy] = shrink2(dy,Thresh)
%SHRINK2   Vectorial shrinkage (soft-threholding)
%   [dxnew,dynew] = SHRINK2(dx,dy,Thresh)

s = abs( dy );
% s = max(s - Thresh,0)./max(1e-12,s);
% dy = s.*dy;
dy = max(s - Thresh,0).*sign(dy);
