
clear all; 
close all;
clc;

%% ��ȡ�����ͼ��
[filename, filepath, FilterIndex ] = uigetfile('/*.*','Read image');
I =  double(imread(fullfile(filepath,filename)));

f = transpose(I); % ��������ת��Ϊ������ 
figure; imshow(f',[]); title('Striped image');

%%% ��������
alpha = 1000;omega2 = 10;
belta = 100;lamda = 1;
omega1 = 0.0001;
MaxIter = 30;
tic
%%% ������
u = UTVdestripe(f,f,alpha,belta,lamda,omega1,omega2,MaxIter);
figure,imshow(u',[])
toc

