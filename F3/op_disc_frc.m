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
    oplat = nanmean(opmat(:,180:210),2);

    oki = find(~isnan(otpre));
    otpre = otpre(oki); otpos = otpos(oki); otmat = otmat(oki,:);
    oppre = oppre(oki); oppos = oppos(oki); opmat = opmat(oki,:); oplat = oplat(oki,:);
    
    % state specific pre-post spds
    ki = find(otpre == 1);
    ki = find(oppre<pth);
    dwmat = otmat(ki,:);
    dwpos = otpos(ki);
    dwppr = oppre(ki);
    dwppos = oppos(ki);
    dwlat = oplat(ki);
    dwpm = opmat(ki,:);
    
    ki = find(otpre == 2);
        ki = find(oppre>pth);
    rmmat = otmat(ki,:);
    rmpos = otpos(ki);
    rmppr = oppre(ki);
    rmppos = oppos(ki);
    rmpm = opmat(ki,:);    

% quantify percentage of response
dn = 100; th = .01; rn = 90;
dwr = (dwlat-dwppr); rmr = (rmppos-rmppr); 
frcs = frccalc(dwr,rmr,dn,th,rn);
end