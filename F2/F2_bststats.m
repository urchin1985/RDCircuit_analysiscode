% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
svon = 0;
%% NSM vs AVB activitiy histogram
cset = [.6 .6 .6;0 0 0]; bwth = [1 1]*.05;
clrs = getstateclr;
ln = 3;
fi1 = 60; fi2 = 40;
fgl = length(fgtype);
clear fh bdful bdmn bdci bvful bvmn bvci

for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids);
    bdata = Bst(fids);
    nlx = nsm_clust(fids);
    %     vlx = vax_clust(fids);
    
    for bi = 1:2%length(unique(bdata))
        % calculate fraction of time in state
        bfrt(fgi,bi) = sum(bdata==bi)/length(bdata);
        
        % gather and compute average state duration/spd
        bvc = bdata==bi;
        bp = regionprops(bvc,'area','pixelidxlist');
        bdur = cat(1,bp.Area);
        db = find(bdur<10);
        bdur(db) = [];
        bp(db) = [];
        
        % state dur
        bdful(fgi).st(bi).bdur = bdur;
        bdmn(fgi,bi) = mean(bdur);
        %     [~,bdci(:,fgi,bi)] = calc_mnbci(bdur,[]);
        
        % state spd
        bvm = [];
        for bbi = 1:length(bp)
            bvz = (vdata(bp(bbi).PixelIdxList));
            bvz(bvz<=0) = [];
            bvm = [bvm median(bvz)];
        end
        bvful(fgi).st(bi).bvm = bvm;
        
        % compute speed statistic during state
        vdtmp = (vdata(bdata==bi));
        vdtmp(vdtmp<=0) = [];
        bvful(fgi).st(bi).vdat = vdtmp;
        bvmn(fgi,bi) = mean((vdata(bdata==bi)));
        %     [~,bvci(:,fgi,bi)] = calc_mnbci(abs(vdata(bdata==bi)),[]);
    end
    
    % idx = vdata>-10&(cdata(:,4)>0)&(cdata(:,1)>0); % vdata>10&(cdata(:,4)>0.01);
end

% plot_bfrt
plot_bstat
% plot_bstat_d

if svon
savname = 'wt_mt_bvbdstat';
save([savpath savname '.mat'],'bvful','bdful','fgtype')
end



