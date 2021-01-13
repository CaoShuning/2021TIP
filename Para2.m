function [opt] = Para2(I,Sig)

if Sig == 1.1
    if I == 10
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
        opt.Innerloop_B = 5;
        opt.MaxIter = 1200; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
    elseif I == 20
        opt.alphax = 0.001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.0005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.000025;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.01;   %֡���ͷ�����
        opt.tauz = 0.05;     %֡������
        opt.mu = 0.02;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I ==30
        opt.alphax = 0.0005;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.00025;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.00125;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000125;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.005;   %֡���ͷ�����
        opt.tauz = 0.025;     %֡������
        opt.mu = 0.1;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
elseif Sig == 1.6
    if I == 10
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1.001;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1.005;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 20
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1000; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 30
        opt.alphax = 0.0002;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.0001;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0005;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00005;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.002;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������
        opt.mu = 0.04;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
elseif Sig == 2.1
    if I == 10
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0000025;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.000025;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.001;   %֡���ͷ�����
        opt.tauz = 0.005;     %֡������
        opt.mu = 0.002;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 20
        opt.alphax = 0.00005;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.999;        %alphax = alphax * 0.999;
        opt.alphay = 0.000025;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;       %alphay = alphay * 0.995;
        opt.taux = 0.00000125;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.0000125;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.0005;   %֡���ͷ�����
        opt.tauz = 0.0025;     %֡������
        opt.mu = 0.001;      %���ȷ��������򻯲���
        opt.MU = 0.5;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1000; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    elseif I == 30
        opt.alphax = 0.00008;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.995;        %alphax = alphax * 0.999;
        opt.alphay = 0.00005;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.995;        %alphay = alphay * 0.995;
        opt.taux = 0.0002;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.00002;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.0008;   %֡���ͷ�����
        opt.tauz = 0.004;     %֡������
        opt.mu = 0.016;      %���ȷ��������򻯲���
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.12;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1000; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    end
end