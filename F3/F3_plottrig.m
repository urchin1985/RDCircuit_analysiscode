% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wt';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%%
cid = 3;

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

%
cls = [1:10];
tpre = 60; tpost = 0;
varout = nsmtrigger_on(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
CT_on = varout.cton;

TDstat = extrattrigstat(TD_on);
CTstat = extrattrigstat(CT_on);
%
TDful = cat(2,TDstat(cls).late);
CTfull = cat(2,CTstat(cls).late);
di = find(min(abs(TDful),[],2)==0);
TDful(di,:)=[];
di = find(min(abs(CTfull),[],2)==0);
CTfull(di,:)=[];

%% generate scatterhist plots
cset = [3 8 9];
bw = 5;
clr = getstateclr;

figure(18);clf;hold all
x = [TDful(:,cset(1));CTfull(:,cset(1))];
y = [TDful(:,cset(2));CTfull(:,cset(2))];
labl = [ones(size(TDful,1),1);zeros(size(CTfull,1),1)];

% x = [TD_on(cset(1)).vals(:);CT_on(cset(1)).vals(:)];
% y = [TD_on(cset(2)).vals(:);CT_on(cset(2)).vals(:)];
% labl = [ones(length(TD_on(cset(1)).vals(:)),1);zeros(length(CT_on(cset(1)).vals(:)),1)];

h = scatterhist(x,y,'Group',labl,'Kernel','on','Bandwidth',bw*ones(2,2),'legend','off',...
    'Direction','out','Color','kr','marker','..','LineStyle',{'-','-',':'},...
    'LineWidth',[2,2,2],'MarkerSize',15*[1,1]);
%
xlabel(cnmvec{cset(1)});ylabel(cnmvec{cset(2)});%zlabel('AVA')
set(gca,'xtick',0:30:150,'ytick',0:30:150,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[87 325 286 351])

figure(19);clf;hold all
x = [TDful(:,cset(3));CTfull(:,cset(3))];
y = [TDful(:,cset(2));CTfull(:,cset(2))];
labl = [ones(size(TDful,1),1);zeros(size(CTfull,1),1)];
h = scatterhist(x,y,'Group',labl,'Kernel','on','Bandwidth',bw*ones(2,2),'legend','off',...
    'Direction','out','Color','kr','marker','..','LineStyle',{'-','-',':'},...
    'LineWidth',[2,2,2],'MarkerSize',15*[1,1]);
%
xlabel(cnmvec{cset(3)});ylabel(cnmvec{cset(2)});%zlabel('AVA')
set(gca,'xtick',0:30:150,'ytick',0:30:150,'xticklabel','','yticklabel','','zticklabel','',...
    'tickdir','out','ticklength',.025*ones(1,2))
set(gcf,'outerposition',[87 125 286 351])

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