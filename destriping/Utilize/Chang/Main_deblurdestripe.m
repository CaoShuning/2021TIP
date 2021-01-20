%%% PMMW融合的的去条带与去模糊算法
%%% 具体算法文档: <<毫米波图像去条带与去模糊同时进行>>.
%%% 注: 算法均对竖直条带进行处理
clear all; 
close all;
clc;
%%% 加载文件夹
addpath(genpath('PMMW image\'));

%% 读取或加载图像
%% 读取或加载图像
Path_Ori = 'D:\caoshuning\code_DestripeDeblur\Data\ori\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\code_DestripeDeblur\Data\simulation\19-Jan-2021\G\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

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

Path_est_S = ['C:\Users\caoshuning\Desktop\Submit_text\result\simulation\',Method,'\',date ,'\est_S\'];%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S)
end

alpha = 0.4;lambda2 = 0.1;   %单方向的约束
belta = 1; lambda3 = 0.1;   %紧帧波约束
gamma = 200; omega = 5;     %总变分核的约束                 (统一的参数)
lambda1 = 500;
MaxIter = 20;

for i = 1:length(Gs)  
    ori = im2double(imread([Path_Ori, Gs(i).name(1),'.tif']));
    g = imread([Path_G, Gs(i).name]);
    [M,N]=size(g);
    if(ndims(g) == 3)
        g= double(rgb2gray(g));
    else
        g = double(g);
    end
%     I = I';
    g = g/255;
    g = transpose(g); % 将竖条带转换为横条带 
%     figure; imshow(g,[ ]); title('Striped image');
    [u,h,out] = Deblurdestripe(g,alpha,belta,gamma,lambda1,lambda2,lambda3,omega,MaxIter);
    % toc

    u(u<0)=min(min(u(u>0)));
    u(u>1)=max(max(u(u<1)));

%     %%% 显示结果
%     uf = f*255;
%     uf = transpose( uf ); %%% 对真实图像
%     figure; imshow(uf,[ ]); title('Deblurred image');
%     figure; imshow(h,[ ]); title('The kernal');
%     figure;plot(1:length(out.NSDE),out.NSDE,'linewidth',2);
%     figure;imagesc(h);colormap(gray);axis image;axis off;
%     figure;surf(h);
%     xlabel('Iteration number');
%     ylabel('NSDE');

    obs_psnr = psnr(ori, g');
    obs_ssim = ssim(ori, g');
    res_psnr = psnr(ori, u');
    res_ssim = ssim(ori, u');
    fprintf(['Proposed ','image:(spot5: ',Gs(i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
        ' PSNR_u = %2.4f,',' SSIM_u = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);
    % imwrite(uf./255,'D:\caoshuning\caoshuning\TEST_github\result65\Chang\Chang_u.tif');
    imagesc(u');colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_uF,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(u',[Path_uF,Gs(i).name(1:end-4),'.tif']);

    imagesc(h);colormap(gray); axis off; axis equal;
    print(gcf,'-depsc2',[Path_h,Gs(i).name(1:end-4),'.eps'],'-r600')
    imwrite(h,[Path_h,Gs(i).name(1:end-4),'.tif']);
    
%     imagesc(s);colormap(gray); axis off; axis equal;
%     print(gcf,'-depsc2',[Path_est_S,Gs(i).name(1:end-4),'.eps'],'-r600')
%     imwrite(s,[Path_est_S,Gs(i).name(1:end-4),'.tif']);
    close all;
end