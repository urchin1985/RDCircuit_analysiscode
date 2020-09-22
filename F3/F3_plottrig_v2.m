% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
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

% % %% generate scatter plots on full data excluding peri-NSMon data points
% % npre = 60; npost = 660; % in .5s res
% % [~,cid] = max(nsm_gmfit(:,1));
% % 
% % % extract time points pre and post nsm on
% % nprei = []; nposi = []; nonl = [];
% % fdlst = unique(Fdx);
% % for dfi = 1:size(NTR,2)
% %     if ~isempty(NTR(1,dfi).cnbr)
% %         fdful = find(Fdx==fdlst(dfi));
% %         ntstr = NTR(cid,dfi);
% %         noni = ntstr.clstrt(:,2);
% %         nonl = [nonl;noni];
% %             for nii = 1:length(noni)
% %                 nprei = [nprei max(fdful(1),(noni(nii)-npre)):noni(nii)];
% %                 nposi = [nposi noni(nii):min(fdful(end),(noni(nii)+npost))];
% %             end
% %     end
% % end

%% prepare peri-event datasets
tpre = 480; tpost = 0; % 4min pre
dst = 30;

varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
CT_on = varout.cton;
cnm = length(TD_on);

% now downsample data in 10s increments
TDs = tddownsmpl(TD_on,dst); 
CTs = tddownsmpl(CT_on,dst);

% group data into 3 windows 1-30s, 90-120, 150-180, make sure to exclude 0s
% before calc stats
tsl = size(TDs(1).vals,2);
woi = {1:2,tsl-1:tsl};
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
cset = [3 8 9 1];
bw = .1;
clr = getstateclr;
clmat = [.65*ones(1,3); .85 .2 0];
crg = 15:tsl;

c1 = cset(1); c2 = cset(2);
ctx = CTs(c1).vals(:,crg); cty = CTs(c2).vals(:,crg);

figure(18);clf;hold all

x = [tdgp(c1).gp(2).dat(:);ctx(:)];
y = [tdgp(c2).gp(2).dat(:);cty(:)];
labl = [1*ones(numel(tdgp(c1).gp(2).dat(:)),1);zeros(numel(ctx),1)];

h = scatterhist(x,y,'Group',labl,'Kernel','on','Color',clmat,'Bandwidth',bw*ones(2,length(unique(labl))),'legend','off',...
    'Direction','out','marker','.','LineStyle',{'-'},...
    'LineWidth',2,'MarkerSize',15);
%
xlabel(cnmvec{c1});ylabel(cnmvec{c2});%zlabel('AVA')
set(gca,'xtick',0:.5:1,'ytick',0:.5:1,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[87 625 286 351])
%%
c1 = cset(3); c2 = cset(2);
ctx = CTs(c1).vals(:,crg); cty = CTs(c2).vals(:,crg);

figure(19)

x = [tdgp(c1).gp(2).dat(:);ctx(:)];
y = [tdgp(c2).gp(2).dat(:);cty(:)];
labl = [1*ones(numel(tdgp(c1).gp(2).dat(:)),1);zeros(numel(ctx),1)];

h = scatterhist(x,y,'Group',labl,'Kernel','on','Color',clmat,'Bandwidth',bw*ones(2,length(unique(labl))),'legend','off',...
    'Direction','out','marker','.','LineStyle',{'-'},...
    'LineWidth',2,'MarkerSize',15);
%
xlabel(cnmvec{c1});ylabel(cnmvec{c2});%zlabel('AVA')
set(gca,'xtick',0:.5:1,'ytick',0:.5:1,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[87 325 286 351])

%% save plots
figure(18)
savname = [gtype '_' cnmvec{cset(1)} 'vs_' cnmvec{cset(2)} '_schst'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

figure(19)
savname = [gtype '_' cnmvec{cset(3)} 'vs_' cnmvec{cset(2)} '_schst'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')