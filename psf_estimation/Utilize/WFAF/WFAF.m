% WFAF destriping code used in Pande-Chhetri & Abd-Elrahman (2011).
% WFAF stands for Wavelet Frequency Adaptive filtering.
% 3 parameters are input - no of decomposition level, wavelet type and adaptive threshold k value.
% Proposed algorithm is based on and refinement of the algorithms proposed by Torres & Infante (2001) and Munch et al(2009).

clear all
close all
clc

[ filename, pathname ] = uigetfile('./*.*', 'load image');
I = double(imread( fullfile( pathname, filename ) ));
Is  = I;
 rand('seed',0);
kk = randperm(307,107);
 Is(:,kk(1:30))=I(:,kk(1:30))-40; Is(:,kk(31:60))=I(:,kk(31:60))+35; Is(:,kk(61:90))=I(:,kk(61:90))-35;Is(:,kk(91:107))=I(:,kk(91:107))+25;
img = Is;
figure, imshow(img,[]);
%% User input parameters
numlev = 4;
wavtyp = 'db2';
k = 1;

tic
% wavelet decomposition
for i=1:numlev
   [img,hd{i},vd{i},dd{i}] =dwt2(img,wavtyp);
end

%%% FFT transform
vd = adpative_FFT( vd, numlev,k);
  
% Reconstruction
newimg=img;
for i=numlev:-1:1
   newimg=newimg(1:size(hd{i},1),1:size(hd{i},2));
   newimg=idwt2(newimg,hd{i},vd{i},dd{i},wavtyp);
end
figure,imshow(newimg,[]);
toc
