function [opt] = Paraset(I,Sig)

if Sig == 1.1
    if I == 10
       opt.alpha = 0.4;
       opt.lambda2 = 0.01;   %�������Լ��
       opt.belta = 1;
       opt.lambda3 = 0.1;   %��֡��Լ��
       opt.gamma = 200; 
       opt.omega = 5;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 500;
       opt.MaxIter = 50;
    elseif I == 20
       opt.alpha = 0.4; opt.lambda2 = 0.1;   %�������Լ��
       opt.belta = 1; opt.lambda3 = 0.1;   %��֡��Լ��
       opt.gamma = 200;  opt.omega = 5;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 500;
       opt.MaxIter = 50;
    elseif I ==30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
elseif Sig == 1.6
    if I == 10
      opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 20
      opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
elseif Sig == 2.1
    if I == 10
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 20
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    elseif I == 30
       opt.alpha = 0.4; opt.lambda2 = 0.04;   %�������Լ��
       opt.belta = 5; opt.lambda3 = 0.5;   %��֡��Լ��
       opt.gamma = 10000; opt.omega = 200;     %�ܱ�ֺ˵�Լ��                 (ͳһ�Ĳ���)
       opt.lambda1 = 1000;
       opt.MaxIter = 300;
    end
end