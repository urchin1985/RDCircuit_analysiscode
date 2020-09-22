% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
svon = 0;
%%
cid = 3; cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

dti = 5; % use 30s res
tres = 300;
foi = 40;
coi = [3 8 9];
%% prepare peri-event datasets
tpre = 15; tpost = 45; % 4min pre
dst = 30;

varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
CT_on = varout.cton;
cnm = length(TD_on);

% now downsample data in 10s increments
[~,TDs] = tddownsmpl(TD_on,dst); 
[~,CTs] = tddownsmpl(CT_on,dst);

% group data into 3 windows 1-30s, 90-120, 150-180, make sure to exclude 0s
% before calc stats
tsl = size(TDs(1).vals,2);
woi = {1:tsl};
clear tdgp
tdgp(cnm) = struct('gp',struct('dat',[])); 
for wi = 1:length(woi)
    for ci = 1:cnm
        TDs(ci).vals(TDs(ci).vals==0) = nan;
        CTs(ci).vals(CTs(ci).vals==0) = nan;
        ttmp = TDs(ci).vals(:,woi{wi});
        ttmp(ttmp==0) = nan;
        tdgp(ci).gp(wi).dat = ttmp;
    end
end

% generate scatterhist plots
cset = [1 8];
bw = .1;
clr = getstateclr;
clmat = [.65*ones(1,3); clr(3,:)];
crg = round(tsl/2):tsl;

c1 = cset(1); c2 = cset(2);
ctx = CTs(c1).vals(:,crg); cty = CTs(c2).vals(:,crg);


x0 = tdgp(c1).gp(1).dat(2:end,:);
y0 = tdgp(c2).gp(1).dat(1:(end-1),:);

x = [x0(:);ctx(:)];
y = [y0(:);cty(:)];
R1 = y0(:)./x0(:);
R2 = cty(:)./ctx(:);
labl = [1*ones(numel(x0),1);zeros(numel(ctx),1)];
di = isnan(x)|isnan(y)|isnan(labl);
x(di) = []; y(di) = []; labl(di) = [];

figure(20)
h = scatterhist(x,y,'Group',labl,'Kernel','on','Color',clmat,'Bandwidth',bw*ones(2,length(unique(labl))),'legend','off',...
    'Direction','out','marker','.','LineStyle',{'-'},...
    'LineWidth',2,'MarkerSize',15);
xlabel(cnmvec{c1});ylabel(cnmvec{c2});%zlabel('AVA')
set(gca,'xtick',0:.5:1,'ytick',0:.5:1,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[87 125 286 351])

% compute and plot ratios
figure(22);clf;hold all
[ry1,rx1] = hist(R1,0:2:10);
[ry2,rx2] = hist(R2,0:2:10);
rp2 = ry2/sum(ry2);
rp1 = ry1/sum(ry1);

bar(rx1+.5,ry2/sum(ry2),.5,'facecolor',clmat(1,:),'edgecolor','none')
bar(rx1,ry1/sum(ry1),.5,'facecolor',clmat(2,:),'edgecolor','none')
plotstandard
set(gca,'ylim',[0 .65],'ytick',0:.25:1,'yticklabel','')
set(gcf,'outerposition',[158 464 215 238])

[p,h] = ranksum(R1,R2)

% generate barplots
[bm,bci] = make_barplt([],{R1,R2},{clmat(2,:),clmat(1,:)},26,.6,1);
set(gca,'ylim',[0 6],'ytick',0:3:6,'yticklabel','')
set(gcf,'outerposition',[130 700 136 236])
%% save plots
if svon
figure(20)
savname = [gtype '_' cnmvec{cset(1)} 'vs_' cnmvec{cset(2)} '_transNSM_sch'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

figure(22)
savname = [gtype '_' cnmvec{cset(1)} 'vs_' cnmvec{cset(2)} '_transNSM_rathist'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

figure(26)
savname = [gtype '_' cnmvec{cset(1)} 'vs_' cnmvec{cset(2)} '_transNSM_rbar'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
end