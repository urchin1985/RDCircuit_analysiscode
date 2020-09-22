ck1 = zeros(1,3); ck2 = ck1;
ck1(1) = XS(idn,1)>XS(1,1); ck1(2) = XS(idn*2,1)<XS(idn,1)/4;
ck1(3) = XS(end,1)>=.8*XS(idn,1)&XS(end,1)>=2*XS(idn*2,1);
ck2(1) = XS(idn,2)<XS(1,2); ck2(2) = XS(idn*2,2)>XS(idn,2)*2;
ck2(3) = XS(end,2)<=.5*XS(idn*2,2);
ckt = (mean(ck1)+mean(ck2))>=2;