clear all; 
% close all;
clc;
%%% 加载文件夹
addpath(genpath('images\'));

%% 读取或加载图像
[filename, filepath, FilterIndex ] = uigetfile('images/*.*','Read image');
I = double( imread(fullfile(filepath,filename)) );
figure; imshow(uint8(I));
% [m,n] =size(I);
% for i=2:10:n-4
%     I(:,i)=I(:,i)+30;
% end
% figure; imshow(uint8(I));
I1 = I(100:611,1:512);
I2 = I(400:911,1:512);
I3 = I(600:1111,200:711);
I4 = I(300:811,300:811);
I5 = I(800:1311,1:512);
I6 = I(500:1011,1000:1511);
I7 = I(300:811,1500:2011);
I8 = I(600:1111,1400:1911);
I9 = I(700:1211,1200:1711);
I10 = I(800:1311,900:1411);

% I1 = I1';
% I2 = I2';
% I3 = I3';
% I4 = I4';
% I5 = I5';
% I6 = I6';
% I7 = I7';
% I8 = I8';
% I9 = I9';
% I10 = I10';

[m,n]=size(I1);
Grad1 = zeros(m,n);
Grad2 = zeros(m,n);
Grad3 = zeros(m,n);
Grad4 = zeros(m,n);
Grad5 = zeros(m,n);
Grad6 = zeros(m,n);
Grad7 = zeros(m,n);
Grad8 = zeros(m,n);
Grad9 = zeros(m,n);
Grad10 = zeros(m,n);

for i=1:n-1
   Grad1(:,i) = I1(:,i+1)-I1(:,i);
   Grad2(:,i) = I2(:,i+1)-I2(:,i);
   Grad3(:,i) = I3(:,i+1)-I3(:,i);
   Grad4(:,i) = I4(:,i+1)-I4(:,i);
   Grad5(:,i) = I5(:,i+1)-I5(:,i);
   Grad6(:,i) = I6(:,i+1)-I6(:,i);
   Grad7(:,i) = I7(:,i+1)-I7(:,i);
   Grad8(:,i) = I8(:,i+1)-I8(:,i);
   Grad9(:,i) = I9(:,i+1)-I9(:,i);
   Grad10(:,i) = I10(:,i+1)-I10(:,i); 
end

Grad1(:,n) = Grad1(:,n-1);
Grad2(:,n) = Grad2(:,n-1);
Grad3(:,n) = Grad3(:,n-1);
Grad4(:,n) = Grad4(:,n-1);
Grad5(:,n) = Grad5(:,n-1);
Grad6(:,n) = Grad6(:,n-1);
Grad7(:,n) = Grad7(:,n-1);
Grad8(:,n) = Grad8(:,n-1);
Grad9(:,n) = Grad9(:,n-1);
Grad10(:,n) = Grad10(:,n-1);

hist1 = histf( Grad1 );
hist2 = histf( Grad2 );
hist3 = histf( Grad3 );
hist4 = histf( Grad4 );
hist5 = histf( Grad5 );
hist6 = histf( Grad6 );
hist7 = histf( Grad7 );
hist8 = histf( Grad8 );
hist9 = histf( Grad9 );
hist10 = histf( Grad10 );

temp(1,:) = -255:255;
temp(2,:) = 0;
temp1 = temp';
temp2 = temp';
temp3 = temp';
temp4 = temp';
temp5 = temp';
temp6 = temp';
temp7 = temp';
temp8 = temp';
temp9 = temp';
temp10 = temp';


for i=1:size(hist1,1)
     temp1(256+hist1(i,1),2) = 512*512*hist1(i,2);
end

for i=1:size(hist2,1)
     temp2(256+hist2(i,1),2) = 512*512*hist2(i,2);
end

for i=1:size(hist3,1)
     temp3(256+hist3(i,1),2) = 512*512*hist3(i,2);
end

for i=1:size(hist4,1)
     temp4(256+hist4(i,1),2) = 512*512*hist4(i,2);
end

for i=1:size(hist5,1)
     temp5(256+hist5(i,1),2) = 512*512*hist5(i,2);
end

for i=1:size(hist6,1)
     temp6(256+hist6(i,1),2) = 512*512*hist6(i,2);
end

for i=1:size(hist7,1)
     temp7(256+hist7(i,1),2) = 512*512*hist7(i,2);
end

for i=1:size(hist8,1)
     temp8(256+hist8(i,1),2) = 512*512*hist8(i,2);
end

for i=1:size(hist9,1)
     temp9(256+hist9(i,1),2) = 512*512*hist9(i,2);
end

for i=1:size(hist10,1)
     temp10(256+hist10(i,1),2) = 512*512*hist10(i,2);
end

temp0(:,2) = (temp1(:,2) + temp2(:,2) + temp3(:,2) + temp4(:,2) + temp5(:,2) + temp6(:,2) + temp7(:,2) + temp8(:,2) + temp9(:,2) + temp10(:,2))/(512*512*10);
temp0(:,1) = temp1(:,1);

x=-255:255;
figure,plot(x,log(temp0(:,2)))
figure,plot(x,temp0(:,2))
x1 = 0:255;
kk = log(temp0(256:511,2));












