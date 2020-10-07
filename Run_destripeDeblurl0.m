%this is a codo for testing innerloop
clear all; close all; clc;
addpath(genpath('Images\'));
addpath(genpath('psfestimation\'));
addpath(genpath('destriping\'));
addpath(genpath('PROPACK\'));
addpath(genpath('boundary_proc_code\'));
addpath(genpath('framelet\'));
% addpath(genpath('D:\caoshuning\caoshuning\TEST_github\'))
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\real\';
if ~exist(Path_G,'dir')
    mkdir(Path_G)
end

Path_U = 'C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\U\';
if ~exist(Path_U,'dir')
    mkdir(Path_U)
end

Path_S = 'C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\S\';
if ~exist(Path_S,'dir')
    mkdir(Path_S)
end

%% �ڶ��׶Σ���äͼ��ָ�ȥ����
opt.kernel_size =15;   %Ԥ�� PSF��С
%%% ͼ��ָ��Ĳ�������
opt.alphax = 0.01;   %ˮƽ�����ֵĳͷ�����
opt.ax = 0.9;        %alphax = alphax * 0.999;
opt.alphay = 0.005;   %��ֱ�����ֵĳͷ�����
opt.ay = 0.9;        %alphay = alphay * 0.995;
opt.taux = 0.00025;     %ˮƽ�����ֵ����򻯲���
opt.tx = 1;        %taux=taux*1.01;
opt.tauy = 0.0025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
opt.ty = 1;        %tauy = tauy*0.995;
opt.alphaz = 0.1;   %֡���ͷ�����
opt.tauz = 0.5;     %֡������
opt.mu = 0.02;      %���ȷ��������򻯲���
opt.MU = 1;        %opts.mu = opts.mu * 0.995;
opt.miu = 0.06;           %֡������
opt.kernel_size =15;   %Ԥ�� PSF��С
opt.Innerloop_B =5;
opt.tol = 5e-5;  %����ֹͣ���, 1e-6
opt.Level = 4;
opt.frame = 1;
opt.wLevel = 0.5;
opt.Innerloop_B = 5;
opt.MaxIter = 200; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
% rng(1);
% %% �ڶ��׶η�ä�����ȥ�����ָ�ͼ��
% filePath = 'C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\instance\5_30';
% if exist('D:\caoshuning\caoshuning\train107\restore\','dir') == 0
%     mkdir('D:\caoshuning\caoshuning\train107\restore\')
% end
% savePath_u = 'D:\caoshuning\caoshuning\train107\restore\';
% if exist('D:\caoshuning\caoshuning\train107\degrade\','dir') == 0
%     mkdir('D:\caoshuning\caoshuning\train107\degrade\')
% end
% savePath_g = 'D:\caoshuning\caoshuning\train107\degrade\';
% files = dir(fullfile(filePath,strcat('*','.mat')));
% load 'D:\caoshuning\caoshuning\train107\results_a\spot5(2)1.6_9_76.7147_7.0645_dncnn.mat';
% ori = im2double(imread('DestripeReference\spot\spot5(2).tif'));
% [g,K,s] = demo_GenerateBlur(ori, x1, double(x2), stripe_level,RATE, opt.kernel_size);
% imwrite(g,[savePath_g,'spot5(2)','_',num2str(x1),'.tif']);
[file_g, path_g] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\real\*.tif');
[file_k, path_k] = uigetfile('D:\caoshuning\caoshuning\TEST_github\dataset\real\refine_K\*.tif');
g = im2double(imread([path_g,file_g]));
ori = g;
K = im2double(imread([path_k,file_k]));
[u, s] = image_destripe(g,K, ori, opt);
obs_psnr = psnr(ori, g);
res_psnr = psnr(ori, u);
% PSNR = obs_psnr;
% PSNR = res_psnr;
imagesc(u);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_U,file_g(1:end-4),'.eps'],'-r600');
imwrite(u,[Path_U,file_g(1:end-4),'.tif']);

imagesc(s);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_S,file_g(1:end-4),'.eps'],'-r600');
imwrite(s,[Path_S,file_g(1:end-4),'.tif']);
% imwrite(g,[savePath_g,'spot5(2)','_',num2str(x1),'.tif']);

imagesc(g);colormap(gray); axis off; axis equal;
print(gcf,'-depsc2',[Path_G,file_g(1:end-4),'.eps'],'-r600');
imwrite(g,[Path_G,file_g(1:end-4),'.tif']);


