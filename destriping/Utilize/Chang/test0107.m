%%% PMMW�ںϵĵ�ȥ������ȥģ���㷨
%%% �����㷨�ĵ�: <<���ײ�ͼ��ȥ������ȥģ��ͬʱ����>>.
%%% ע: �㷨������ֱ�������д���
clear all; 
close all;
clc;
%%% �����ļ���
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
g = transpose(g); % ��������ת��Ϊ������ 
figure; imshow(I,[ ]); title('Striped image');

%%% ��������
% alpha = 0.03;  lambda2 = 0.003;   %�������Լ��
% belta = 0.04;    lambda3 = 0.004;   %��֡��Լ��
% gamma = 300;  omega = 10;     %�ܱ�ֺ˵�Լ��                (����)
% lambda1 = 10;
% MaxIter = 300;

alpha = 0.004;lambda2 = 0.001;   %�������Լ��
belta = 1; lambda3 = 0.1;   %��֡��Լ��
gamma = 200; omega = 5;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
lambda1 = 500;
MaxIter = 20;

% 
% alpha = opt.alpha; lambda2 = opt.lambda2;%�������Լ��
% belta = opt.belta; lambda3 = opt.lambda3;   %��֡��Լ��
% gamma = opt.gamma; omega = opt.omega;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
% lambda1 = opt.lambda1;
% MaxIter = opt.MaxIter;
% 
% alpha =1;lambda2 = 0.1;   %�������Լ��
% belta = 10; lambda3 = 1;   %��֡��Լ��
% gamma = 500; omega = 10;     %�ܱ�ֺ˵�Լ�� 
% lambda1 = 100;
% MaxIter = 100;

%%%������
tic
[f,h,out] = Deblurdestripe(g,alpha,belta,gamma,lambda1,lambda2,lambda3,omega,MaxIter);
toc
f(f<0)=min(min(f(f>0)));
f(f>1)=max(max(f(f<1)));

%%% ��ʾ���
uf = f*255;
uf = transpose( uf ); %%% ����ʵͼ��
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

