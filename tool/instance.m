clc,clear all;
addpath(genpath('C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\instance\'));
cd('C:\Users\caoshuning\Desktop\caoshuning\caoshuning\Kernel_modify\data729\instance\');
filePath_1 = '0.5_8.3\';
filePath_2 = '5_5\';

I_old = load([filePath_1,'1.6_9_0.5_8.3_dncnn.mat']);
I_new = load([filePath_2,'1.6_9_5_5_dncnn.mat']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imagesc(I_old.x3);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_1,'h.eps'],'-r600');

imagesc(I_old.x4);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_1,'k.eps'],'-r600');

imagesc(I_old.k1);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_1,'k1.eps'],'-r600');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imagesc(I_new.x3);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_2,'h.eps'],'-r600');

imagesc(I_new.x4);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_2,'k.eps'],'-r600');

imagesc(I_new.k1);colormap(gray);axis off;axis equal
print(gcf,'-depsc2',[filePath_2,'k1.eps'],'-r600');