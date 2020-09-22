% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i'};
svon = 0;
%% NSM vs AVB activitiy histogram
ckflg = 1;

for fgi = 1%:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    Bst2 = Bst;
    for fi = (unique(Fdx(fids)))'
        fid = Fdx==fi;
        bdat = Bst(fid);
        vdat = Vdat(fid);
        ndat = Cdat(fid,1);
        
        bti = bdat==3; % transition state
        tp = regionprops(bti,'PixelIdxList');
        for tpi = 1:length(tp) % for each bout of transition period, check flanking states and absorb into flanking or assign to neighboring states
            ctp = [tp(tpi).PixelIdxList(1) tp(tpi).PixelIdxList(end)];
            cfk1 = min(length(bdat),max(1,ctp(1)+(-5:-1)));
            cfk2 = min(length(bdat),max(1,ctp(end)+(1:5)));        
            bfk1 = (bdat(cfk1)); bfk1(bfk1==3) = [];
            bfk1 = median(bfk1);
            bfk2 = (bdat(cfk2)); bfk2(bfk2==3) = [];
            bfk2 = median(bfk2);
            bfk = [bfk1 bfk2];
            if length(unique(bfk))==1
                bdat(ctp(1):ctp(2)) = bfk(1);
            else
                ctmid = round(median(ctp));
                bdat(ctp(1):ctmid) = bfk(1);
                bdat(ctmid:ctp(2)) = bfk(2);
            end
        end
        
        % getting rid of spurious dwelling states
        bdat = imclose(bdat>1,strel('disk',3));
        bdat = double(bdat)+1;
        
        if ckflg
        figure(15);clf;hold all
        subplot 211; hold all
        imagesc(Bst(fid));
        plot(vdat/prctile(vdat,98))
        subplot 212; hold all
        imagesc(bdat);
        plot(ndat)
        
        [x,y] = ginput(1);
        end
        
        Bst2(fid) = bdat;
    end
%     save([savpath gtype '_alldata.mat'],'Bst2','-append')
end

