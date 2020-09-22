setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
svon = 0;

gtype = 'wtf';
load([savpath gtype '_alldata_615.mat'])
load([savpath gtype '_ngbgtrig_R2D.mat'],'Nbd','nsrt')
%%
BNd = []; BNc = [];
foi = unique(Fdx); 
%
fiid = 123; 
for fi = (foi(:))'
    %%
    cdats = Cdat(Fdx==fi,1);
    vdats = Vdat(Fdx==fi,1);
    bt2 = Bst2(Fdx==fi);
    nnt = Nst(Fdx==fi);
    
    [bdurs,bidx,bseg] = idx2bseg(bt2);
    [ntdurs,ntidx,ntseg] = idx2bseg(nnt);
    
    bid = 1:length(bidx);
    dli = bseg(:,1)<=3|(bseg(:,1)>=(length(cdats)-5));
    bid(dli) = []; bdurs(dli) = [];
    bnp = []; bnp1 = [];
    bp = 1;
    for bi = bid
        bpid = bidx(bi).PixelIdxList;
        bbd = bseg(bi,:);
        bnp(bp,1) = bdurs(bi);
        bnp1(bp,1) = bdurs(bi);
        bno = []; bno1 = [];
        for ni = 1:size(ntseg,1)
            nbd = ntseg(ni,:);
            nb1 = nbd-bbd(1); nbp1 = nb1(1)*nb1(2);
            nb2 = nbd-bbd(1); nbp2 = nb2(1)*nb2(2);
            nbp3 = (nbd(1)-bbd(1))*(nbd(2)-bbd(2));
            if nbp1<=0||nbp2<=0||nbp3<=0
                bno = [bno nbd(1):nbd(2)];
                if nbp1<=0
                    bno1 = [bno1 nbd(1):nbd(2)];
                end
            end
        end
        bnp(bp,2) = length(bno);
        bnp1(bp,2) = length(bno1);
        bp = bp+1;
    end
    BNd = [BNd;bnp];
    BNc = [BNc;bnp1];
end

%% plotting
csiz = 40; op = .5; clr = 'b';

figure(fiid);clf; hold all
setfigsiz([29 500 215 279])
tx = BNd(:,2); ty = BNd(:,1);
transparentScatter(tx,ty,csiz,op,clr)
plotstandard
set(gca,'xlim',[0 1500],'xtick',0:600:2000,'ylim',[0 1500],...
    'ytick',0:600:2000,'yticklabel','')
axis equal; axis square

figure(fiid+1);clf; hold all
setfigsiz([29 200 215 279])
tx = BNc(:,2); ty = BNc(:,1);
transparentScatter(tx,ty,csiz,op,clr)
plotstandard
set(gca,'xlim',[0 1500],'xtick',0:600:2000,'ylim',[0 1500],...
    'ytick',0:600:2000,'yticklabel','')
axis equal; axis square
%% savin'
if svon
    %%
    figure(fiid)
    savname = [gtype '_RNdursct'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
        figure(fiid+1)
    savname = [gtype '_RNdursct_c'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'BNd','BNc')
    
end
% % figure(2);clf;hold all;subplot 211;hold all;plot(cdats);plot(nnt)
% % subplot 212;cla;hold all;plot(vdats);yyaxis right;plot(bt2)