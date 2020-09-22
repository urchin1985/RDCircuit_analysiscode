% aggregate speed traces into one matrix and plot individual speed and angular speed traces
if ~exist('fnum','var')
    fnum = 10800;
end
flen = length(ftrk);
spmat = nan(flen,fnum); apmat = spmat;

for fi = 1:flen
    frms = ftrk(fi).Frames; fspd = ftrk(fi).Speed; fasp = abs(ftrk(fi).AngSpeed);
    fx = ftrk(fi).SmoothX; fy = ftrk(fi).SmoothY;
    spmat(fi,frms) = fspd; apmat(fi,frms) = fasp;
end
%% convert spmat into select windows flanking each stimuli (10s before and after),
% sort into separate matrices (same width) based on stim intensity
opdat = struct('spd',[],'mspd',[],'anp',[],'manp',[]);

for oi = 1:length(ontim)
    opb = (ontim{oi}-10)*3; opa = (offtim{oi}+10)*3; % 10s before stim onset and 10s after stim offset
    opmat = []; oamat = [];
    for oti = 1:length(opb)
        if opa(oi)<=size(spmat,2)
            opmat = [opmat;spmat(:,(opb(oti):opa(oti)))];
            oamat = [oamat;apmat(:,(opb(oti):opa(oti)))];
        end
    end
    
    % sort by speed 0-5s before stim
    oppre = nanmean(opmat(:,1:30),2); % speed ~3s before stim onset
    oppos = nanmean(opmat(:,30:60),2); % speed ~6-9s after
    oplat = nanmean(opmat(:,150:180),2);
    oki = find(~isnan(oppre));
    oppre = oppre(oki); oppos = oppos(oki); oplat = oplat(oki);
    ort = oppos./oppre;
    
    opmat = opmat(oki,:);
    
    ki = find(oppre>pth);
    ozmat = opmat(ki,:);
    opm = cal_matmean_ds(ozmat,1,10,1);
    [~,ord] = sort(oppre(ki));
    subplot 221;hold all
    plot_bci([],opm.ci,opm.mean,[0 0 1],[],[])
    subplot 223; hold all
    imagesc(ozmat(ord,:)); caxis([0 .2])
    
    ki = find(oppre<pth);
    ozmat = opmat(ki,:);
    opm = cal_matmean_ds(ozmat,1,10,1);
    [~,ord] = sort(oppre(ki));
    subplot 222;hold all
    plot_bci([],opm.ci,opm.mean,[0 0 1],[],[])
    subplot 224; hold all
    imagesc(ozmat(ord,:)); caxis([0 .2])
    
end