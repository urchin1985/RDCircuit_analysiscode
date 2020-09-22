% parse mod states
x1 = Xt(1);
x2 = Xt(2);

prm.fc = inp.fc(min(length(inp.fc),ti));
prm.i = inp.i(ti);

switch gtp
    case 1 % wt
        xo = nmfun2(x1,x2,prm,icf);
    case 2 % pdfr1
        xo = nmfun2_pdfr(x1,x2,prm,icf);
    case 3 % tph1
        xo = nmfun2_tph(x1,x2,prm,icf);
end

nst = nf*prm.tau.*normrnd(0,1,1,2);
dX = [xo.dx1 xo.dx2]+nst;
