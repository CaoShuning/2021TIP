function [opt] = Para(stripe_level)
    if stripe_level <= 10
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.miu = 0.06;           %֡������
        opt.MaxIter = 400; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %����ֹͣ���, 1e-6
    elseif ((stripe_level >= 10)&&(stripe_level <= 20))
        opt.alphax = 0.001;   %ˮƽ�����ֵĳͷ�����
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.miu = 0.06;           %֡������
        opt.MaxIter = 100; %����������
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %����ֹͣ���, 1e-6
    elseif((stripe_level >= 20)&&(stripe_level <= 30))
        opt.alphax = 0.1;   %ˮƽ�����ֵĳͷ�����
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.02;      %���ȷ��������򻯲���
        opt.miu = 0.06;           %֡������
        opt.MaxIter = 100; %����������
        opt.Innerloop_B =5;
        opt.tol = 1e-6;  %����ֹͣ���, 1e-6
    end