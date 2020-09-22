% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i'};
svon = 0;
%% NSM vs AVB activitiy histogram
ckflg = 1;

for fgi = 1%length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    % cdata = zscore(cdata,[],1);
    fidata = Fdx(fids);
    vdata = Vdat(fids);
    
    disp('Running ca and vax classification...')
    classify_activity_gm
    
    disp('Fitting hmm on vax cluster results...')
    get_vax_hmm
    
    if fgi>1
        disp('Triggering data on NSM activity clusters...')
        NSM_trigger_only
    end
end