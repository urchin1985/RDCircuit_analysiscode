%% load data at different time resolutions
dtst = [2 10 20 40 60]/2; dtn = length(dtst);
for dti = 1:dtn
    dt = dtst(dti);
    load([savpath gtype '_statetrans_3nn_' num2str(dt) 's.mat'],'T_on','tpre','tpost','TP')
    pred{dti} = TP.prepc; posd{dti} = TP.pospc; prec{dti} = TP.preca; posc{dti} = TP.posca;
    prmst{dti}= TP.prem; pomst{dti} = TP.posm; prcst{dti} = TP.nsmpre; pocst{dti} = TP.nsmpos;
end

cnm = length(T_on); trn = size(T_on(1).vals,1);
prg = prn(1):pon(end);

%%
dti = 5; % use 30s res
tres = 300;
foi = 40;
coi = [3 8 9];

% first exclude peri-NSMon data points from full dataset
npre = 60; npost = 660; % in .5s res
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
                nposi = [nposi noni(nii):min(fdful(end),(noni(nii)+npost))];
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
figure(foi);clf;hold all
subplot 221; hold all
scatter3(rf*ctm{1},ctm{2},ctm{3},18,.5*ones(1,3),'filled')

subplot 223; hold all
scatter3(rf*ctm{1},ctm{2},ctm{3},18,.5*ones(1,3),'filled')
scatter3(rf*cprm{1},cprm{2},cprm{3},18,'r','filled')

subplot 222; hold all
make2dhist(ctm{1},ctm{2},bn);

subplot 224; hold all
make2dhist(cprm{1},cprm{2},bn);

figure(foi+5);clf; hold all
cxd = {ctm{1},cprm{1}}; cyd = {ctm{2},cprm{2}};

hs = schist_fun(cxd,cyd,[],[.05 .05]);
% scatter(ctm{1},ctm{2},18,'k','filled','markerfacealpha',ma,'markerfacealpha',ma)
%%
tfl = size(pred{dti},2);
trng = tfl+((-round(npre/dtst(dti))):0); % full span 300s

figure(foi); hold all
subplot 223; hold all
for tri = 1:tn
    
    ppx = [pred{dti}(tri,trng,coi(1))];
    ppy = [pred{dti}(tri,trng,coi(2))];
    ppz = [pred{dti}(tri,trng,coi(3))];
    ppt = (trng)/trng(end);
    
    pid = find(~isnan(ppx)&~isnan(ppy)&~isnan(ppz));
    
    scatter3(ppx(pid),ppy(pid),ppz(pid),18,ppt(pid),'filled')
    
end

xlabel(cnmvec{coi(1)});ylabel(cnmvec{coi(2)});zlabel(cnmvec{coi(3)});
colormap parula

