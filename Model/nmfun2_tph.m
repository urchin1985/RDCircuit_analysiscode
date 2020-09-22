function xo = nmfun2_tph(x1,x2,prm,icf)
% parse params
tau1 = prm.tau(1); tau2 = prm.tau(2);
ki1 = prm.ki(1); ki2 = prm.ki(2); 
ni1 = prm.ni(1); ni2 = prm.ni(2);
k12 = prm.k(1); k21 = prm.k(2); 
n12 = prm.n(1); n21 = prm.n(2); %n22 = prm.n(2,2);
a1 = prm.a(1); b1 = prm.beta(1);
a2 = prm.a(2); b2 = prm.beta(2); %r2 = prm.r(2);
bs1 = prm.b(1); bs2 = prm.b(2); % basal prod rates
ic = prm.ic;
% parse inputs
fc = prm.fc; I = prm.i(1);

nx1 = fc*a1*sig(ki1,ni1,ic*I)+b1*sigflip(k12,n12,x2)+bs1;
nx2 = a2*sig(ki2,ni2,(1-icf+icf*(ic>0))*I)+b2*sigflip(k21,n21,x1)+bs2;

dx1 = (1/tau1)*(-x1+.6*(fc*a1*sig(ki1,ni1,ic*I)+b1*sigflip(k12,n12,x2)+bs1));
dx2 = (1/tau2)*(-x2+a2*sig(ki2,ni2,(1-icf+icf*(ic>0))*I)+b2*sigflip(k21,n21,x1)+bs2); % +r2*x2

xo.nx1 = nx1; xo.nx2 = nx2;
xo.dx1 = dx1; xo.dx2 = dx2;
% o