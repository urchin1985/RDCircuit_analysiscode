% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1'};

ref_gtype = 'wtf';
%% load ref cluster models
load([savpath ref_gtype '_NSM_gmfit_e2.mat'],'gmfit')
ngmf = gmfit;
nsm_gmfit = gmfit.mu;
[~,hid] = max(nsm_gmfit(:,1)); % high state id
[~,lid] = min(nsm_gmfit(:,1)); % low state id
dvec = 1:3; tid = dvec(~ismember(dvec,hid)&~ismember(dvec,lid));

load([savpath ref_gtype '_vax_gmfit_e2.mat'],'gmfit')
vax_gmfit = gmfit.mu;
vgmf = gmfit;
%% assign cluster inds to all datasets of interest

for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx')
    % classify NSM activity
    ci = 1; % NSM
    Xd = extract_c_medvar(Cdat,Fdx,ci);
    nsm_clust_tmp = cluster(ngmf,Xd(:,1:2));
    nsm_clust = nsm_clust_tmp;
    nsm_clust(nsm_clust_tmp == hid) = 3;
    nsm_clust(nsm_clust_tmp == lid) = 1;
    nsm_clust(nsm_clust_tmp == tid) = 2;
    nsm_gmfit = sortrows(nsm_gmfit);
    
    % classify vax
    Xd = extract_vel_medvar(Vdat,Fdx);
    vax_clust = cluster(vgmf,Xd);
    
    if ~isempty(dir([savpath gtype '_alldata_e2.mat']))
        save([savpath gtype '_alldata_e2.mat'],'nsm_clust','vax_clust','nsm_gmfit','vax_gmfit','ngmf','vgmf','-append')
        esle
        save([savpath gtype '_alldata_e2.mat'],'nsm_clust','vax_clust','nsm_gmfit','vax_gmfit','ngmf','vgmf')
    end
end