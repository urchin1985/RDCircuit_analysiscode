%% assign cluster inds to all datasets of interest
if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end
cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fidata = Fdx(fids);
vdata = Vdat(fids);
clx = nsm_clust(fids);
cln = max(clx);

%% loop through datasets, identify and collect segments of NSM on, off and transition periods
if strcmp(gtype,'wt')
    foi = [1 3 8 9 11 12 13]; % [1 3 7 8 9 10 11 12 13];
else
    foi = 1:max(Fdx);
end

NTR = grab_clsbnds(fidata, cdata, clx, foi);
%% now extract data around onset NSM high periods
clear TD_on TD_off
cnum = size(cdata,2);
TD_on(cnum+1).vals = [];
TD_off = TD_on;
TDF_on = []; TDF_off = [];
tid_on = []; tid_off = [];
TWon = []; TWoff = [];
TDdur = [];
tpre = 600; tpost = 600;
pbool = 0;

[~,cid] = max(nsm_gmfit(:,1)); % 1~NSM high periods
%
for dfi = 1:size(NTR,2)
    fidx = find(fidata==dfi);
    vdt = vdata(fidx);
    cdats = [(cdata(fidx,:)) vdt(:)];
    cldat = clx(fidx);
    
    if ~isempty(NTR(1,dfi).cnbr)&&~isempty(fidx)
        % specify segment criteria
        ntstr = NTR(cid,dfi);
        cdurth = 10; % min length of segment
        cmth = 0.25; % min max activity
        
        % find NSM high state with max above .5 and dur over 5s
        fs1 = find(ntstr.cldur>=cdurth);
        fs2 = find(ntstr.cmax>cmth);
        fsgi = fs1(ismember(fs1(:),fs2(:)));
        fsgi = unique(fsgi);
        
        if ckflg
            % when necessary, visuarlly inspect each selected segments to make
            % sure they are real
            fdel = [];
            for fi = (fsgi(:))'
                segind = ntstr.clstrt(fi,1):ntstr.clend(fi,1);
                %%
                figure(50);clf;hold all
                title([num2str(dfi)])
                %             plotyy(1:size(cdats,1),cdats(:,1),1:size(cdats,1),cdats(:,11))
                %             plot(segind,cdats(segind,1),'r','linewidth',1.5)
                cp = 1; coi = [1 4 2 3 8]; cl = length(coi)+1;
                for ci = coi
                    subplot(cl,1,cp); hold all
                    imagesc([1 length(cldat)],.5*[1 1],cldat'); hold all
                    plot(1:size(cdats,1),cdats(:,ci))
                    plot(segind,cdats(segind,ci),'r','linewidth',1.5)
                    title(cnmvec{ci})
                    if nansum(cdats(:,ci))
                        ylim(max(0,prctile(cdats(:,ci),[0 99.5])))
                    end
                    xlim([1 length(cldat)])
                    plotstandard
                    cp = cp+1;
                end
                subplot(cl,1,cp); hold all
                plot(1:size(cdats,1),vdt,'k')
                plot(segind,vdt(segind),'r','linewidth',1.5)
                plot(get(gca,'xlim'),[0 0],'k:')
                ylim(prctile(vdt,[0 95]));xlim([1 length(cldat)])
                %%
                [x,y,butt] = ginput(1);
                switch butt
                    case 113 % 'q'
                        fdel = [fdel fi];
                    case 114 % 'r'  - manually define start and end of peak
                        [x1,~] = ginput(1);
                        disp(['Peak start: ' num2str(round(x1))])
                        [x2,~] = ginput(1);
                        disp(['Peak end: ' num2str(round(x2))])
                        ntstr.clstrt(fi) = round(x1);
                        ntstr.clend(fi) = round(x2);
                        ntstr.cldur(fi) = round(x2)-round(x1);
                end
                
            end
            fsgi(ismember(fsgi,fdel)) = [];
        end
        
        trp_on = ntstr.clstrt(fsgi,1);
        trp_off = ntstr.clend(fsgi,1);
        trp_dur = trp_off-trp_on+1;
        
        TDdur = [TDdur;trp_dur];
        
        NTR(cid,dfi).clstrt = ntstr.clstrt(fsgi,:);
        NTR(cid,dfi).clend = ntstr.clend(fsgi,:);
        NTR(cid,dfi).cldur = trp_dur;
        NTR(cid,dfi).cnbr = ntstr.cnbr(fsgi,:);
        NTR(cid,dfi).cmax = ntstr.cmax(fsgi);
        NTR(cid,dfi).cmed = ntstr.cmed(fsgi);
        NTR(cid,dfi).cmin = ntstr.cmin(fsgi);
        NTR(cid,dfi)
        % visualize for troubleshooting
        % %         figure(27);clf;hold all
        % %         for ci = 1:10
        % %             subplot(10,1,ci); hold all
        % %             plot(cdats(:,ci),'b')
        % %             plot(trp_on,cdats(trp_on,ci),'g.')
        % %             plot(trp_off,cdats(trp_off,ci),'r.')
        % %         end
        % %         title(num2str(dfi))
        % %         [x,y] = ginput(1);
        
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
        
        if ~isempty(tdata_on(1).vals)
            for ci = 1:(size(cdats,2))
                TD_on(ci).vals = [TD_on(ci).vals;tdata_on(ci).vals];
                TD_off(ci).vals = [TD_off(ci).vals;tdata_off(ci).vals];
            end
        end
    end
end
TD_on(1)
%% calculate average and make plots
% % figure(101);clf;hold all
% % pdim = [cnum,2];
% %
% % [dm_on,dci_on] = average_n_plot2(TD_on,pdim,1,cnmvec);
% %
% % [dm_on,dci_on] = average_n_plot2(TD_off,pdim,2,cnmvec);
% %
% % saveas(gcf,[savpath(1:end-1) ' plots\' gtype '_NSMpktrans_nn.tif'])
% % saveas(gcf,[savpath(1:end-1) ' plots\' gtype '_NSMpktrans_nn.eps'],'epsc')
%% save results
savfile = [savpath gtype '_NSM_triggstat616.mat'];
if svon
if ~isempty(dir(savfile))
    save(savfile,'NTR','TDF_on','TDF_off','TD_on','TD_off','tid_on','tid_off','TWon','TWoff','TDdur','-append')
else
    save(savfile,'NTR','TDF_on','TDF_off','TD_on','TD_off','tid_on','tid_off','TWon','TWoff')
end
disp([gtype '_NSM_triggstat.mat saved.'])
end