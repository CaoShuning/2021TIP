%Main4real
clear all; 
close all;
clc;
%%% �����ļ���
addpath(genpath('PMMW image\'));

%% ��ȡ�����ͼ��
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
g = transpose(g); % ��������ת��Ϊ������ 
figure; imshow(I,[ ]); title('Striped image');

%%% ��������
% alpha = 0.03;  lambda2 = 0.003;   %�������Լ��
% belta = 0.04;    lambda3 = 0.004;   %��֡��Լ��
% gamma = 300;  omega = 10;     %�ܱ�ֺ˵�Լ��                (����)
% lambda1 = 10;
% MaxIter = 300;

alpha = 0.4;lambda2 = 0.1;   %�������Լ��
belta = 1; lambda3 = 0.1;   %��֡��Լ��
gamma = 200; omega = 5;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
lambda1 = 500;
MaxIter = 20;

% alpha = 0.4; lambda2 = 0.01;   %�������Լ��
% belta = 1; lambda3 = 0.1;   %��֡��Լ��
% gamma = 200; omega = 5;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
% lambda1 = 500;
% MaxIter = 50;

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
figure;imagesc(h);colormap(gray);axis image;axis off;
figure;surf(h);
figure;plot(1:length(out.NSDE),out.NSDE,'linewidth',2);
xlabel('Iteration number');
ylabel('NSDE');

% imwrite(uf./255,'D:\caoshuning\caoshuning\TEST_github\result65\Chang\Chang_u.tif');