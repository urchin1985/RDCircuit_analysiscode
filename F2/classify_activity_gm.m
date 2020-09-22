%% assign cluster inds to all datasets of interest
ref_gtype = 'wt';
load([savpath ref_gtype '_NSM_gmfit_e.mat'],'gmfit')
% load([savpath ref_gtype '_alldata.mat'],'nsm_gmfit','vax_gmfit')
% gtype = 'tph1pdfr1';
nsm_gmfit = gmfit.mu
[~,hid] = max(nsm_gmfit(:,1)); % high state id
[~,lid] = min(nsm_gmfit(:,1)); % low state id
dvec = 1:3; tid = dvec(~ismember(dvec,hid)&~ismember(dvec,lid));
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx')

ci = 1; % NSM
Xd = extract_c_medvar(Cdat,Fdx,ci);
nsm_clust_tmp = cluster(gmfit,Xd(:,1:2));
nsm_clust = nsm_clust_tmp;
nsm_clust(nsm_clust_tmp == hid) = 3;
nsm_clust(nsm_clust_tmp == lid) = 1;
nsm_clust(nsm_clust_tmp == tid) = 2;
nsm_gmfit = sortrows(nsm_gmfit);

clx = nsm_clust;
chk_classifixn

if ~strcmp(gtype,'wt')
    save([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx','cnmvec','nsm_clust',...
        'vax_clust','nsm_gmfit','vax_gmfit','-append')
end
%%
ref_gtype = 'wtf';
load([savpath ref_gtype '_vax_gmfit_e2.mat'],'gmfit')
Xd = extract_vel_medvar(Vdat,Fdx);
vax_gmfit = gmfit.mu
vax_clust = cluster(gmfit,Xd(:,1:2));

clx = vax_clust;
chk_classifixn