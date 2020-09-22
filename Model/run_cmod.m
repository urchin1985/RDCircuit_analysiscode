% parse mod states
O1 = Xt(1);
O2 = Xt(2);

% parse params
gm1 = prm.gm(1);
gm2 = prm.gm(2);
fb21 = prm.fb(2,1);
fb12 = prm.fb(1,2);
k21 = prm.kf(1,2);
k12 = prm.kf(2,1);
k2 = prm.kf(2,2);
n21 = prm.nf(1,2);
n12 = prm.nf(2,1);
n2 = prm.nf(2,2);
cf = prm.cflg;

dO1 = -gm1*O1+I1+cf*I2-fb21*(O2.^n21./(k21^n21+O2.^n21));
dO2 = -gm2*O2+I2-fb12*((O1^n12)/(k12^n12+O1^n12))+...
    fb12*((O2^n2)/((k2)^n2+O2^n2));
dX = [dO1,dO2];