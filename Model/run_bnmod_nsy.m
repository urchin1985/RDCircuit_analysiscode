% parse mod states
x1 = Xt(1);
x2 = Xt(2);

prm.fc = inp.fc(min(length(inp.fc),ti));
prm.i = inp.i(ti);
xo = nmfun(x1,x2,prm);
nst = nf*prm.tau.*normrnd(0,1,1,2);
dX = [xo.dx1 xo.dx2]+nst;
