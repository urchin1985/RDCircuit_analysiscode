clear;

grab_prms
%%
T = 60; wnum=1;
N = T/prm.dt;
inp.fc = prm.fc*ones(1,500);
idn = round(T/2/prm.dt);
inp.i = [0*ones(1,idn) 2*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
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
xr1 = [-1 3]; xr2 = xr1; inc = 2*[.1 .1]; 
fid = 11; dq = 1;
% figure(fid);clf;hold on;
[nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);

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
prm.a(1) = .0125; % gain on chemosensory input
% for ip = 1:5 % vary sensory input
% XS=[.2 .2]; % initial condition
fid = fid+1;
% plot nullcline field
% xr1 = [-1 3]; xr2 = xr1; inc = [.2 .2]; 

Xt=XS0; XS = XS0;
for ti=2:N
    % update circuit state
    run_cmod2
    
Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
end

fid = 13; %dq = 1;
[nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);


figure(fid);hold on;
plot(XS(:,1),XS(:,2),'ko-','linewidth',1)
plot(XS(end,1),XS(end,2),'ko','linewidth',1)
colormap parula

figure(14); hold all
subplot 211; hold all
plot(XS(:,1),'linewidth',1)
subplot 212; hold all
plot(XS(:,2),'linewidth',1)