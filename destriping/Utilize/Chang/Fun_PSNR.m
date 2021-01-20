function PSNR = Fun_PSNR( org_image ,des_image )

%   PSNR means the Peak Signal-to-Noise Ratio (PSNR)
%   org_image means the original image or the raw image
%   des_image means the destriped image

diff = des_image - org_image ;
[m,n] = size( org_image );
image_size = m * n;
MSE = sum(dot( diff ,diff))/ image_size;
PSNR = 10 * log10(255^2/MSE);

end