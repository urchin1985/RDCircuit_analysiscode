cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

gtype = 'wtf';
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx','Xd','Bst','bstates')

ckflg = 0;
%% calculate NSM histogram for each locomotory state
clset2 = {[0 0 .7],[.9 0 0]};
nbn = -.25:.125:1.75;
hbool = 0;

figure(125)
figure(126);clf;hold all
pi = 1;
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
    bvec = bvec1-bvec2;
    
    figure(126);hold on; subplot(cnum,2,(1+2*(pi-1)))
    title('.')
    behclass_histl(cvals,bvec,nbn,clset2,hbool)
plotstandard    
if hbool
set(gca,'yticklabel',''); xlim([0 .3]); ylim([-.25 1.75])
else
set(gca,'ytick',0:.25:.5,'yticklabel',''); ylim([0 .5]); xlim([-.25 1.75])    
end
set(gca,'ticklength',.05*[1 1])
    pi = pi + 1;
end

% plotstandard
% calculate NSM histogram for each behavior state
if ~exist('clset','var')
    clset = {[.49 .18 .56],[.4 .67 .19],[.93 .69 .13]};
end
nbn = -.25:.125:1.75;
% hbool = 0;

figure(126);hold all
pi = 1;
for ci = corder
    %     cdata = Cdat(:,ci);
    %     cdata = medfilt1(cdata,5);
        if exist('fpn','var')
            idx = find(Fdx==fpn);
        else
            idx = find(Fdx>0);
        end
        cvals = Cdat(idx,ci);
        bvec = Bst(idx);

        
        figure(126);hold on; subplot(cnum,2,(2*pi))
    behclass_histl(cvals,bvec,nbn,clset,hbool)
    plotstandard    
    
    if hbool
set(gca,'yticklabel',''); xlim([0 .5]); ylim([-.25 1.75])
    else
     set(gca,'ytick',0:.25:.5,'yticklabel',''); ylim([0 .5]); xlim([-.25 1.25])   
    end
    set(gca,'ticklength',.05*[1 1])

    pi = pi + 1;
end

%%
savname = '_nnca_bstate_hist';
saveas(gcf,[savpath2 gtype savname '.tif'])
saveas(gcf,[savpath2 gtype savname '.fig'])
saveas(gcf,[savpath2 gtype savname '.eps'],'epsc')