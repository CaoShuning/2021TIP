clc,clear all;
close all;
Path_ori = 'C:\Users\caoshuning\Desktop\Submit_text\result\simulation\';
[file_ori, path_ori] = uigetfile([Path_ori,'*.tif']);%read image
image = imread([path_ori,file_ori]);

pouxiantu( image );
power_spectrum(image);

function     pouxiantu( image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
inputdata = image ;
[r,c] = size(inputdata);
sum_row = zeros(1,c);
        for i=1:c
%            sum_row(i) = sum(inputdata(:,i))./r;
           sum_row(i) = sum(inputdata(:,i))./r;
        end
        figure;plot(sum_row);xlim([0,256]);ylim([0,255]);
        xlabel('Line Number');ylabel('Mean Value');
        set(gca,'linewidth',1);
end

function  power_spectrum(signal)

[sx sy]=size(signal);
P=0;
for i=1:sy
[Px,w] = periodogram(double(signal(:,i)));
P=P+Px;
end
P=P/sy;
% ws=w;
% figure(1);plot((w./(2*max2(w))),log10(P1));hold;plot((w./(2*max2(w))),log10(P2),'red')
figure;plot((w./(2*max(w))),log10(P+1));
% ylim([0,10]);
xlabel('Normalized frequency');
ylabel('Power spectrum ');
grid on;
set(gca,'linewidth',1);
end