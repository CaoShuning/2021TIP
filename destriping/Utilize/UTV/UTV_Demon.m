
clear all; 
close all;
clc;

%% 读取或加载图像
[filename, filepath, FilterIndex ] = uigetfile('/*.*','Read image');
I =  double(imread(fullfile(filepath,filename)));

f = transpose(I); % 将竖条带转换为横条带 
figure; imshow(f',[]); title('Striped image');

%%% 参数设置
alpha = 1000;omega2 = 10;
belta = 100;lamda = 1;
omega1 = 0.0001;
MaxIter = 30;
tic
%%% 主程序
u = UTVdestripe(f,f,alpha,belta,lamda,omega1,omega2,MaxIter);
figure,imshow(u',[])
toc

