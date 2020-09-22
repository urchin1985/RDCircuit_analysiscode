clear TD_on TD_off

foi = unique(fidata); 

VTR = grab_clsbnds_flx(fidata, cdata, vlx, foi);
%%
cnum = size(cdata,2);
TD_on(cnum+1).vals = [];
TD_off = TD_on;
TDF_on = []; TDF_off = [];
tid_on = []; tid_off = [];
TWon = []; TWoff = [];
TDdur = [];
tpre = 600; tpost = 600;
pbool = 0;

[~,cid] = min(abs(vax_gmfit(:,1))); % 3~vax low periods

for dfi = 1:size(VTR,2)
    fidx = find(fidata==dfi);
    vdt = vdata(fidx);
    cdats = [(cdata(fidx,:)) vdt(:)];
    
    if ~isempty(VTR(cid,dfi).cnbr)
        % specify segment criteria
        vtstr = VTR(cid,dfi);
        cdurth = 5; % min length of segment
        
        % find dwelling state with dur over 2.5s
        fsgi = find(vtstr.cldur>=cdurth);
        trp_on = vtstr.clstrt(fsgi,1);
        trp_off = vtstr.clend(fsgi,1);
        trp_dur = vtstr.cldur(fsgi);
        
        TDdur = [TDdur trp_dur];
        % extract triggered data from region flanking the high state
        tseries = cdats;
        tpts = trp_on;
        [tdata_on,tdful_on,twin_on] = extrtrigdata(tseries,tpts,tpre,tpost,pbool);
        tid_on = [tid_on;fidx(unique(twin_on(twin_on>0)))];
        TWon = [TWon;twin_on];
        
        tpts = trp_off;        
        [tdata_off,tdful_off,twin_off] = extrtrigdata(tseries,tpts,tpre,tpost,pbool);
        tid_off = [tid_off;fidx(unique(twin_off(twin_off>0)))];
        TWoff = [TWoff;twin_off];
        
        TDF_on = [TDF_on;tdful_on];
        TDF_off = [TDF_off;tdful_off];
        
        for ci = 1:(size(cdats,2))
            TD_on(ci).vals = [TD_on(ci).vals;tdata_on(ci).vals];
            TD_off(ci).vals = [TD_off(ci).vals;tdata_off(ci).vals];
        end
    end
end