function [opt] = Para4real(file_G)
 switch file_G 
     
     case 'AVIRIS_stripe_blur.tif'
        opt.alphax = 0.0008;   %水平方向差分的惩罚参数
        opt.ax = 1;        %alphax = alphax * 0.999;
        opt.alphay = 0.0002;   %竖直方向差分的惩罚参数
        opt.ay = 1;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.006;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化
        opt.mu = 0.008;      %低秩分量的正则化参数
%         opt.mu = 0.008;
        opt.rank_B = 1;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 50; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;

        case 'band95(1).tif'
        opt.alphax = 1;   %水平方向差分的惩罚参数
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %竖直方向差分的惩罚参数
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %水平方向差分的正则化参数
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化,设置成0时，完全fail
        opt.mu = 0.0006;      %低秩分量的正则化参数        
%         opt.mu = 1e-12;      %低秩分量的正则化参数 完全fail，说明低秩约束有用
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
        case 'band205.tif'
        opt.alphax = 1;   %水平方向差分的惩罚参数
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %竖直方向差分的惩罚参数
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %水平方向差分的正则化参数
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化
        opt.mu = 0.0006;      %低秩分量的正则化参数
%         opt.tauz = 1e-12;     %帧波正则化           完全fail，说明低秩约束有用
%         opt.mu = 1e-12;      %低秩分量的正则化参数
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
     case 'hills_blur.tif'
        opt.alphax = 0.00008;   %水平方向差分的惩罚参数
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0002;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00002;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.0008;   %帧波惩罚参数
        opt.tauz = 0.004;     %帧波正则化
        opt.mu = 0.016;      %低秩分量的正则化参数
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    case 'lakeband205.tif'
        opt.alphax = 1;   %水平方向差分的惩罚参数
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %竖直方向差分的惩罚参数
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %水平方向差分的正则化参数
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化
        opt.mu = 0.0006;      %低秩分量的正则化参数
%         opt.tauz = 1e-12;     %帧波正则化           完全fail，说明低秩约束有用
%         opt.mu = 1e-12;      %低秩分量的正则化参数
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
   case 'Dioni_band1(1-250,50-299).tif'
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.ax = 0.0008;        %alphax = alphax * 0.999;
        opt.alphay = 0.0025;   %竖直方向差分的惩罚参数
        opt.ay = 0.008;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %水平方向差分的正则化参数
        opt.tx = 0.5;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 0.5;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化
        opt.mu = 0.0006;      %低秩分量的正则化参数
%         opt.tauz = 1e-12;     %帧波正则化           完全fail，说明低秩约束有用
%         opt.mu = 1e-12;      %低秩分量的正则化参数
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 20; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
end