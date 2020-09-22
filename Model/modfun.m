function xo = modfun(x1,x2,prm)
% parse params
tau1 = prm.tau(1); tau2 = prm.tau(2);
ki1 = prm.ki(1); ki2 = prm.ki(2); ni1 = prm.ni(1); ni2 = prm.ni(2);
k12 = prm.k(1,2); k21 = prm.k(2,1); k22 = prm.k(2,2); n12 = prm.n(1,2);
n21 = prm.n(2,1); n22 = prm.n(2,2);
b1 = prm.b(1); a1 = prm.a(1); be1 = prm.beta(1);
b2 = prm.b(2); a2 = prm.a(2); be2 = prm.beta(2); r2 = prm.r(2);
ic = prm.ic;
% parse inputs
fc = prm.fc; I = prm.i;

nx1 = fc*(b1+a1*sig(ki1,ni1,ic*I))-be1*sig(k12,n12,x2)+.15;
nx2 = b2+a2*sig(ki2,ni2,I)-be2*sig(k21,n21,x1);

dx1 = (1/tau1)*(-x1+.15+fc*(b1+a1*sig(ki1,ni1,ic*I))-be1*sig(k12,n12,x2));
dx2 = (1/tau2)*(-x2+b2+a2*sig(ki2,ni2,I)-be2*sig(k21,n21,x1)+r2*x2);

xo.nx1 = nx1; xo.nx2 = nx2;
xo.dx1 = dx1; xo.dx2 = dx2;
