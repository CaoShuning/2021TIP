clc
clear
img_lr = imread('./KITTI2015/lr_x4/000012/lr0.png');
img_hr = imread('./KITTI2015/hr/000012/hr0.png');
img_sr_SEnet = imread('/Users/liyu/work/�ж�/���ֱ���SR/code/PASSRnet-master/results/deep_SE_epoch80/KITTI2015/000012/img_0.png');
img_sr_PASSRnet = imread('/Users/liyu/work/�ж�/���ֱ���SR/code/PASSRnet-master/results/PASSRnet/KITTI2015/000012/img_0.png');
img_sr_SAM = imread('/Users/liyu/work/�ж�/���ֱ���SR/code/SAM-SRResNet_SAM/DEMO/Results/KITTI2015/000012.png')
img_sr_Bicubic = imresize(img_lr, 4, 'bicubic');

[m, n, z] = size(img_hr);
figure(1)
imshow(img_hr)
%��ͼ��
h=imrect;%�����ʮ�֣�����ѡȡ����Ȥ����
%ͼ�оͻ���ֿ����϶��Լ��ı��С�ľ��ο�ѡ��λ�ú�
pos=getPosition(h);
pos

%imCp_hr = imcrop( img_hr, pos );
%imCp_sr_SEnet = imcrop( img_sr_SEnet, pos );
%imgCp_sr_PASSRnet = imcrop( img_sr_PASSRnet, pos );
%imgCp_sr_Bicubic = imcrop( img_sr_Bicubic, pos );


imgCp_sr_Bicubic = imcrop( img_sr_Bicubic, pos );
imwrite(img_sr_Bicubic,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/img_sr_Bicubic.png');
subplot(251),imshow(img_sr_Bicubic);
rectangle('Position',pos,'LineWidth',2,'EdgeColor','r') %��ʾͼ���������
imwrite(imgCp_sr_Bicubic,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/imgCp_sr_Bicubic.png');
subplot(256),imshow(imgCp_sr_Bicubic);


imCp_sr_SEnet = imcrop( img_sr_SEnet, pos );
imwrite(img_sr_SEnet,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/img_sr_SEnet.png');
subplot(252),imshow(img_sr_SEnet);
rectangle('Position',pos,'LineWidth',2,'EdgeColor','r') %��ʾͼ���������
imwrite(imCp_sr_SEnet,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/imCp_sr_SEnet.png');
subplot(257),imshow(imCp_sr_SEnet);


imgCp_sr_PASSRnet = imcrop( img_sr_PASSRnet, pos );
imwrite(img_sr_PASSRnet,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/img_sr_PASSRnet.png');
subplot(253),imshow(img_sr_PASSRnet);
rectangle('Position',pos,'LineWidth',2,'EdgeColor','r') %��ʾͼ���������
imwrite(imgCp_sr_PASSRnet,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/imgCp_sr_PASSRnet.png');
subplot(258),imshow(imgCp_sr_PASSRnet);

imCp_sr_SAM = imcrop( img_sr_SAM, pos );
imwrite(img_sr_SAM,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/img_sr_SAM.png');
subplot(254),imshow(img_sr_SAM);
rectangle('Position',pos,'LineWidth',2,'EdgeColor','r') %��ʾͼ���������
imwrite(imCp_sr_SAM,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/imCp_sr_SAM.png');
subplot(259),imshow(imCp_sr_SAM);


imCp_hr = imcrop( img_hr, pos );
imwrite(img_hr,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/img_hr.png');
subplot(255),imshow(img_hr);
rectangle('Position',pos,'LineWidth',2,'EdgeColor','r') %��ʾͼ���������
imwrite(imCp_hr,'/Users/liyu/work/����/��ҵ����/ʵ����/ʵ����ͼ/KITTI2015/000012/imCp_hr.png');
subplot(2,5,10),imshow(imCp_hr);

