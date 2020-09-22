clear;
N=150;wnum=1;
% tmax=100;t=linspace(0,tmax,N);dt=tmax/N;
% specify model params:
prm.tau = 5*[1 1];
prm.ki = [1 1];
prm.ni = [2 2];
prm.k = [0 1;1 .5];
in = 3; % 1.7-4
prm.n = [0 in;in 2];
prm.b = [1 0.2]+.5; % baseline activity
prm.a = [1.5 3.2]; % gain on chemosensory input
prm.beta = [3 3]; % gain on mutual inhibition
prm.r = [0 0];
prm.dt = .25;
% specify sensory inputs
prm.fc = 1;
prm.i = .3; % i-min .6-.05
prm.ic = 1;
%% compute and visualize nullclines
% prm.a(1) = 0;
xr1 = [-3 5]; xr2 = [-3 5]; inc = [.2 .2];
fid = 19; dq = 1;
[nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);

%% find intercepts between nullclines
ic = .01;
figure(19);clf;hold all
plot([-2 5],[0 0],'k:');plot([0 0],[-2 5],'k:')
plot(nco.x,nco.ny,'b.-');plot(nco.nx,nco.y,'r.-')
[intp] = nullcsolve(xr1,xr2,ic,prm);
plot(intp(:,1),intp(:,2),'ro')