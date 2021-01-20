function [ IF1 IF2 ] = Fun_IF( org_image ,des_image ,lowpass_output)

%   IF means the improvement factors
%   org_image means the original image or the raw image
%   des_image means the destriped image

       [m,n] = size(org_image);
       org_mean = sum ( org_image , 2)/n;
       des_mean = sum ( des_image , 2)/n;
       lowpass_mean= sum(lowpass_output , 2)/n;
       
       dr = zeros( m , 1 );
       de = zeros( m , 1 );
       
   for j = 1 : m
        dr( j ) = org_mean( j ) - lowpass_mean( j );
   end
   
   for j = 1 : m
        de( j ) = des_mean( j ) - lowpass_mean( j );
   end
   
    org_temp = zeros( m , 1 );
    des_temp = zeros( m , 1 );
   for j = 2 : m
      org_temp(j) = org_mean( j ) - org_mean(j - 1);
   end
   
   for j = 2 : m
      des_temp(j) = des_mean( j ) - des_mean(j - 1);
   end
   
   IF1 = 10 * log10(dot(dr ,dr)/dot(de ,de));
   IF2 = 10 * log10(dot(org_temp ,org_temp)/dot(des_temp ,des_temp));

 end

