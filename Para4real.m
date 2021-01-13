function [opt] = Para4real(file_G)
 switch file_G 
     
     case 'AVIRIS_stripe_blur.tif'
        opt.alphax = 0.0008;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 1;        %alphax = alphax * 0.999;
        opt.alphay = 0.0002;   %��ֱ�����ֵĳͷ�����
        opt.ay = 1;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1;        %tauy = tauy*0.995;
        opt.alphaz = 0.006;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������
        opt.mu = 0.008;      %���ȷ��������򻯲���
%         opt.mu = 0.008;
        opt.rank_B = 1;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 50; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;

        case 'band95(1).tif'
        opt.alphax = 1;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������,���ó�0ʱ����ȫfail
        opt.mu = 0.0006;      %���ȷ��������򻯲���        
%         opt.mu = 1e-12;      %���ȷ��������򻯲��� ��ȫfail��˵������Լ������
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
        case 'band205.tif'
        opt.alphax = 1;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������
        opt.mu = 0.0006;      %���ȷ��������򻯲���
%         opt.tauz = 1e-12;     %֡������           ��ȫfail��˵������Լ������
%         opt.mu = 1e-12;      %���ȷ��������򻯲���
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
     case 'hills_blur.tif'
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
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 5e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
    case 'lakeband205.tif'
        opt.alphax = 1;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.8;        %alphax = alphax * 0.999;
        opt.alphay = 0.25;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.8;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 1.2;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 1.2;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������
        opt.mu = 0.0006;      %���ȷ��������򻯲���
%         opt.tauz = 1e-12;     %֡������           ��ȫfail��˵������Լ������
%         opt.mu = 1e-12;      %���ȷ��������򻯲���
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 1500; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
   case 'Dioni_band1(1-250,50-299).tif'
        opt.alphax = 0.0001;   %ˮƽ�����ֵĳͷ�����
        opt.ax = 0.0008;        %alphax = alphax * 0.999;
        opt.alphay = 0.0025;   %��ֱ�����ֵĳͷ�����
        opt.ay = 0.008;        %alphay = alphay * 0.995;
        opt.taux = 0.0001;     %ˮƽ�����ֵ����򻯲���
        opt.tx = 0.5;        %taux=taux*1.01;
        opt.tauy = 0.0001;     %��ֱ�����ֵ����򻯲���,̫Сˮƽ���򽫳ͷ�����,ϸ�ڶ�ʧ����
        opt.ty = 0.5;        %tauy = tauy*0.995;
        opt.alphaz = 0.004;   %֡���ͷ�����
        opt.tauz = 0.01;     %֡������
        opt.mu = 0.0006;      %���ȷ��������򻯲���
%         opt.tauz = 1e-12;     %֡������           ��ȫfail��˵������Լ������
%         opt.mu = 1e-12;      %���ȷ��������򻯲���
        opt.rank_B = 30;
        opt.MU = 1;        %opts.mu = opts.mu * 0.995;
        opt.miu = 0.06;           %֡������
        opt.kernel_size =15;   %Ԥ�� PSF��С
        opt.Innerloop_B =5;
        opt.tol = 1e-5;  %����ֹͣ���, 1e-6
        opt.MaxIter = 20; %���������� for stripelevel 10, when iter reach to 300, PSNR curve go down
        opt.Level = 4;
        opt.frame = 1;
        opt.wLevel = 0.5;
end