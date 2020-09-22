clc;
% tmax=100;t=linspace(0,tmax,N);dt=tmax/N;
% specify model params:
prm.tau = 2.5*[1 1];
prm.ki = [1.5 .5]; % vary between .25-2.5
prm.ni = [1 3]; % vary between 1-4
prm.k = [0 1;.3 .5]; % vary between .2-5
prm.n = [0 4;2 2]; % vary between 1.7-5
prm.b = [.5 .3]+1; % baseline activity % vary between .5-2
prm.a = [1.3 1.8]; % gain on chemosensory input % vary between .5-5
prm.beta = [3.25 2]; % gain on mutual inhibition % vary between 1-5
prm.r = [0 0];
prm.dt = .25;
% specify sensory inputs
prm.fc = 1.2; % vary between .5-2
prm.i = 3; 
prm.ic = 1;
% screen based on opposite state choice at input 2 and .1
%%
T = 90; wnum=1;
N = T/prm.dt;
prm.a = [1.3 1.8];
inp.fc = prm.fc*ones(1,500);
idn = round(T/3/prm.dt);
inp.i = [.05*ones(1,idn) 2.5*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% give ramp down
% for ip = 1:5 % vary sensory input
XS0=[0 1.1]; % initial condition
XS = XS0;

Xt=XS;
for ti=2:N
    % update circuit state
    run_cmod2
    
    Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
end


% first plot nullcline field
xr1 = [-2 3]; xr2 = xr1; inc = 2*[.1 .1]; 
% figure(fid);clf;hold on;
prm.i = .005; 
fid = 11+(prm.i>=.5); dq = 0;
[nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);
axis square
set(gca,'xticklabel','','yticklabel','')


plot(XS(:,1),XS(:,2),'bo-','linewidth',1)
plot(XS(end,1),XS(end,2),'bo','linewidth',1)
colormap parula
figure(14); clf; hold all
subplot 211; hold all
plot(XS(:,1),'linewidth',1)
subplot 212; hold all
plot(XS(:,2),'linewidth',1)
%%
prm.ic = 1;
prm.a(1) = .0; % gain on chemosensory input
% for ip = 1:5 % vary sensory input
% XS=[.2 .2]; % initial condition
fid = fid+1;
% plot nullcline field
xr1 = [-2 3]; xr2 = xr1; inc = [.2 .2]; 

Xt=XS0; XS = XS0;
for ti=2:N
    % update circuit state
    run_cmod2
    
Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
end

prm.i= .75;
fid = 13+(prm.i>=.5); dq = 0;
[nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);
axis square
set(gca,'xticklabel','','yticklabel','')

figure(fid);hold on;
plot(XS(:,1),XS(:,2),'ko-','linewidth',1)
plot(XS(end,1),XS(end,2),'ko','linewidth',1)
colormap parula

figure(14); hold all
subplot 211; hold all
plot(XS(:,1),'linewidth',1)
subplot 212; hold all
plot(XS(:,2),'linewidth',1)