clear;
N=150;wnum=1;
% tmax=100;t=linspace(0,tmax,N);dt=tmax/N;
% specify model params:
prm.gm = [.5 .5];
prm.fb = [0 2;2 .2];
prm.kf = [0 1;1,2.5];
prm.nf = [0 3;3 2];
prm.tg = .2;
prm.cflg = 0;

i2ic = .5; i1ic = .5;


figure(13);clf;hold on;
for ip = 1:5 % vary sensory input
    XS=[.2 .2]; % initial condition

    I2 = i2ic*(ip-1);
    I1 = 1;
    
    Xt=XS;
    for ti=2:N
        % update circuit state
        run_cmod
        
        Xt=max(0,(Xt+prm.tg*dX));
        XS=[XS;Xt];
    end
    subplot(5,1,ip);cla; hold all
    plot(XS,'linewidth',1)
%     ylim([0 5])
end