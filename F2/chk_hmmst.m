if ~exist('ckflg','var')
    ckflg = 1;
end
bstates = []; Bst = []; Bst2 = []; Bnd = []; RDst = [];
%%
for fi = 5%unique(Fdx')
    fid = find(Fdx == fi);
    seq = seqs{fi};
    state = hmmviterbi(seq,estTR,estE);
    nca = Cdat(fid,1);
    vca = Vdat(fid);
    ncl = nsm_clust(fid);
    
    bdat = state; bstproc_wd
    bdtmp = 2-bdat;
    figure(2);clf;hold all
    subplot 311
    imagesc([1 length(nca)],0.5*[1 1],bdat); hold all
    caxis([1 2])
    plot(1:length(nca),(double(seq)-2)/2,'k','linewidth',1.5); hold all
    plot(1:length(nca),vca/prctile(vca,95),'m'); hold all
    set(gca,'ydir','normal','ylim',[-1.5 1.5])
    title([gtype ' File #' num2str(fi)])
    
    subplot 312
    imagesc([1 length(nca)],0.5*[1 1],ncl'); hold all
    colormap summer
    plot(1:length(nca),(double(seq)-2)/2,'k','linewidth',1.5); hold all
    plot(1:length(nca),nca/prctile(nca,95)); hold all
    set(gca,'ydir','normal','ylim',[-1.5 1.5])
    
    % check segmentation
    bp = regionprops((bdtmp>0),'PixelIdxList'); % extract current D state bounds
    %%
    for bi = 1:length(bp)
        bbz = bp(bi).PixelIdxList([1 end]);
        if diff(bbz)
            cfg = 1;
            while cfg
                subplot 313; cla; hold all
                imagesc([1 length(nca)],0.5*[1 1],bdtmp); hold all
                plot((bbz*ones(1,2))',[0 0;1 1],'r','linewidth',1.5)
                plot(1:length(nca),vca/prctile(vca,95),'m'); hold all
                set(gca,'ydir','normal','ylim',[-1.5 1.5],'xlim',[0 length(nca)])
                rply = input('keep current bounds? Y=0/N=1/D=2: ');
                switch (rply)
                    case 0
                        Bnd = [Bnd; [(bbz(:))' fi]];
                        cfg = 0;
                    case 1
                        subplot 313
                        title('left bound')
                        [x(1),~] = ginput(1);
                        subplot 313
                        title('right bound')
                        [x(2),~] = ginput(1);
                        bdtmp(bbz(1):bbz(end)) = 0;
                        bdtmp(x(1):x(2)) = 1;
                        bbz = x(:);
                    case 2
                        bdtmp(bbz(1):bbz(end)) = 0;
                end
            end
        else
            bdtmp(bbz(1):bbz(end)) = 0;
        end
                RDst = [RDst;bdtmp(:)];
    end
    bstates{fi} = state;
    Bst = [Bst state];
    Bst2 = [Bst2 bdtmp];
end