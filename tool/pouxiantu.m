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
end

