function pmo = findnearestneighborf(pset,pvec)
for pi = 1:size(pset,1)
    curp = pset(pi,:);
    dist2=distcalc(curp,pvec);
    [pmin,pi2] = min(dist2);
    pmo(pi,:) = [pmin,pi2];
end
