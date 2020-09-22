% xing tracks before xing
tn = find(sum(~isnan(xgt.stb),2)>1);
dtx = nan(size(xgt.trx));
stx = dtx; spx = dtx; 
dtb = dtx; stb = dtx; spb = dtx;

dtf = [xgt.d2bdb -xgt.d2bda];
stf = [xgt.stb xgt.sta];
spf = [xgt.sp2bdb xgt.sp2bda];

for i = 1:length(tn)
    ti = tn(i);
    ixb = find(~isnan(xgt.trxb(ti,:))); ixb = ixb(1):ixb(end);
    ixbf = find(~isnan(dtf(ti,:))); ixbf = ixbf(1):ixbf(end);
    frall = find(~isnan(xgt.trx(ti,:))); %frall = frall(1):frall(end);
    frall = frall(1)-1+(1:length(ixbf));
    frng = frall(1:length(ixb));
    dtb(ti,frng) = dtf(ti,ixb);
    stb(ti,frng) = stf(ti,ixb);
    spb(ti,frng) = spf(ti,ixb);

    dtx(ti,frall) = dtf(ti,ixbf);
    stx(ti,frall) = stf(ti,ixbf);
    spx(ti,frall) = spf(ti,ixbf);
end