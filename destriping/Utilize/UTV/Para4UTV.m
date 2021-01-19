function [opt] = Para4UTV(I,Sig)

if Sig == 1.1
    if I == 10
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 10; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I == 20
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I ==30
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    end
elseif Sig == 1.6
    if I == 10
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I == 20
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I == 30
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    end
elseif Sig == 2.1
    if I == 10
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I == 20
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    elseif I == 30
    opt.alpha = 1000; opt.omega2 = 10;
    opt.belta = 100; opt.lamda = 1;
    opt.omega1 = 0.0001;
    opt.MaxIter = 30;
    end
end