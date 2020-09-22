dtype = {'gcy28Chm' 'gcy28ChN'};
Cdat = []; Fdx = []; Odat = []; Tdat = []; Vdat = [];
NTR = []; TDF_off = [];TDF_on = [];TD_off = [];TD_on = []; TWon = []; TWoff = [];
for mi = 1:length(dtype)
    gtype = dtype{mi};
ga = load([savpath gtype '_alldata.mat']);
% offload data
Cdat = [Cdat;ga.Cdat];
if mi==1
Fdx = [Fdx;ga.Fdx];
else
   Fdx = [Fdx;ga.Fdx+max(Fdx)];     
end
Odat = [Odat;ga.Odat];
Tdat = [Tdat; ga.Tdat];
Vdat = [Vdat; ga.Vdat];

gt = load([savpath gtype '_NSM_triggstat.mat']);
% offload
NTR = [NTR gt.NTR];
TDF_off = [TDF_off;gt.TDF_off];
TDF_on = [TDF_on;gt.TDF_on];
TD_off = [TD_off;gt.TD_off];
TD_on = [TD_on;gt.TD_on];

TWoff = [TWoff;gt.TWoff];
TWon = [TWon;gt.TWon];
end

save([savpath dtype{1} 'ful_alldata.mat'],'Cdat','Fdx','Odat','Tdat','Vdat');
save([savpath dtype{1} 'ful_NSM_triggstat.mat'],'NTR','TDF_off','TDF_on',...
    'TD_off','TD_on','TWoff','TWon');