savfile = [savpath gtype '_NSM_triggstat616.mat'];
load(savfile,'NTR','TDF_on','TDF_off','TD_on','TD_off','tid_on','tid_off','TWon','TWoff','TDdur')
load([savpath gtype '_alldata_613.mat'])
svon = 0;
%%
Nbnd = []; Nst = [];
crflg = 1;
%%
[~,cid] = max(nsm_gmfit(:,1));
for fi = 5%unique(Fdx')
    fid = find(Fdx == fi);
    bt2 = Bst2(fid);
    nca = Cdat(fid,1);
    vca = Vdat(fid);
    ncl = nsm_clust(fid);
    ntstr = NTR(cid,fi);
    ntbnd = [ntstr.clstrt(:,1) ntstr.clend(:,1)];
    ntd = seg2idx(ntbnd,length(nca));
    
    figure(133);clf;hold all
    subplot 311; hold all
    title([gtype ' File #' num2str(fi)])
    imagesc([1 length(nca)],0.5*[1 1],bt2); hold all
        set(gca,'ydir','normal','ylim',[0 1],'xlim',[0 length(nca)])
    yyaxis right;plot(1:length(nca),vca/prctile(vca,95),'r')
    hold all;plot([1 length(nca)],[0 0],'k')
    ylim([-2 1.5])
    subplot 312; hold all
    imagesc([1 length(nca)],0.5*[1 1],[ncl']); hold all
    plot(1:length(nca),nca/prctile(nca,99.5),'r')
    set(gca,'ydir','normal','ylim',[0 1],'xlim',[0 length(nca)])
    
    if crflg
        ntmp = ntd;
        for ni = 1:size(ntbnd,1)
            nbz = [ntstr.clstrt(ni) ntstr.clend(ni)];
            if diff(nbz)
                cfg = 1; ndl = 1;
                while cfg
                    subplot 313; cla; hold all
                    imagesc([1 length(ntmp)],0.5*[1 1],ntmp); hold all
                    plot((ones(2,1)*nbz),[0 0;1 1],'r','linewidth',1.5)
                    plot(1:length(nca),nca/prctile(nca,99.5),'m'); hold all
                    set(gca,'ydir','normal','ylim',[0 1],'xlim',[0 length(nca)])
                    rply = input('keep current bounds? Y=0/N=1/D=2: ');
                    switch (rply)
                        case 0
                            if ndl
                            Nbnd = [Nbnd; [(nbz(:))' fi]];
                            ntmp(nbz(1):nbz(end)) = 1;
                            cfg = 0;
                            end
                        case 1
                            subplot 313
                            title('left bound')
                            [x(1),~] = ginput(1);
                            subplot 313
                            title('right bound')
                            [x(2),~] = ginput(1);
                            ntmp(nbz(1):nbz(end)) = 0;
                            ntmp(x(1):x(2)) = 1;
                            nbz = x;
                        case 2
                            ntmp(nbz(1):nbz(end)) = 0;
                            ndl = 0;
                    end
                end
            else
                ntmp(nbz(1):nbz(end)) = 0;
            end
        end
        Nst = [Nst;ntmp(:)];
    else
        subplot 313; cla; hold all
        imagesc([1 length(ntmp)],0.5*[1 1],ntmp); hold all
        plot((ones(2,1)*nbz),[0 0;1 1],'r','linewidth',1.5)
        plot(1:length(nca),nca/prctile(nca,99.5),'m'); hold all
        set(gca,'ydir','normal','ylim',[0 1],'xlim',[0 length(nca)])
       [x,y] = ginput(1); 
    end
end
%%
if svon
    save([savpath gtype '_alldata_613.mat'],'Nst','Nbnd','-append')
save([savpath gtype '_alldata_615.mat'],'Cdat','Tdat','Vdat','Fdx','nsm_clust',...
    'vax_clust','Xd','clx','seqs','bstates','Bst','Bst2','Bnd','Nst','Nbd','estTR','estE')

end