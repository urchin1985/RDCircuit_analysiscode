cvc = 'b';

if ~exist('ncmap','var')
    ncmap = jet(100);
end

figure(foi); clf; hold all

pnum = size(pset,1); rn = floor(sqrt(pnum)); cn = ceil(pnum/rn);

for ri = proi

figure(foi);hold all; grid on
xlabel('PC1');ylabel('PC2');%zlabel(['PC' num2str(pd3)]);

xlim([-3 4]); ylim([-1.8 2.8])

cdt = caset(ri,:); pci = find(~isnan(cdt));
cdt = cdt(pci); cdt(cdt<0)=0; cvl = min(100,max(1,round(cdt*150)));
plot(pset(ri,pci,1),pset(ri,pci,2),'color',.5*ones(1,3))
plot(pset(ri,pci(end),1),pset(ri,pci(end),2),'o','color',.2*ones(1,3))
scatter(pset(ri,pci,1),pset(ri,pci,2),25,ncmap(cvl,:),'filled','o')

end