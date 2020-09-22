cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
vlx = vax_clust(fids);
vlx = Bst2(fids);
% now extract data around onset NSM high periods
cnum = size(cdata,2);
tprepost = 1; 
if ~exist('cid','var')
    [~,cid] = max((nsm_gmfit(:,1)));
end
if ~exist('vid','var')
[~,vid] = min(abs(vax_gmfit(:,1)));
end
for dfi = 1:size(NTR,2)
    fidx = find(fidata==dfi);
    vlab = vlx(fidx);
    cdats = (cdata(fidx,:));
    
    if ~isempty(NTR(1,dfi).cnbr)&&~isempty(fidx)
        % specify segment criteria
        ntstr = NTR(cid,dfi);
        cdurth = 10; % min length of segment
        cmth = 0.5; % min max activity
        
        % find NSM high state with max above .5 and dur over 5s
        fs1 = find(ntstr.cldur>=cdurth);
        fs2 = find(ntstr.cmax>cmth);
        fsgi = fs1(ismember(fs1,fs2));
        trp_on = ntstr.clstrt(fsgi,1);
        trp_off = ntstr.clend(fsgi,1);
        trp_dur = ntstr.cldur(fsgi);
        
        ndur{ci} = [ndur{ci}(:); trp_dur(:)]';
        % extract triggered data from region flanking the high state
        tseries = vlab==1|vlab==3;
        tpts = [trp_on trp_off];
        tout = trig_state_n(tseries,tpts);
        
        vadur{ci} = [vadur{ci}(:); tout.vdur(:)]';
    end
end