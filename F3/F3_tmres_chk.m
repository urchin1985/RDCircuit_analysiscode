% plot individual traces with downsampled average traced overlaid on top
tn = size(TD_on(1).vals,1);
tl = size(TD_on(1).vals,2);
coi = 3;

% downsample in 15s increments
tpre = 600; tpost = 600; % 4min pre
dst = 45;

varout = nsmtrigger_onflex(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
TDon = varout.tdon;
CTon = varout.cton;
cnm = length(TDon);
tmr = nanmean(TDon(coi).vals);

% now downsample data in 10s increments
[tx,TDs] = tddownsmpl(TDon,dst); 
[~,CTs] = tddownsmpl(CTon,dst);
tmn = nanmean(TDs(coi).vals);

figure(20);clf;hold all

pn = 10;
for ti = 1:tn
    subplot(pn,1,mod(ti,pn)+1); hold all
%     plot(tx(1:(end-1)),TDs(coi).vals(ti,:))
    plot(TDon(coi).vals(ti,:))
end

for mi = 1:pn
   subplot(pn,1,mi)
   plot(tx(1:(end-1)),tmn,'k-','linewidth',1.5)
% plot(tmr,'k-','linewidth',1.5)
   ylim([0 1]); xlim([0 1200])
   plot(600*[1 1],[-1 2],'k:','linewidth',1.5)
   if mi<pn; plotstandard; end
end