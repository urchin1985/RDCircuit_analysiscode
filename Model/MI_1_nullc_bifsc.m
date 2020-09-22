% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
ilst = 0:.02:5;%0:.2:3;
il = (length(ilst));
rl = ceil(length(ilst)/2);
ixp = cell(1,length(ilst));
prm.i = .5;

fiid = -20;
if fiid>0
    figure(fiid);clf;hold all
end

fizd = 133;
figure(fizd);clf;hold all
pmx = nan(1,il); pmn = pmx;
for ii = 1:il
    prm.ic = ilst(ii);
    if fiid>0
        subplot(2,il,ii); hold all;
        title(num2str(prm.ic))
    end
    
    [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,fiid,dq);
    if fiid>0
        caxis([0 5])
    end
    
    L1 = [nco.x;nco.ny]; L2 = [nco.nx;nco.y];
    P = InterX(L1,L2);
    ixp{1,ii} = P;
    pmx(ii) = max(P(2,:)); pmn(ii) = min(P(2,:));
    %     if fiid>0
   
    if fiid>0
            plot(P(1,:),P(2,:),'mo','linewidth',1.5)
        if ii>1
            plot(nco.x,pry,'k:','linewidth',1.5);
            plot(prx,nco.y,'r:','linewidth',1.5)
        end
    end
    if ii==1
        prx = nco.nx; pry = nco.ny;
    end
    
% % %     if length(P)<3
% % %     plot(ii,P(2,:),'b.','markersize',15)
% % %     else
% % %         plot(ii,P(2,[1 3]),'b.','markersize',15)
% % %     end
%     if length(P)>2
%         plot(ii,P(2,2),'.','color',[.9*[1 1] 1],'markersize',15)
%     end
end
%%
figure(fizd)
plot(pmx,':','color',.65*ones(1,3),'linewidth',1.5)
plot(pmx,'b.','markersize',15)
plot(pmn,'b.','markersize',15)

xlim([0 il]); 
xlabel('AIA activity'); ylabel('Stable roaming strengths')
cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = ['mod_bif_i' num2str(prm.i) '_n'];
svfig(fizd,svname,svpath)

