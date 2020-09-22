%% assign cluster inds to all datasets of interest
if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end
cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = vax_clust(fids);
cln = max(clx);

%% loop through datasets, identify and collect segments of NSM on, off and transition periods
if strcmp(gtype,'wt')
    foi = [1 3 8 9 11 12 13]; % [1 3 7 8 9 10 11 12 13];
else
    foi = 1:max(Fdx);
end

NTR = grab_clsbnds(fidata, cdata, clx, foi);
%% get behavior state bounds
