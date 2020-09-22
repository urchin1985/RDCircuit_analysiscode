coi = [3 8 9];
xdc = -.5:.125:2;
prn = 440:600;
tn = size(TD_on(1).vals,1);
fn = max(fidata);
while 1
    fi = min(max(1,round(rand*fn)),fn); ti = min(max(1,round(rand*tn)),tn);
    
    figure(37);clf;hold all
    subplot 121
    % scatter(cdata(:,3),cdata(:,8),15,vdata,'filled','markerfacealpha',.5)
    plot(cdata(fidata==fi,3),cdata(fidata==fi,8),'.-')
    % caxis([-500 500])
    % histogram2(cdata(:,3),cdata(:,8),30,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
    % % [N1,Xeds,Yeds] = histcounts2(cdata(Bst'~=1&vdata>0,3),cdata(Bst'~=1&vdata>0,8),xdc,xdc);
    % % imagesc(N1)
    % % set(gca,'ydir','normal')
    xlim([-.5 2]);ylim([-1.5 2])
    xlabel(cnmvec{coi(1)});ylabel(cnmvec{coi(2)});
    
    subplot 122; hold all
    tx = TD_on(3).vals(:,prn); ty = TD_on(8).vals(:,prn); tv = TD_on(11).vals(:,prn);
    % histogram2(tx(:),ty(:),30,'FaceColor','flat','DisplayStyle','tile','ShowEmptyBins','on')
    colorline(tx(ti,:),ty(ti,:),1:size(tx,2),.05)
    % caxis([-500 500])
    % % [N2,Xeds,Yeds] = histcounts2(tx(tv>0.02),ty(tv>0.02),xdc,xdc);
    % % imagesc(N2)
    % % set(gca,'ydir','normal')
    % ylim(ylm); xlim(xlm)
    xlabel(cnmvec{coi(1)});ylabel(cnmvec{coi(2)});
    
    % % figure(38)
    % % imshowpair(N1,N2)
    % % set(gca,'ydir','normal')
    [x,y] = ginput(1);
end