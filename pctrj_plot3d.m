cvc = 'b';

if ~exist('ncmap','var')
    ncmap = jet(100);
end

figure(foi);
subplot(4,5,ri); hold all
view(gca,[-107.6 17.9]); grid on
plot3(pl(:,1),pl(:,2),pl(:,pd3),cvc,'linewidth',2)
plot3(prm(:,1),prm(:,2),prm(:,pd3),'ko-','markersize',5)
scatter3(prm(:,1),prm(:,2),prm(:,pd3),35,ncmap(round(prc*150),:),'filled','o')

plot3(pom(:,1),pom(:,2),pom(:,pd3),'k^-','markersize',5)
scatter3(pom(:,1),pom(:,2),pom(:,pd3),35,ncmap(round(poc*150),:),'filled','^')

xlabel('PC1');ylabel('PC2');zlabel(['PC' num2str(pd3)]);
% xlim([-1.2 1]); ylim([-.4 1.3]);
% zlim([-1 .6])
set(gca,'ydir','reverse')
view(gca,vwa); grid on

cdt = caset(ri,:); pci = find(~isnan(cdt));
cdt = cdt(pci); cdt(cdt<0)=0; cvl = min(100,max(1,round(cdt*150)));
plot3(pset(ri,pci,1),pset(ri,pci,2),pset(ri,pci,pd3),'color',.5*ones(1,3))
plot3(pset(ri,pci(end),1),pset(ri,pci(end),2),pset(ri,pci(end),pd3),'o','color',.2*ones(1,3))
scatter3(pset(ri,pci,1),pset(ri,pci,2),pset(ri,pci,pd3),25,ncmap(cvl,:),'filled','o')

figure(11);hold all
subplot(4,5,ri)
plot(caset(ri,:),'o-')