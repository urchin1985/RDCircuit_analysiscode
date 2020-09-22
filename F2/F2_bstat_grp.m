% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','pdfracy1'};
svon = 0;
%% NSM vs AVB activitiy histogram
cset = [.6 .6 .6;0 0 0]; bwth = [1 1]*.05;
clrs = getstateclr;
ln = 3;
fi1 = 60; fi2 = 40;
fgl = length(fgtype);
bn = 200;
cdurth = 10; % min length of segment
cmth = 0.5; % min max activity

clear bstat

for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    [~,cid] = max((nsm_gmfit(:,1)));
    
    flst = unique(Fdx(fids));
    ndur = []; dwdur = []; rmdur = [];
    clear bfdat
    for fi = 1:length(flst)
        % fraction of time in states
        bdat = Bst2(Fdx == flst(fi));
        bfdat(fi) = sum(bdat==1)/length(bdat);
        
        % NSM activation duration
        ntstr = NTR(cid,fi);
        % find NSM high state with max above .5 and dur over 5s
        fs1 = find(((ntstr.cldur(:))'>=cdurth)&(ntstr.cmax>cmth));
        ntmp = ntstr.cldur(fs1); ntmp = (ntmp(:))';
        ndur = [ndur ntmp];
        
        % dwell state duration
        bvec = bdat==1;
        bp = regionprops(bvec,'area','pixelidxlist');
        if ~isempty(bp)
            if bvec(1)==1; bp(1) = []; end
            if bvec(end)==1; bp(end) = []; end
            dwdur = [dwdur;cat(1,bp.Area)];
        end
        
        % roam state duration
        bvec = bdat==2;
        bp = regionprops(bvec,'area','pixelidxlist');
        if ~isempty(bp)
            if bvec(1)==1&&bp(1).Area<=.9*length(bvec); bp(1) = []; end
            if bvec(end)==1&&bp(end).Area<=.9*length(bvec); bp(end) = []; end
            rmdur = [rmdur;cat(1,bp.Area)];
        end
    end
    
    [mn,bci] = calc_mnbci(bfdat,bn);
    bstat(fgi).bfdat = bfdat;
    bstat(fgi).bfmn = [mn bci'];
    
    [mn,bci] = calc_mnbci(ndur,bn);
    bstat(fgi).ndur = ndur;
    bstat(fgi).ndmn = [mn bci'];
    
    [mn,bci] = calc_mnbci(dwdur,bn);
    bstat(fgi).dwdur = dwdur;
    bstat(fgi).dwmn = [mn bci'];
    
    [mn,bci] = calc_mnbci(rmdur,bn);
    bstat(fgi).rmdur = rmdur;
    bstat(fgi).rmmn = [mn bci'];
end

plot_bstatset
%
if svon
    savname = 'wt_mt_bstat';
    save([savpath savname '.mat'],'bstat','fgtype')
end
%



