    gtype = 'wtf';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

fids = find(Fdx>0);
cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

tpre = 720+1; tpost = 480+1;
if ~exist('ncmap','var')
    ncmap = jet(100);
end


%%
dti = 5; % use 30s res
tres = 300;
foi = 35;
coi = [3 8 9];

% first exclude peri-NSMon data points from full dataset
npre = 120; npost = 240; % in .5s res
[~,cid] = max(nsm_gmfit(:,1));

% extract time points pre and post nsm on
nprei = []; nposi = []; nonl = [];
fdlst = unique(Fdx);
for dfi = 1:size(NTR,2)
    if ~isempty(NTR(1,dfi).cnbr)
        fdful = find(Fdx==fdlst(dfi));
        ntstr = NTR(cid,dfi);
        noni = ntstr.clstrt(:,2);
        nonl = [nonl;noni];
            for nii = 1:length(noni)
                nprei = [nprei max(fdful(1),(noni(nii)-npre)):noni(nii)];
                nposi = [nposi min(fdful(end),(noni(nii)+60)):min(fdful(end),(noni(nii)+npost))];
            end
    end
end

ctm = cell(1,3); cprm = ctm; cpom = ctm;
for fi = unique(Fdx')
    fids = find(Fdx==fi);
    bids = find(Bst(fids) == 2);
    kpf = find(~ismember(fids,nprei)&~ismember(fids,nposi));
    kpf(~ismember(kpf,bids)) = [];
    kpref = find(ismember(fids,nprei));
    kposf = find(ismember(fids,nposi));
    cdat = Cdat(fids,coi);
    fidat = Fdx(fids);
    vdat = Vdat(fids);
    nlb = nsm_clust(fids);
    vlb = vax_clust(fids);
    
    for ci = 1:3
        [~,ctmp] = tilingmean(1:length(vdat),cdat(:,ci),tres);
        ctt = ctmp(kpf);
        ctm{ci} = [ctm{ci} (ctt(:))'];
        cprm{ci} = [cprm{ci} ctmp(kpref)];

        cpom{ci} = [cpom{ci} ctmp(kposf)];
    end
end
bn = {[0:.05:1.2]*rf;0:.05:1};
rf = 1;
%%
figure(foi);clf; hold all
cxd = {ctm{1},cprm{1}}; cyd = {ctm{2},cprm{2}};

hs = schist_fun(cxd,cyd,[],.5*[1 1]);
% scatter(ctm{1},ctm{2},18,'k','filled','markerfacealpha',ma,'markerfacealpha',ma)
