tpre = 480; tpost = 0; % 4min pre
varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
TDs = tddownsmpl(TD_on,20);
tdat = TD_on; dst = 30;

cnm = length(tdat);
tn = size(tdat(1).vals,1);
tl = size(tdat(1).vals,2);

clear tds
tds(1) = struct('vals',[],'fi',[]);
tx = 1:tl;
for ci = 1:cnm
    tds(ci).vals = [];
    for ti = 1:tn
        [tmx,ttmp] = tilingmean_ds(tx,tdat(ci).vals(ti,:),dst,-1);
        tds(ci).vals = [tds(ci).vals;ttmp];
    end
    
    tds(ci).fi = tdat(ci).fi;
end

bw = .1;
figure(5);clf;hold all
% scatter(tds(3).vals(:,end),tds(8).vals(:,end),18,'r','filled')
scatterhist(tds(3).vals(:,end),tds(8).vals(:,end),'Kernel','on','Bandwidth',bw*ones(2,1),'legend','off',...
    'Direction','out','Color','kr','marker','..','LineStyle',{'-','-',':'},...
    'LineWidth',[2,2,2],'MarkerSize',15*[1,1]);
%%
tpre = 180; tpost = 0; % 4min pre
varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TD_on = varout.tdon;
TDstat = extrattrigstat(TD_on);
Dorig = TD_on;

figure(5);hold all;
%
cnum = length(Dorig);
tdur = size(Dorig(1).vals,2);
% divvy into early mid late phase
ter = 1:round(tdur/3);
tmi = (round(tdur/3)+1):round(tdur*2/3);
tla = (round(tdur*2/3)+1):tdur;
Dstat = []; Dstat(cnum).early = [];

for ci = 1:cnum
    curdat = Dorig(ci).vals;
    
    % 1.calculate early mid late phase average
    Dstat(ci).early = nanmean(curdat(:,ter),2);
    Dstat(ci).mid = nanmean(curdat(:,tmi),2);
    Dstat(ci).late = nanmean(curdat(:,tla),2);
    
    % 2. calculate single value feature:
    % sum
    Dstat(ci).sum = nansum(curdat,2);
    
    % max
    Dstat(ci).max = nanmax(curdat,[],2);
    
    % var
    Dstat(ci).var = nanvar(curdat,[],2);
    
    % median
    Dstat(ci).med = nanmedian(curdat,2);
    
    % late-early
    Dstat(ci).delt = Dstat(ci).late - Dstat(ci).early;
    
    % late/early
    Dstat(ci).rate = Dstat(ci).late./Dstat(ci).early;
end

figure(5);hold all
scatter(Dstat(3).late,Dstat(8).late)