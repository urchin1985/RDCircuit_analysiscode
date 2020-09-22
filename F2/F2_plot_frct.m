% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','pdfracy1'};
svon = 0;
%% just plot fract time in states as stacked bars, tii
load([savpath 'wt_mt_bstat.mat'],'bstat','fgtype')

fl = length(fgtype);
bwh = .6;
clrs = getstateclr;

% 5-ht muts
figure(33);clf; hold all
subplot(1,2,1); hold all
bmat = []; clear brm
pi = 1;
for fgi = [1 2 3]
    bpy =  bstat(fgi).bfmn(1); bpy2 = 1-bpy;
    bmat = [bmat;[bpy bpy2]];
    brm(pi,:) = bstat(fgi).bfmn;
    pi = pi+1;
end
bh = bar(bmat,'stacked','barwidth',bwh);
bh(1).FaceColor = clrs(3,:); bh(2).FaceColor = clrs(1,:);
plot(ones(2,1)*(1:(pi-1)),(brm(:,2:3))','k','linewidth',1)
plotstandard
set(gca,'yticklabel','','xlim',[0 4])

% pdf muts
figure(33);hold all
subplot(1,2,2); hold all
bmat = []; clear brm
pi = 1;
for fgi = [1 4 6]
    bpy =  bstat(fgi).bfmn(1); bpy2 = 1-bpy;
    bmat = [bmat;[bpy bpy2]];
    brm(pi,:) = bstat(fgi).bfmn;
    pi = pi+1;
end
bh = bar(bmat,'stacked','barwidth',bwh);
bh(1).FaceColor = clrs(3,:); bh(2).FaceColor = clrs(1,:);
plot(ones(2,1)*(1:(pi-1)),(brm(:,2:3))','k','linewidth',1)
plotstandard
set(gca,'yticklabel','','xlim',[0 4])
set(gcf,'outerposition',[15 550 245 215])

if svon
    savname = 'wt_mt_frct';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end