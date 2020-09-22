RDst = [];
for fi = (unique(Fdx))'
    fln = sum(Fdx==fi);
    cbi = find(Bnd(:,3)==fi);
    cbd = Bnd(cbi,:);
    
    rdtmp = zeros(1,fln);
    for ci = 1:size(cbi)
        rdtmp(cbd(ci,1):cbd(ci,2)) = 1;
    end
    RDst = [RDst rdtmp];
end