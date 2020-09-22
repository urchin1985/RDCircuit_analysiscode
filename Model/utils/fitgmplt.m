function gmfit = fitgmplt(Xd,bnz,cln,fid)
gmfit = fitgmdist(Xd,cln);

if fid>0
    if isempty(fid)
        fid = 138;
    end
    figure(fid);clf;hold all
    if length(bnz)>1
        x1g = min(Xd(:,1)):bnz(1):max(Xd(:,1));
        x2g = min(Xd(:,2)):bnz(2):max(Xd(:,2));
        histogram2(Xd(:,1),Xd(:,2),x1g,x2g,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
    elseif ~isempty(bnz)
        histogram2(Xd(:,1),Xd(:,2),bnz,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
    else
        histogram2(Xd(:,1),Xd(:,2),20,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
    end
    
    % scatter(Xd(:,1),Xd(:,2))
    colormap bone
    % h = ezcontour(@(x,y)pdf(gmfit,[x y]),get(gca,{'XLim','YLim'}));
    % set(h,'linewidth',1.5,'levelstep',.05)
    % set(gca,'xlim',[-1 1],'ylim',[-9 .3]);
    %
    d=500;
    x1 = linspace(min(Xd(:,1)) - 2,max(Xd(:,1)) + 2,d);
    x2 = linspace(min(Xd(:,2)) - 2,max(Xd(:,2)) + 2,d);
    [x1grid,x2grid] = meshgrid(x1,x2);
    X0 = [x1grid(:) x2grid(:)];
    threshold = sqrt(chi2inv(0.5,2));
    mahalDist = mahal(gmfit,X0);
    
    for m = 1:cln
        idx = mahalDist(:,m)<=threshold;
        h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',1);
        uistack(h2,'bottom');
    end
    % plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
    % xlabel('median axial velocity');ylabel('variance')
    axis square
end