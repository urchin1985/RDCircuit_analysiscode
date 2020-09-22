%% visualize the gm model
figure(18);clf;hold all
xgr = min(Xd(:,1)):.015:max(Xd(:,1));
ygr = min(Xd(:,2)):.3:max(Xd(:,2));
histogram2(Xd(:,1),Xd(:,2),xgr,ygr,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap bone
% set(gca,'xlim',[-.1 1],'ylim',[-13 -3.3])
% h = ezcontour(@(x,y)pdf(gmfit,[x y]),get(gca,{'XLim','YLim'}));
% set(h,'linewidth',1.5,'levelstep',.05)

%
d=500;
x1 = linspace(min(Xd(:,1)) - 2,max(Xd(:,1)) + 2,d);
x2 = linspace(min(Xd(:,2)) - 2,max(Xd(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.5,2));
mahalDist = mahal(gmfit,X0);

cln = size(gmfit.mu,1);
for m = 1:cln
    idx = mahalDist(:,m)<=threshold;
    h2 = plot(X0(idx,1),X0(idx,2),'.','MarkerSize',3);
    uistack(h2,'bottom');
end
plot(gmfit.mu(:,1),gmfit.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)

%%
for fi = unique(Fdx')
    di = find(Fdx == fi);
    vdata = Vdat(di);%Cdat(di,1);
    cdata = Cdat(di,1);
    di = find(Xd(:,3) == fi);
    xdata = Xd(di,1:2);
    clid = clx(di);
    
    figure(18);clf;hold all
histogram2(Xd(:,1),Xd(:,2),xgr,ygr,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
colormap bone
    
    figure(16);clf;hold all
    % plot(vdata)
    plot(xdata(:,1))
    plot(vdata/prctile(vdata,99))
    plot(cdata,'k:')
    % xmin = slidingmin(1:length(xdata),xdata(:,1),1700,0);
    % plot(xmin,'o-')
    %    plot((xdata(:,1))'-xmin)
    plot([1 length(vdata)],[0 0],'k:')
    for m = 1:cln
        idx = find(clid==m);
        if ~isempty(idx)
            figure(16)
            h = plot(idx,xdata(idx,1),'.','markersize',6);
            %    plot(idx,vdata(idx,1),'.','markersize',6)
            figure(18);hold all
            plot(xdata(idx,1),xdata(idx,2),'.','color',h.Color,'markersize',7)
        end
    end
    figure(16)
%     plot(-xdata(:,2)/max(abs(xdata(:,2))))
    plot(clid)
    xlim([0 length(vdata)+5])
    title([gtype ' File #' num2str(fi)])
    [x,y] = ginput(1);
end
