setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
svon = 0;

fpd = 103;
Nfg = struct('fr',[],'nw',[],'rt',[]);

for gi = 1:3
gtype = fgtype{gi};
load([savpath gtype '_alldata.mat'])
%%
foi = unique(Fdx); 
if gi==1;foi = [1 2 4 5 7:10];end
if gi==2;foi = [1 2 5 6];end
%
fp = 1;
frc = []; nwt = [];
for fi = (foi(:))'
    %%
    cdats = Cdat(Fdx==fi,1);
    vdats = Vdat(Fdx==fi,1);
    nnt = nsm_clust(Fdx==fi);
    
    frc(fp) = sum(nnt>2)/length(nnt); nwt(fp) = length(nnt);
    
    fp = fp+1;
end
    Nfg(gi).fr = frc;
    Nfg(gi).nw = nwt;
    Nfg(gi).rt = sum(frc.*nwt)/sum(nwt);
end
frc
Nfg.rt
%% plot
clrs = {.24*ones(1,3);[.9 .5 .1];[1 .8 .3]};
bdat = {Nfg.fr};
fidx = 63;
[bm,bci] = make_barplt([],bdat,clrs,fidx,[],1);
set(gca,'yticklabel','')
%%
if svon
savname = [gtype '_NSMonfrc'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

save([savpath savname '.mat'],'Nmat','Nbd','nsrt')
end
% % figure(2);clf;hold all;subplot 211;hold all;plot(cdats);plot(nnt)
% % subplot 212;cla;hold all;plot(vdats);yyaxis right;plot(bt2)