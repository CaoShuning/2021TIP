%Main4real
clear all; 
close all;
clc;
%%% 加载文件夹
addpath(genpath('PMMW image\'));

%% 读取或加载图像
[filename1, filepath1, FilterIndex1 ] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\real\*.*','Read image');
I =  imread(fullfile(filepath1,filename1)) ;
[M,N]=size(I);
    if(ndims(I) == 3)
        I= double(rgb2gray(I));
    else
        I = double(I);
    end
%     I = I';
g = I/255;
g = transpose(g); % 将竖条带转换为横条带 
figure; imshow(I,[ ]); title('Striped image');

%%% 参数设置
% alpha = 0.03;  lambda2 = 0.003;   %单方向的约束
% belta = 0.04;    lambda3 = 0.004;   %紧帧波约束
% gamma = 300;  omega = 10;     %总变分核的约束                (机场)
% lambda1 = 10;
% MaxIter = 300;

alpha = 0.4;lambda2 = 0.1;   %单方向的约束
belta = 1; lambda3 = 0.1;   %紧帧波约束
gamma = 200; omega = 5;     %总变分核的约束                 (统一的参数)
lambda1 = 500;
MaxIter = 20;

% alpha = 0.4; lambda2 = 0.01;   %单方向的约束
% belta = 1; lambda3 = 0.1;   %紧帧波约束
% gamma = 200; omega = 5;     %总变分核的约束                 (统一的参数)
% lambda1 = 500;
% MaxIter = 50;

% alpha =1;lambda2 = 0.1;   %单方向的约束
% belta = 10; lambda3 = 1;   %紧帧波约束
% gamma = 500; omega = 10;     %总变分核的约束 
% lambda1 = 100;
% MaxIter = 100;

%%%主程序
tic
[f,h,out] = Deblurdestripe(g,alpha,belta,gamma,lambda1,lambda2,lambda3,omega,MaxIter);
toc
f(f<0)=min(min(f(f>0)));
f(f>1)=max(max(f(f<1)));

%%% 显示结果
uf = f*255;
uf = transpose( uf ); %%% 对真实图像
figure; imshow(uf,[ ]); title('Deblurred image');
figure;imagesc(h);colormap(gray);axis image;axis off;
figure;surf(h);
figure;plot(1:length(out.NSDE),out.NSDE,'linewidth',2);
xlabel('Iteration number');
ylabel('NSDE');

% imwrite(uf./255,'D:\caoshuning\caoshuning\TEST_github\result65\Chang\Chang_u.tif');