cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
vlx = Bst(fids);vid = 1;%vax_clust(fids);
% now extract data around onset NSM high periods
cnum = size(cdata,2);
tprepost = 1; 
if ~exist('cid','var')
    [~,cid] = max((nsm_gmfit(:,1)));
end
if ~exist('vid','var')
[~,vid] = min(abs(vax_gmfit(:,1)));
end

vadur{ci} = []; ndur{ci} = [];
for dfi = 1:size(NTR,2)
    fidx = find(fidata==dfi);
    vlab = vlx(fidx);
    vdats = vdata(fidx);
    cdats = (cdata(fidx,:));
    
    figure(119);clf;hold all
    subplot 211; hold all
    plot(cdats(:,1))
    subplot 212; hold all
    yyaxis left
    plot(vdats)
    
    if ~isempty(NTR(1,dfi).cnbr)
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
        subplot 211;
        plot([trp_on trp_off]',ones(2,length(trp_on)),'r','linewidth',2)
        
        ndur{ci} = [ndur{ci}(:); trp_dur(:)];
        
        % extract triggered data from region flanking the high state
        tseries = vlab==1|vlab==3;
        tpts = [trp_on trp_off];
        tout = trig_state_n(tseries,tpts);
        tout
        subplot 212; yyaxis right
        plot(tseries)
        vadur{ci} = [vadur{ci}(:); tout.vdur(:)];
        
        [x,y] = ginput(1);
    end
end