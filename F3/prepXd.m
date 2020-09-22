Xd = []; 
for fi = 1:max(Fdx) %[1 3 4 7:max(Fdx)] % 1:max(Fdx) %
    di = find(Fdx == fi);
    vdata = Cdat(di,coi);
%     vdata = medfilt1(vdata/prctile(vdata,99),5);
    vbin = medfilt1(double(vdata>=.3),7);
    % %%
    % di = find(Fdx == 8);
    % yin = Vdat(di);
    xin = 1:length(vdata);
    yin = vdata/prctile(vdata,99);
    vmed = slidingmedian(xin,yin,55,0);
    vmin = slidingmin(1:length(vmed),vmed,1700,0);
    vmed = vmed - vmin;
    vvar = slidingvar(xin,vmed,85,0);
    
    pid = vmed>=-.1;
    Xd = [Xd; [(abs(vmed(:))) log(abs(vvar(:))) fi*ones(length(vmed),1)]];
    
end