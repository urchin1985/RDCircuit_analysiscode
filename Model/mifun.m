function xo = mifun(x1,x2,prm)
% parse params
tau1 = prm.tau(1); tau2 = prm.tau(2);
k12 = prm.k(1); k21 = prm.k(2); 
n12 = prm.n(1); n21 = prm.n(2); %n22 = prm.n(2,2);
b1 = prm.beta(1);
b2 = prm.beta(2); %r2 = prm.r(2);
bs1 = prm.b(1); bs2 = prm.b(2); % basal prod rates
% parse inputs
I = prm.i(1); ic = prm.ic>0;

nx1 = b1*sig(k12-1*I*ic,n12,-x2)+bs1;
nx2 = b2*sig(k21-I*ic-.1*(I>=0),n21,-x1)+bs2;

dx1 = (1/tau1)*(-x1+nx1);
dx2 = (1/tau2)*(-x2+nx2); 

xo.nx1 = nx1; xo.nx2 = nx2;
xo.dx1 = dx1; xo.dx2 = dx2;
% o