gmu = gmfit.mu; gsig = gmfit.Sigma; gp = gmfit.ComponentProportion;
gmu(2,1) = gmu(2,1)+.015;
gmu(3,2) = gmu(3,2)-.45;
gmu(4,1) = gmu(4,1)+.15; gmu(4,2) = gmu(4,2)-.25; 
gp([1 2 3 4]) = gp([1 2 3 4])+[-.1 .05 .28 -.23];
gsig(1,1,2) = gsig(1,1,2)+.016; gsig(2,2,2) = gsig(2,2,2)+.75; 
gsig(1,1,4) = gsig(1,1,4)-.015; gsig(2,2,4) = gsig(2,2,4)-.05;
gsig(2,2,3) = gsig(2,2,3)+.3;
gmnew = gmdistribution(gmu,gsig,gp);
%% 
clx = cluster(gmnew,Xd);

figure(18);clf;hold all
% scatter(Xd(:,1),Xd(:,2))
histogram2(Xd(:,1),Xd(:,2),-1:.03:1,-9:.3:.3,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap bone
set(gca,'xlim',[-1 1],'ylim',[-9 .3])
% h = ezcontour(@(x,y)pdf(gmfit,[x y]),get(gca,{'XLim','YLim'}));
% set(h,'linewidth',1.5,'levelstep',.05)
set(gca,'xlim',[-1 1],'ylim',[-9 .3]);
xlabel('axial velocity');ylabel('variance')

d=500;
x1 = linspace(min(Xd(:,1)) - 2,max(Xd(:,1)) + 2,d);
x2 = linspace(min(Xd(:,2)) - 2,max(Xd(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.5,2));
clx = cluster(gmnew,Xd);
mahalDist = mahal(gmnew,X0);

for m = 1:max(clx)
    idx = mahalDist(:,m)<=threshold;
    h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',3);
    uistack(h2,'bottom');
end

for fi = unique(Fdx')
    di = find(Fdx == fi);
    ndata = Cdat(di,1);
    vdata = Vdat(di);
    vdata = medfilt1(vdata/prctile(vdata,99),5);
    clid = clx(di);
    
    figure(16);clf;hold all
    subplot 211; hold all
    plot(vdata); plot(clid); plot([1 length(vdata)],[0 0],'k:')
    for m = 1:max(clx)
        idx = find(clid==m);
        plot(idx,vdata(idx),'.','markersize',6)
    end
    xlim([0 length(vdata)+5])
    ylabel('Normalized axial velocity')
    
        subplot 212; hold all
    plot(ndata); plot(clid); plot([1 length(vdata)],[0 0],'k:')
    for m = 1:cln
        idx = find(clid==m);
        plot(idx,ndata(idx),'.','markersize',6)
    end
    xlim([0 length(ndata)+5])
    ylabel('NSM activity')
    
    [x,y] = ginput(1);
end