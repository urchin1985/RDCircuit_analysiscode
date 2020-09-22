% aggregate speed traces into one matrix and plot individual speed and angular speed traces
if ~exist('fnum','var')
    fnum = 10800;
end
flen = length(ftrk);
spmat = nan(flen,fnum); apmat = spmat; stmat = spmat;

for fi = 1:flen
    frms = ftrk(fi).Frames; fspd = ftrk(fi).Speed; fasp = abs(ftrk(fi).AngSpeed);
    fx = ftrk(fi).SmoothX; fy = ftrk(fi).SmoothY;
    spmat(fi,frms) = fspd; apmat(fi,frms) = fasp; 
    tln = length(States(fi).states); stmat(fi,frms(1:tln)) = States(fi).states;
end
%% convert spmat into select windows flanking each stimuli (10s before and after),
% sort into separate matrices (same width) based on stim intensity
opdat = struct('spd',[],'mspd',[],'anp',[],'manp',[]);

for oi = 1:length(ontim)
    opb = (ontim{oi}-10)*3; opa = (offtim{oi}+10)*3; % 10s before stim onset and 10s after stim offset
    opmat = []; oamat = []; otmat = [];
    for oti = 1:length(opb)
        if opa(oi)<=size(spmat,2)
            opmat = [opmat;spmat(:,(opb(oti):opa(oti)))];
            oamat = [oamat;apmat(:,(opb(oti):opa(oti)))];
            otmat = [otmat;stmat(:,(opb(oti):opa(oti)))];
        end
    end
    
    % first divide into 2 groups based on pre states
    otpre = nanmedian(otmat(:,22:30),2); % speed ~3s before stim onset
    otpos = nanmedian(otmat(:,52:60),2); % speed ~6-9s after
    oppre = nanmean(opmat(:,1:30),2); % speed ~3s before stim onset
    oppos = nanmean(opmat(:,30:60),2); % speed ~6-9s after
    oplat = nanmean(opmat(:,120:150),2);

    oki = find(~isnan(otpre));
    otpre = otpre(oki); otpos = otpos(oki); otmat = otmat(oki,:);
    oppre = oppre(oki); oppos = oppos(oki); opmat = opmat(oki,:); oplat = oplat(oki,:);
    
    ki = find(otpre == 1);
    dwmat = otmat(ki,:);
    dwpos = otpos(ki);
    dwppr = oppre(ki);
    dwpm = opmat(ki,:);
    opm = cal_matmean_ds(dwmat,1,10,1);
    
    ki = find(otpre == 2);
    rmmat = otmat(ki,:);
    rmpos = otpos(ki);
    rmppr = oppre(ki);
    rmpm = opmat(ki,:);
    opm = cal_matmean_ds(rmmat,1,10,1);
    

    % further divide data by stim response
    rdmat = cell(1,4); rdpr = rdmat;
    rdmat{1} = dwpm(dwpos==1,:); % dd
    rdmat{2} = dwpm(dwpos==2,:); % dr
    rdpr{1} = dwppr(dwpos==1); rdpr{2} = dwppr(dwpos==2);
    
    rdmat{3} = rmpm(rmpos==1,:); % rd
    rdmat{4} = rmpm(rmpos==2,:); % rr
    rdpr{3} = rmppr(rmpos==1); rdpr{4} = rmppr(rmpos==2);
    %% first visualize responses
    for ri = 1:4
        cmt = rdmat{ri};
    opm = cal_matmean_ds(cmt,1,10,1);
    [~,ord] = sort(rdpr{ri});
    subplot(2,4,ri); hold all
    plot_bci([],opm.ci,opm.mean,[0 0 1],[],[])
    subplot(2,4,ri+4); hold all
    imagesc(cmt(ord,:)); caxis([0 .2])
    end
    
    %% quantify percentage of response
    ddf = size(rdmat{1},1)/(size(rdmat{1},1)+size(rdmat{2},1));
    rdf = size(rdmat{3},1)/(size(rdmat{3},1)+size(rdmat{4},1));
    
    %% scatter pre-post spds
    siz = .005; op = .25; clr = 'k';
    figure(foi-10);clf;hold all
%     transparentScatter(oppre,oppos-oppre,siz,op,clr);
%     plot([0 .25],[0 0],'k')
%     axis square
%     set(gca,'yscale','log')

subplot 211;hist(oppos(oppre<.05)-oppre(oppre<.05),-.2:.01:.2);
subplot 212;hist(oppos(oppre>.05)-oppre(oppre>.05),-.2:.01:.2)
end