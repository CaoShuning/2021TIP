function ICV = Fun_ICV( window)
%  ICV means the inverse coefficient of variation
%  window means the homogeneous regions within a window of 10 ¡Á 10 pixels where we get the ICV index 


%   [filename,filepath] = uigetfile('E:\CY\data\*.*','Read a image');
%   inputdata = imread(fullfile(filepath,filename));
%   window = inputdata(11:20,16:25);

  win_mean = mean(mean(window));
  win_temp = reshape(window,1,100);
  win_temp = double(win_temp);
  win_std  = std (win_temp);
  ICV = win_mean / win_std;
  
end

