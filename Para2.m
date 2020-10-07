function [opt] = Para2(I,Sig)

if Sig == 1.1
    if I == 10
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
        opt.Innerloop_B = 5;
        opt.MaxIter = 1200; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
    elseif I == 20
        opt.alphax = 0.001;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.0005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.000025;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.01;   %帧波惩罚参数
        opt.tauz = 0.05;     %帧波正则化
        opt.mu = 0.02;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I ==30
        opt.alphax = 0.0005;   %水平方向差分的惩罚参数
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.00025;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.00125;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000125;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.005;   %帧波惩罚参数
        opt.tauz = 0.025;     %帧波正则化
        opt.mu = 0.1;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
elseif Sig == 1.6
    if I == 10
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tx = 1.001;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1.005;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 20
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1000; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 30
        opt.alphax = 0.0002;   %水平方向差分的惩罚参数
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.0001;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0005;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00005;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.002;   %帧波惩罚参数
        opt.tauz = 0.01;     %帧波正则化
        opt.mu = 0.04;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
elseif Sig == 2.1
    if I == 10
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1500; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 20
        opt.alphax = 0.00005;   %水平方向差分的惩罚参数
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.000025;   %竖直方向差分的惩罚参数
        opt.ay = 0.995;       %alphay = alphay * 0.995;
        opt.taux = 0.00000125;     %水平方向差分的正则化参数
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.0000125;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.0005;   %帧波惩罚参数
        opt.tauz = 0.0025;     %帧波正则化
        opt.mu = 0.001;      %低秩分量的正则化参数
        opt.MU = 0.5;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1000; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 30
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
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.12;           %帧波参数
        opt.kernel_size =15;   %预估 PSF大小
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %迭代停止误差, 1e-6
        opt.MaxIter = 1000; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
end