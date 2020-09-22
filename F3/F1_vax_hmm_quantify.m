
DirLog
setsavpath
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

gtype = 'wtf';
load([savpath gtype '_alldata_e2.mat'])
%% calculate fraction time in state, state duration, state velocity distributions

frc = nan(length(unique(Fdx)),3);
stdur = cell(1,3);
for fi = unique(Fdx')
    fid = find(Fdx == fi);
    bdat = Bst(fid);
    
    % fraction of time
    frc(fi,:) = [nnz(bdat==1) nnz(bdat==2) nnz(bdat==3)]/length(bdat);
    
    % duration of states
    for ti = 1:3
        bvc = bdat==ti;
        bp = regionprops(bvc,'area','pixelidxlist');
        ar = cat(1,bp.Area);
        
        dl = [];
        if bp(1).PixelIdxList(1)==1
            dl = [dl 1];
        elseif bp(end).PixelIdxList(end)==length(bdat);
            dl = [dl length(bp)];
        end
        
        ar(dl) = []; ar(ar<3) = [];
        stdur{ti} = [stdur{ti};ar(:)*.6];
    end
end

frm = mean(frc)
fst = std(frc)
%%
clrs = {[.93 .69 .13],[.49 .18 .56],[.4 .67 .19]}; % 1-dwell 2-roam 3-trans
dset1 = {frc(:,1) frc(:,2) frc(:,3)};
[fpout,fpfdr,fcmn,fcci] = compmean(dset1,2,5,clrs);
[tpout,tpfdr,tdmn,tdci] = compmean(stdur,2,6,clrs);
fpfdr
tpfdr
bstat.frctime = dset1; bstat.fcci = fcci; bstat.fcmn = fcmn; 
bstat.fpout = fpout; bstat.fpfdr = fpfdr;
bstat.stdur = stdur; bstat.tdci = tdci; bstat.tdmn = tdmn; 
bstat.tpout = tpout; bstat.tpfdr = tpfdr;
bstat.id = {'dw','rm','tr'};
%% plot result and save

figure(5)
set(gcf,'OuterPosition',[45 691 260 228])
savname = [gtype '_hmmstfrct'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')

figure(6)
set(gcf,'OuterPosition',[45 391 260 228])
savname = [gtype '_hmmstdur'];
saveas(gcf,[savpath2 savname '.tif'])
saveas(gcf,[savpath2 savname '.fig'])
saveas(gcf,[savpath2 savname '.eps'],'epsc')
%%
savname = [gtype '_hmmstats'];
save([savpath savname '.mat'],'bstat','Bst','vax_gmfit','estTR','estE')

