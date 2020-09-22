bw = .1;
clr = [.1 .5 .25];
clmat = [.65*ones(1,3); clr(1,:)];
ctx = CTs(c1).vals(:,crg); cty = CTs(c2).vals(:,crg);
ctx(cty<.02) = []; cty(cty<.02) = [];

x0 = tdgp(c1).gp(end).dat(:); y0 = tdgp(c2).gp(end).dat(:);
x = [x0;ctx(:)];
y = [y0;cty(:)];
R1 = y0(:)./x0(:);
R2 = cty(:)./ctx(:);
labl = [1*ones(numel(tdgp(c1).gp(end).dat(:)),1);zeros(numel(ctx),1)];

figure(18);clf;hold all
h = scatterhist(x,y,'Group',labl,'Kernel','on','Color',clmat,'Bandwidth',bw*ones(2,length(unique(labl))),'legend','off',...
    'Direction','out','marker','.','LineStyle',{'-'},...
    'LineWidth',2,'MarkerSize',15);

xlabel(cnmvec{c1});ylabel(cnmvec{c2});%zlabel('AVA')
set(gca,'xtick',0:.5:1,'ytick',0:.5:1,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[47 625 286 351])
%%
% fit line and compute R2 stats
tni = .5;
[b0,stat0] = robustfit(x0(:),y0(:),'logistic',tni);
[bc,statc] = robustfit(ctx(:),cty(:),'logistic',tni);
bc(2) = bc(2)*1.35;
% [b0,bit0,~,~,stz0] = regress(y0(:),[ones(numel(x0),1) x0(:)]);
% [bc,bitc,~,~,stzc] = regress(cty(:),[ones(numel(ctx),1) ctx(:)]);

sizeOfCircle = .03;
opacity = 1;
clrc = .63*ones(1,3);
lx = -.2:.1:1.5;
lyc = bc(1)+lx.*bc(2);
ly0 = b0(1)+lx.*b0(2);

figure(19); clf; hold all
set(gcf,'outerposition',[307 625 229 290])
axis square
transparentScatter(ctx(:),cty(:),sizeOfCircle,opacity,clrc)
transparentScatter(x0(:),y0(:),sizeOfCircle,opacity,clr(1,:))

plot(lx,lyc,'color',.5*ones(1,3),'linewidth',1.5);
plot(lx,ly0,'color',clr,'linewidth',1.5);
set(gca,'xlim',[-.12 1.3],'ylim',[-.125 1.23],'xtick',0:.5:1,'ytick',0:.5:1,...
    'xticklabel','','yticklabel','','tickdir','out','ticklength',.025*ones(1,2))