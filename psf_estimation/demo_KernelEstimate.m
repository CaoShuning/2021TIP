%code for kernel estimation
clc, clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load degradation images kernel
Path_G = 'D:\caoshuning\caoshuning\TEST_github\dataset\real\';
[file, path] = uigetfile([Path_G, '*.tif']);              %get degraded image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save path
SavePath = ['C:\Users\caoshuning\Desktop\Submit_text\result\real\Proposed\',date,'\','h\'];
if exist(SavePath,'dir') == 0
    mkdir(SavePath);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%para setting for real data
lambda = 5; gamma = 5; 
MK =15;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
y_gray = im2double(imread([path, file]));
[u_dy, h] = destripeDeblur(y_gray,lambda, gamma, MK);
imwrite(h,[SavePath,'h_', num2str(lambda),'_' num2str(gamma), '_',file(1:end-4),'.tif']);
parsave([SavePath,'h_', num2str(lambda),'_' ,num2str(gamma),'_',file(1:end-4),'.mat'], h, lambda, gamma);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parsave(fname,  h, lambda, gamma)
    save(fname, 'h', 'lambda', 'gamma','-v6');
end