function [opt] = Para(stripe_level)
    if stripe_level <= 10
        opt.alphax = 0.0001;   %水平方向差分的惩罚参数
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.miu = 0.06;           %帧波参数
        opt.MaxIter = 400; %最大迭代次数 for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %迭代停止误差, 1e-6
    elseif ((stripe_level >= 10)&&(stripe_level <= 20))
        opt.alphax = 0.001;   %水平方向差分的惩罚参数
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.002;      %低秩分量的正则化参数
        opt.miu = 0.06;           %帧波参数
        opt.MaxIter = 100; %最大迭代次数
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %迭代停止误差, 1e-6
    elseif((stripe_level >= 20)&&(stripe_level <= 30))
        opt.alphax = 0.1;   %水平方向差分的惩罚参数
        opt.alphay = 0.00005;   %竖直方向差分的惩罚参数
        opt.taux = 0.0000025;     %水平方向差分的正则化参数
        opt.tauy = 0.000025;     %竖直方向差分的正则化参数,太小水平方向将惩罚过多,细节丢失严重
        opt.alphaz = 0.001;   %帧波惩罚参数
        opt.tauz = 0.005;     %帧波正则化
        opt.mu = 0.02;      %低秩分量的正则化参数
        opt.miu = 0.06;           %帧波参数
        opt.MaxIter = 100; %最大迭代次数
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %迭代停止误差, 1e-6
    end