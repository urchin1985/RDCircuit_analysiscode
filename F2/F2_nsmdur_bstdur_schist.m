% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
cid = 3; % 3~NSM high periods
bid = 3;
svon = 0;
%% extract transition period data and project onto PC space as defined by wild type
bstdur = cell(1,length(fgtype)); ndur = bstdur;

for gi = 1:length(fgtype)
    gtype = fgtype{gi};
    load([savpath gtype '_alldata.mat'])
        if strcmp(gtype,'wtf')
            load([savpath gtype '_NSM_triggstat_2.mat'])
    else
    load([savpath gtype '_NSM_triggstat.mat'])
        end
        
    fids = find(Fdx>0);
    
    extract_ndur_bstdur
    
end
%%
c1 = 1; ffi = 22; bw = 90;
for fgi = 1:length(fgtype)
    figure(ffi+fgi-2);clf;hold all;colormap jet
    c2 = fgi;
    lx = 119+(fgi-2)*230;
    ly = 457;
    scatter_ndur_bstdur
    
end
%%
if svon
    for fgi = 2:length(fgtype)
        figure(ffi+fgi-2);
        
        % save data for direct plotting
        savname = ['wt_' fgtype{fgi} '_nsmdwdur_schist'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
end
%% run stats on ndur and bstdur
nps = []; bps = [];
for i=2:length(fgtype)
    [p,h]=ranksum(ndur{i},ndur{1});
    nps(i-1) = p;
    
    [p,h]=ranksum(bstdur{i},bstdur{1});
    bps(i-1) = p;
end

[nfdr] = mafdr(nps,'BHFDR',true);
[bfdr] = mafdr(bps,'BHFDR',true);
%%
if svon
    savname = 'wt_mt_nsmdwdur_schist';
    save([savpath savname '.mat'],'ndur','bstdur','fgtype','nps','bps','nfdr','bfdr')
end