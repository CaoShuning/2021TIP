%����ƥ�䷨����һ���ǳ������Եķ���
clc;
close all;
clear all;


[filename,filepath] = uigetfile('E:\CY\data\*.*','Read Images');
inputdata = imread(fullfile(filepath,filename));
inputdata = inputdata';
figure,imshow(mat2gray(inputdata'));title('Input Image');
[M,N] = size(inputdata);
averageValue = MeanDN(inputdata);
figure;plot(averageValue);xlim([1,M]);ylim([0,250]);title('Before profiles');

%% ȥ��ֱ��ͼ��ǰ��1%,��Լǰ����3����
meanStr = zeros( M,1 );
stdStr = zeros( M,1 );

for i = 1:M
    %����һ�����е�ֵ��һ�����򣬼�ȥǰ��3��������С��ֵ
    truncatedRow = sort(inputdata(i,:));
    CutNum = ceil( M*0.01 );
    truncatedRow([1:CutNum, N-CutNum+1:N] ) = [];
    
    
    truncatedRow = double(truncatedRow);
    meanStr(i) = mean( truncatedRow );
    stdStr(i) = std( truncatedRow );
end

%% �Ծ�ֵ�ͷ�������ȡ�м��ֵ,��Ϊ�ο��ľ�ֵ�ͷ���
%������Ҫ֪�������е�����
period = 10;
meanRef = zeros( M,1 );
stdRef = zeros( M,1 );
for i = 1:period:M-10
temp1 = sort(meanStr(i:i+period-1));
meanVal = temp1( floor(period/2) );

temp2 = sort(stdStr(i:i+period-1));
stdVal = temp2( floor(period/2) );
meanRef( i:i+period-1 ) = meanVal;
stdRef( i:i+period-1 ) = stdVal;
end

%% �Ǿ����Ե�У��
inputdata = double( inputdata );
OutputImg = inputdata;


for i = 1 :size(kk,1)
    for j = 1 : N
        OutputImg(kk(i),j) = (inputdata( kk(i) ,j ) - meanStr(kk(i)))*(stdRef(kk(i))/stdStr(kk(i))) + meanRef(kk(i));
    end
end
% for i = 2 :10: M
%     for j = 1 : N
%         OutputImg(i,j) = (inputdata( i ,j ) - meanStr(i))*(stdRef(i)/stdStr(i)) + meanRef(i);
%     end
% end



OutputImg(OutputImg<0)=0;
OutputImg(OutputImg>255)=255;
averageValue = MeanDN(OutputImg);
figure;plot(averageValue);xlim([1,M]);ylim([0,250]);title('After profiles');
figure,imshow(uint8(OutputImg'));title('ȥ�������');
grid on
