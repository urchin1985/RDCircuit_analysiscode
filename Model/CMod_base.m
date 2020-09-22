clear;
N=150;wnum=1;
% tmax=100;t=linspace(0,tmax,N);dt=tmax/N;
% specify model params:
prm.tau = 3*[1 1];
prm.ki = [.5 .5];
prm.ni = [1 3];
prm.k = [0 .3;.3 .5];
prm.n = [0 4;4 2];
prm.b = [.5 .1]; % baseline activity
prm.a = [1 1.8]; % gain on chemosensory input
prm.beta = [2 2]; % gain on mutual inhibition
prm.r = [0 .5];
prm.dt = .5;
prm.ic = .5;
% specify sensory inputs
prm.fc = 1.2;
prm.i = 0.95;
inp.fc = prm.fc*ones(1,500);
inp.i = [prm.i*ones(1,50) .1*ones(1,50) 0*ones(1,200)];

%%
figure(14);clf;hold on;
% for ip = 1:5 % vary sensory input
XS0=[.2 .2]; % initial condition
XS = XS0;

Xt=XS;
for ti=2:N
    % update circuit state
    run_cmod2
    
    Xt=max(0,(Xt+dX));
    % Xt = Xt+dX;
    XS=[XS;Xt*prm.dt];
end


%     subplot(5,1,ip);cla; hold all
subplot 211; hold all
plot(XS(:,1),'linewidth',1)
subplot 212; hold all
plot(XS(:,2),'linewidth',1)
%%
prm.a(1) = .59; % gain on chemosensory input
% for ip = 1:5 % vary sensory input
% XS=[.2 .2]; % initial condition

Xt=XS0; XS = XS0;
for ti=2:N
    % update circuit state
    run_cmod2
    
    Xt=max(0,(Xt+dX));
    % Xt = Xt+dX;
    XS=[XS;Xt*prm.dt];
end


%     subplot(5,1,ip);cla; hold all
subplot 211; hold all
plot(XS(:,1),'linewidth',1)
subplot 212; hold all
plot(XS(:,2),'linewidth',1)
