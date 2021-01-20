function [opt] = Paraset(I,Sig)

if Sig == 1.1
    if I == 10
       opt.alpha = 0.4;
       opt.lambda2 = 0.01;   %单方向的约束
       opt.belta = 1;
       opt.lambda3 = 0.1;   %紧帧波约束
       opt.gamma = 200; 
       opt.omega = 5;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 500;
       opt.MaxIter = 50;
    elseif I == 20
       opt.alpha = 0.4; opt.lambda2 = 0.1;   %单方向的约束
       opt.belta = 1; opt.lambda3 = 0.1;   %紧帧波约束
       opt.gamma = 200;  opt.omega = 5;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 500;
       opt.MaxIter = 50;
    elseif I ==30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
elseif Sig == 1.6
    if I == 10
      opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 20
      opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
elseif Sig == 2.1
    if I == 10
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 20
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %单方向的约束
       opt.belta = 5; opt.lambda3 = 0.5;   %紧帧波约束
       opt.gamma = 10000; opt.omega = 200;     %总变分核的约束                 (统一的参数)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
end