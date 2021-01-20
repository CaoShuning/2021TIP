function lowpass_output = lowpass_filter( inputdata )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

inputdata = double(inputdata);
lowpass_output = conv2(inputdata ,fspecial('gaussian',7,2),'same');

end
% lowpass_output(:,1) = lowpass_output(:,4);
% lowpass_output(:,2) = lowpass_output(:,4);
% lowpass_output(:,3) = lowpass_output(:,4);
% lowpass_output(510,:) = lowpass_output(509,:);
% lowpass_output(511,:) = lowpass_output(509,:);
% lowpass_output(512,:) = lowpass_output(509,:);
% pouxiantu(lowpass_output);
% power_spectrum(lowpass_output);
