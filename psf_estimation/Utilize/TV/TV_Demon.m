
clear all; 
close all;
clc;
addpath(genpath('Codes\'));
[filename, filepath, FilterIndex ] = uigetfile('/*.*','Read image');
I =  double(imread(fullfile(filepath,filename))) ;
figure,imshow(I,[])
Is  = I;
 rand('seed',0);
kk = randperm(307,107);
 Is(:,kk(1:30))=I(:,kk(1:30))-40; Is(:,kk(31:60))=I(:,kk(31:60))+35; Is(:,kk(61:90))=I(:,kk(61:90))-35;Is(:,kk(91:107))=I(:,kk(91:107))+25;
I = Is;
f= I/256;
figure; imshow(f,[]); title('Striped image');
%%% 参数设置
belta = 1; lamda = 0.1;  
omega1 = 1;
MaxIter = 1000; 

%%% 主程序
tic
u = TVdestripe(f,f,belta,lamda,omega1,MaxIter);
toc
figure; imshow(u,[]); title('De-Striped image');