%this is a code for jointly non-blind deblurring ande destriping for
%simulated data
clc; clear all; close all; 
addpath(genpath('Images\'));
addpath(genpath('psfestimation\'));
addpath(genpath('destriping\'));
addpath(genpath('PROPACK\'));
addpath(genpath('boundary_proc_code\'));
addpath(genpath('framelet\'));
% addpath(genpath('D:\caoshuning\caoshuning\TEST_github\'))
%% 第二阶段：非盲图像恢复去条带
%para setting
opt.alphax = 0.0001;   %水平方向差分的惩罚参数
opt.ax = 1.1;        %alphax = alphax * 0.999;
opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
opt.ay = 1.1;        %alphay = alphay * 0.995;
opt.taux = 0.0000025;     %水平方向差分的正则化参数
opt.tx = 1;        %taux=taux*1.01;
opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
opt.ty = 1;        %tauy = tauy*0.995;
opt.alphaz = 0.001;   %帧波惩罚参数
opt.tauz = 0.005;     %帧波正则化
opt.mu = 0.002;      %低秩分量的正则化参数
opt.MU = 1;        %opts.mu = opts.mu * 0.995;
opt.miu = 0.06;           %帧波参数
opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
opt.Level = 4;
opt.frame = 1;
opt.wLevel = 0.5;
%para setting
% opt = Para2(stripe_level, SIG);
opt.kernel_size =15;   %预估 PSF大小
opt.Innerloop_B =5;
opt.tol = 5e-5;  %迭代停止误差, 1e-6
%% 第二阶段非盲反卷积去条带恢复图像
% filePath = 'C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\instance\5_30';
% if exist('D:\caoshuning\caoshuning\train107\restore\','dir') == 0
%     mkdir('D:\caoshuning\caoshuning\train107\restore\')
% end
% savePath_u = 'D:\caoshuning\caoshuning\train107\restore\';
% if exist('D:\caoshuning\caoshuning\train107\degrade\','dir') == 0
%     mkdir('D:\caoshuning\caoshuning\train107\degrade\')
% end
% savePath_g = 'D:\caoshuning\caoshuning\train107\degrade\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load degradation images kernel
% [file, path] = uigetfile('*.png');              %get degraded image
Path_ori = 'D:\caoshuning\caoshuning\spot5\gt\';

% Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\G\';
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\spot5(1)-degradation\';
suffix = '.tif';
Gs = dir(fullfile(Path_G,strcat('*',suffix)));

Path_K = 'D:\caoshuning\caoshuning\TEST_github\dataset\degradation2098\Nonperiodical\K\';
suffix = '.tif';
Ks = dir(fullfile(Path_K,strcat('*',suffix)));

% Path_Hr = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\h_refine\';%h_refine
Path_Hr = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\h_refine_1001\';%h_refine
suffix = '.mat';
Hrs = dir(fullfile(Path_Hr,strcat('*',suffix)));

Path_H = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\h\';%h

suffix = '.mat';
H = dir(fullfile(Path_H,strcat('*',suffix)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save path
Path_est_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\est_S_1001\';%est_S
if ~exist(Path_est_S,'dir')
    mkdir(Path_est_S);
end
Path_U = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\Proposed\U_1001\';%U
if ~exist(Path_U,'dir')
    mkdir(Path_U);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(Gs)
    ori = im2double(imread([Path_ori, Gs(i).name(1),'.tif']));
    load([Path_Hr, 'h',Gs(i).name(1:end-4), '_dncnn.mat']);
    K = im2double(imread([Path_K, Gs(i).name]));
    h = im2double(imread([Path_H, 'h_', Gs(i).name]));
    G = im2double(imread([Path_G, Gs(i).name]));
    stripe_level = str2double(Gs(i).name(end-9:end-8));
%     opt = Para(stripe_level);
    SIG = str2double(Gs(i).name(end-15:end-13));
%     if  (SIG == 2.1)&&((stripe_level == 30)||(stripe_level == 20))
    if  (SIG == 2.1)&&(stripe_level ~= 30)
        [opt] = Para2(stripe_level, SIG);
        [u, s] = image_destripe(G,h_refine, ori, opt);
        obs_psnr = psnr(ori, G);
        obs_ssim = ssim(ori, G);
        res_psnr = psnr(ori, u);
        res_ssim = ssim(ori, u);
        fprintf(['Proposed ','image:(spot5: ',Gs(i).name,'),',' PSNR_g = %2.4f,',' SSIM_g = %2.4f,',...
        ' PSNR_u = %2.4f,',' SSIM_u = %2.4f\n'],obs_psnr,obs_ssim,res_psnr,res_ssim);

        imagesc(u);colormap(gray); axis off; axis equal;
        print(gcf,'-depsc2',[Path_U,Gs(i).name(1:end-4),'.eps'],'-r600')
        imwrite(u,[Path_U,Gs(i).name(1:end-4),'.tif']);

        imagesc(s);colormap(gray); axis off; axis equal;
        print(gcf,'-depsc2',[Path_est_S,Gs(i).name(1:end-4),'.eps'],'-r600')
        imwrite(s,[Path_est_S,Gs(i).name(1:end-4),'.tif']);
    
    end
    close all;
end
% 
% imagesc(u);colormap(gray); axis off; axis equal;
% print(gcf,'-depsc2',[savePath_u,'spot5(2)','_',num2str(x1),'.eps'],'-r600')
% % imagesc(g);colormap(gray); axis off; axis equal;
% % print(gcf,'-depsc2',[savePath_g,'spot5(2)','_',num2str(x1),'.eps'],'-r600')
% imwrite(u,[savePath_u,'spot5(2)','_',num2str(x1),'.tif']);
% % imwrite(g,[savePath_g,'spot5(2)','_',num2str(x1),'.tif']);



