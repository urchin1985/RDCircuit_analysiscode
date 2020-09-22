% aggregate speed traces into one matrix and plot individual speed and angular speed traces
if ~exist('fnum','var')
    fnum = 10800;
end
flen = length(ftrk);
spmat = nan(flen,fnum); apmat = spmat;

for fi = 1:flen
    frms = ftrk(fi).Frames; fspd = ftrk(fi).Speed; 
    fasp = abs(ftrk(fi).AngSpeed); fst = ftrk(fi).State;
    fx = ftrk(fi).SmoothX; fy = ftrk(fi).SmoothY;
    spmat(fi,frms) = fspd; apmat(fi,frms) = fasp;
end
%% convert spmat into select windows flanking each stimuli (10s before and after),
% sort into separate matrices (same width) based on stim intensity
opdat = struct('spd',[],'mspd',[],'anp',[],'manp',[]);
if ~exist('ls','var')
    ls = '-';
end
for oi = 1:length(ontim)
    opb = (ontim{oi}-15)*3; opa = (offtim{oi}+15)*3; % 10s before stim onset and 10s after stim offset
    opmat = []; oamat = [];
    for oti = 1:length(opb)
        if opa(oi)<=size(spmat,2)
            opmat = [opmat;spmat(:,(opb(oti):opa(oti)))];
            oamat = [oamat;apmat(:,(opb(oti):opa(oti)))];
        end
    end
    
    % gather average speeds in 3s bins
    cm = 6;
    ol = size(opmat,1);
    ommat = nan(size(opmat));
    for oi = 1:ol
    otmp = slidingmean([],opmat(oi,:),cm,-1);
    ommat(oi,:) = otmp;
    oppre(oi) = nanmean(ommat(oi,37:45)); % 3s pre stim
    end
    %%
    ki = find(oppre>.05);
    ozmat = ommat(ki,:);
    [~,ord] = sort(oppre(ki));%(ommat(:,28));
    ozmat = ozmat(ord,:);
    
       
    figure(119);clf; hold all
    imagesc(ozmat(:,:))
    caxis([0 .15])
    hold all; plot([45 45],get(gca,'ylim'),'k:','linewidth',1.5)
%     ylim([0 3000])
    %%
    xeds = 0:.01:.22;
    figure(120);clf;hold all
%     make2ddhist(ommat(:,28),ommat(:,41),xeds,xeds,2);axis equal
    hp = scatterhist(ozmat(:,28),ozmat(:,56));
    hp(1).XLim = [0 .23]; hp(1).YLim = [0 .23];
% caxis([0 60])
        figure(121);clf;hold all
%         make2ddhist(ommat(:,28),ommat(:,161),xeds,xeds,2); axis equal
    hp = scatterhist(ozmat(:,28),ozmat(:,141));
    hp(1).XLim = [0 .23]; hp(1).YLim = [0 .23];
% caxis([0 60])
end