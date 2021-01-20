%%% PMMW融合的的去条带与去模糊算法
%%% 具体算法文档: <<毫米波图像去条带与去模糊同时进行>>.
%%% 注: 算法均对竖直条带进行处理
clear all; 
close all;
clc;
%%% 加载文件夹
addpath(genpath('PMMW image\'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\Degrade1226\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));
%save path
Path_U = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Chang\1226\U\';%U
if ~exist(Path_U,'dir')
    mkdir(Path_U)
end

Path_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Chang\1226\S\';%U
if ~exist(Path_S,'dir')
    mkdir(Path_S)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 读取或加载图像
for i = 1:length(Gs)
    ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
    g = im2double(imread([Path_G, Gs(i).name]));
        if(ndims(g) == 3)
            I= double(rgb2gray(g));
        else
            g = double(g);
        end
    g = transpose(g); % 将竖条带转换为横条带 

    %%% 参数设置
    % alpha = 0.03;  lambda2 = 0.003;   %单方向的约束
    % belta = 0.04;    lambda3 = 0.004;   %紧帧波约束
    % gamma = 300;  omega = 10;     %总变分核的约束                (机场)
    % lambda1 = 10;
    % MaxIter = 300;

%     alpha = 0.4;lambda2 = 0.1;   %单方向的约束
%     belta = 1; lambda3 = 0.1;   %紧帧波约束
%     gamma = 200; omega = 5;     %总变分核的约束                 (统一的参数)
%     lambda1 = 500;
%     MaxIter = 20;

    % alpha =1;lambda2 = 0.1;   %单方向的约束
    % belta = 10; lambda3 = 1;   %紧帧波约束
    % gamma = 500; omega = 10;     %总变分核的约束 
    % lambda1 = 100;
    % MaxIter = 100;
    stripe_level = str2double( Gs(i).name(end-5:end-4));
    SIG = str2double( Gs(i).name(end-9:end-7));
    [opt] = Paraset(stripe_level,SIG);

    alpha = opt.alpha; lambda2 = opt.lambda2;%单方向的约束
    belta = opt.belta; lambda3 = opt.lambda3;   %紧帧波约束
    gamma = opt.gamma; omega = opt.omega;     %总变分核的约束                 (统一的参数)
    lambda1 = opt.lambda1;
    MaxIter = opt.MaxIter;
    %%%主程序
%     tic
    [f,h,out] = Deblurdestripe(g,alpha,belta,gamma,lambda1,lambda2,lambda3,omega,MaxIter);
%     toc
    f(f<0)=min(min(f(f>0)));
    f(f>1)=max(max(f(f<1)));
    u = f';
    
    obs_psnr = psnr(ori, g');
    obs_ssim = ssim(ori, g');
    res_psnr = psnr(ori, u);
    res_ssim = ssim(ori, u);
    fprintf(['Proposed ','image:(spot5: ',Gs(i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
    ' PSNR_u = %2.4f,',' SSIM_u = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
    
    imagesc(u);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_U,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(u,[Path_U,Gs(i).name(1:end-4),'.tif']);
    close all; 
%     imagesc(s);colormap(gray); axis off; axis equal;
%     print(gcf,'-depsc2',[Path_est_S,Gs(file_i).name(1:end-4),'.eps'],'-r600')
%     imwrite(s,[Path_est_S,Gs(file_i).name(1:end-4),'.tif']);
end