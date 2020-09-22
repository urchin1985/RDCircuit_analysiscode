ha(1)=-.21;
% han = normrnd(0,aem,[1 N]); han = 0.4*smooth(han,71);

for ti = 10:300
    
    dha = hp1*(-abs(ha(ti-1)))+han(ti);
    ha(ti) = (abs(ha(ti-1))+dha*prm.dt)*sign(ha(ti-1));
    disp([ha(ti-1) dha*prm.dt han(ti)*prm.dt ha(ti)])
    [x,y] = ginput(1);
end
figure(6);clf;hold all
yyaxis left;plot(ha)
yyaxis right;plot(han)
yyaxis right;plot([0 300],[0 0],':')