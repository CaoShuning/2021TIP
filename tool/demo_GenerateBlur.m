function [g,k,s] = demo_GenerateBlur(I,SIG,SIZ,s_level,pad)
% clc,clear;
% filename = 'spot6.png';
% img = imread(filename);
% I = im2double(img);

[f,k] = AddBlur(I,SIZ,SIG,pad);
% [g s] = AddStripe(f,5)
% g = NonPeriodical_Simulated(f,0.3,s_level/256);
g = Periodical_Simulated(f,10,0.3,s_level./255);
s = g - f;
% NonP_Stripe   =  NonPeriodical_Simulated(f,rate,men)
% P_Stripe   =  Periodical_Simulated(f,Perio,rate,mean)
% s = g - f; 
end
% subplot(2,2,1);imshow(I);
% subplot(2,2,2);imshow(g);
% subplot(2,2,3);imagesc(s);colormap(gray)
% imwrite(g,'C:\Users\asus\Desktop\TEST\dataset\spot6\5x5 sig=2.1 periodic 10_0.2 30.tif');
% 
% miu1 = mean2(I);
% miu2 = mean2(f);
% miu3 = mean2(g);
% 
% sig1 = std2(I);
% sig2 = std2(f);
% sig3 = std2(g);
