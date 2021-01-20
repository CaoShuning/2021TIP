%%% PMMW融合的的去条带与去模糊算法
%%% 具体算法文档: <<毫米波图像去条带与去模糊同时进行>>.
%%% 注: 算法均对竖直条带进行处理
clear all; 
close all;
clc;
%%% 加载文件夹
addpath(genpath('PMMW image\'));

[Gname, Path_g] = uigetfile('D:\caoshuning\code_DestripeDeblur\Data\simulation\0105\G\*.tif');
[Oriname, Path_ori] = uigetfile('D:\caoshuning\code_DestripeDeblur\Data\ori\*.tif');

I = im2double(imread([Path_g, Gname]));
ori = im2double(imread([Path_ori, Oriname]));


%save path
Method = ['Chang'];

Path_uF = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\U\'];%U
if ~exist(Path_uF,'dir')
    mkdir(Path_uF)
end
Path_h = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date,'\k\'];%K
if ~exist(Path_h,'dir')
    mkdir(Path_h)
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

alpha = 0.004;lambda2 = 0.001;   %单方向的约束
belta = 1; lambda3 = 0.1;   %紧帧波约束
gamma = 200; omega = 5;     %总变分核的约束                 (统一的参数)
lambda1 = 500;
MaxIter = 20;

% 
% alpha = opt.alpha; lambda2 = opt.lambda2;%单方向的约束
% belta = opt.belta; lambda3 = opt.lambda3;   %紧帧波约束
% gamma = opt.gamma; omega = opt.omega;     %总变分核的约束                 (统一的参数)
% lambda1 = opt.lambda1;
% MaxIter = opt.MaxIter;
% 
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
figure; imshow(h,[ ]); title('The kernal');
figure;plot(1:length(out.NSDE),out.NSDE,'linewidth',2);
figure;imagesc(h);colormap(gray);axis image;axis off;
figure;surf(h);
xlabel('Iteration number');
ylabel('NSDE');


imagesc(uf);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_uF,Gname(1:end-4),'.eps'],'-r600')
imwrite(uf,[Path_uF,Gname(1:end-4),'.tif']);

imagesc(h);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_h,Gname(1:end-4),'.eps'],'-r600')
imwrite(h,[Path_h,Gname(1:end-4),'.tif']);

obs_psnr = psnr(ori, g);
obs_ssim = ssim(ori, g);
res_psnr = psnr(ori, uf);
res_ssim = ssim(ori, uf);
fprintf(['Proposed ','image:(spot5: ',Gname,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
' PSNR_f = %2.4f,',' SSIM_f = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);

