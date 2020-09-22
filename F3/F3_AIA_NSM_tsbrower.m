DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath

gtype = 'wtf';
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
%%
cls = [1:10];

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

%%
tpre = 600+1; tpost = 300+1;
if ~exist('ncmap','var')
    ncmap = jet(100);
end

varout = nsmtrigger_on(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
T_on = varout.tdon;

%% smooth triggered data
tmw = 20;
tn = size(T_on(1).vals,1);
tl = size(T_on(1).vals,2);
Tm = cell(1,length(T_on));

[~,TDs] = tddownsmpl(T_on,tmw); 

% % for ci = 1:length(T_on)
% %     for ti = 1:tn
% %         tdat = T_on(ci).vals(ti,:);
% %         ki = find(~isnan(tdat));
% %         tdm = smooth(tdat(ki),tmw);
% %         Tm{ci}(ti,ki) = tdm;
% %     end    
% % end
%%

tsbrowser(TDs,[1 8],10)

% yyaxis right
% plot(get(gca,xlim),.5*[1 1],'r:')