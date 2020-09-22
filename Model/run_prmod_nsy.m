% parse mod states
prm.i = inp.i(ti);
xo = prfun(Xt,prm);

nst = nf*[normrnd(0,1,1,2) 0 0];
dX = xo.dx+nst;
