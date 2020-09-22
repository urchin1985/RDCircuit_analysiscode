% specify circuit params
clear
nmparams5620
xr1 = [-1 10]; xr2 = xr1; inc = [.2 .2];
prm.b = [0 1];
prm.tau = 5*[1 1];
prm1 = prm; prm1.ic = 0; prm.ic = 2;

idn = 1300; icf = 1;
fid = 0; dq = 0; nl = .25;
XS0=[6 0]; rN = 200; 
%%
iplst = 0:.1:2.5; b1lst = -3:.2:2;
% rdtmat = nan(length(iplst),length(b1lst));
% rmpmat1 = nan(length(iplst),length(b1lst));
% rmpmat2 = rmpmat1;

figure(97);clf;hold all
xlim(.5+[0 length(b1lst)]);ylim(.5+[0 length(iplst)])
colormap(cmap)

for ii = 1(length(iplst))
    ip0 = iplst(ii);
    inp.i = ip0*ones(1,idn); %  .3*ones(1,idn) 0.1*ones(1,200)
    
    for bi = 1:(length(b1lst))
        prm.b(1) = b1lst(bi); prm1.b(1) = b1lst(bi);
        
        rmpc = cell(1,2);
        for ri = 1:rN
            XS1 = runnmod_nsy_icf(XS0,prm,icf,inp,nl);
            rdtp = (XS1(300:end,1)<=3.5&XS1(300:end,2)>=1.6);
            rmpc{1}(ri) = sum(rdtp)/length(rdtp);
            
            XS2 = runnmod_nsy_icf(XS0,prm1,icf,inp,nl);
            rdtp = (XS2(300:end,1)<=3.5&XS2(300:end,2)>=1.6);
            rmpc{2}(ri) = sum(rdtp)/length(rdtp);
            
        end
        
        rdtmat(ii,bi) = -nanmean(rmpc{1})+nanmean(rmpc{2});
        rmpmat1(ii,bi) = nanmean(rmpc{1});
        rmpmat2(ii,bi) = nanmean(rmpc{2});

        subplot 121;imagesc(rmpmat1)
        caxis([.2 1.2])

        subplot 122;imagesc(rmpmat2)

        %         cmap = cmap_gen({[0 0 1],[1 0 0]},0);
        caxis([.2 1.2])
        drawnow limitrate
    end
end
%%
clrs = getstateclr;
cmap = cmap_gen_flx({[0 0 .5],clrs(1,:)},[50 50]);

rmpmat1(1:6,:) = ones(6,1)*rmpmat1(6,:);
figure(100);clf;hold all
surf(zeros(size(rmpmat1)),rmpmat1,'linestyle','none','facecolor','interp')
% cmap = cmap_gen_flx({[0 0 1],[1 0 0]},[100 50]);
colormap(cmap)
caxis([-.2 1.2])
hold all
plot(16,14,'k.','markersize',18)
plot(16,6.5,'k.','markersize',18)
% plot(16,2,'k.','markersize',18)

% % % % set(gca,'ylim',.5+[4 length(b1lst)-4],'xlim',.5+[2 length(iplst)-6],...
% % % %     'ytick',5:5:31,'xtick',3:5:18,'xticklabel','','yticklabel','',...
% % % %     'tickdir','out','ticklength',.035*[1 1])
set(gca,'xlim',1+[0 length(b1lst)-1],'ylim',[1 length(iplst)-6],...
    'xtick',1:10:31,'ytick',1:5:30,'xticklabel','','yticklabel','',...
    'tickdir','out','ticklength',.035*[1 1])
set(gcf,'outerposition',[80 720 270 336])
%% saving plot and data
setsavpath
if svon
    savname = 'NMA_rmfrc_aia_v2';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'iplst','b1lst','prm','icf','nl',...
        'rdtmat','rmpmat1','rmpmat2')
end