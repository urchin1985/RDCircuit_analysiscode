
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wtf';
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx','Xd','Bst','Bst2','bstates')

ckflg = 0;
svon = 0;
%% calculate NSM histogram for each locomotory state
if ~exist('corder','var')
    corder = [1 4 2 3 5 6 7 8 9 10];
end
cnum = length(corder);
clset2 = getvclrs;
nbn = -.25:.125:1.75;
bwh = .55; ylm = [0.08 .63];

% figure(125)
figure(126);clf;hold all
set(gcf,'outerposition',[450 96 135 796])
pi = 1; lp = nan(1,length(corder));
for ci = corder
    %     cdata = Cdat(:,ci);
    %     cdata = medfilt1(cdata,5);
    if exist('fpn','var')
        idx = find(Fdx==fpn&Bst'<3);
    else
        idx = find(Fdx>0&Bst'<3);
    end
    cvals = Cdat(idx,ci);
    bvals = Vdat(idx);%Xd(idx,1);
    bvec1 = bvals>0.016;
    bvec2 = bvals<-.016;
    bvec = -bvec1+bvec2;
    
    figure(126);hold on; subplot(cnum,2,(1+2*(pi-1)))
    title('.')
    lp(ci) = behclass_bp(cvals,bvec,clset2,bwh);
    plotstandard
    
    set(gca,'ytick',[.1 .3 .6],'yticklabel','','xtick',1:length(unique(bvec)));
    ylim(ylm); xlim([.25 length(unique(bvec(bvec~=0)))+.75])
    
    set(gca,'ticklength',.05*[1 1])
    pi = pi + 1;
end

% plotstandard
% calculate NSM histogram for each behavior state
clrs = getstateclr;
if ~exist('clset','var')
    %     clset = {[.49 .18 .56],[.93 .69 .13]};
    clset = {clrs(2,:),clrs(1,:)};
end
% nbn = -.25:.125:1.75;
% hbool = 0;

figure(126);hold all
pi = 1; rp = nan(1,length(corder));
for ci = corder
    %     cdata = Cdat(:,ci);
    %     cdata = medfilt1(cdata,5);
    if exist('fpn','var')
        idx = find(Fdx==fpn);
    else
        idx = find(Fdx>0);
    end
    cvals = Cdat(idx,ci);
    bvec = Bst2(idx);
    
    
    figure(126);hold on; subplot(cnum,2,(2*pi))
    rp(ci) = behclass_bp(cvals,bvec,clset,bwh);
    plotstandard
    
    
    set(gca,'ytick',[.1 .3 .6],'yticklabel','','xtick',1:length(unique(bvec)));
    ylim(ylm); xlim([.25 length(unique(bvec(bvec~=0)))+.75])
    
    set(gca,'ticklength',.07*[1 1])
    
    pi = pi + 1;
end

lpf = mafdr(lp,'BHFDR',true)
rpf = mafdr(rp,'BHFDR',true)

%%
if svon
    savname = '_nnca_bstate_bplt';
    saveas(gcf,[savpath2 gtype savname '.tif'])
    saveas(gcf,[savpath2 gtype savname '.fig'])
    saveas(gcf,[savpath2 gtype savname '.eps'],'epsc')
end

save([savpath gtype '_cabstate_padj.mat'],'lp','rp','lpf','rpf')