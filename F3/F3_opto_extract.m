setsavpath

gztype = {'WT_noATR','WT_ATR','tph-1_noATR','tph-1_ATR'};
expn = 'AIAChrim_';
%% parse stim params
[stimfile,opdir]=uigetfile('*.stim', 'Specify stim file:', bpath);
 stim = load_stimfile([opdir,stimfile]);
 
opon = stim(:,1); opoff = stim(:,2); % stim on off times
scn = stim(:,3); % number of stim wavelengths
sint = stim(:,4); % stim intensity for each epoch
ilvl = unique(sint); % unique stim intensitites
inum = length(ilvl); % number of different stim intensitites

ontim = cell(1,inum); offtim = ontim; opfr = ontim;
for oi = 1:inum
    curint = ilvl(oi);
    curidx = find(sint == curint);
    ontim{oi} = opon(curidx); offtim{oi} = opoff(curidx);
    for oti = 1:length(curidx)
        optmp = (ontim{oi}(oti)*3):(offtim{oi}(oti)*3);
        opfr{oi} = [opfr{oi} optmp];
    end
end

%%
plclr = {.6*ones(1,3),[0 0 .8]};
fid = 46; pth = .0786;

for gi = 1:length(gztype)
    figure(fid+round(gi/2)-1);
    set(gcf,'outerposition',[138+round(gi/2)*200 584 214 348])
    if mod(gi,2)
        clf; hold all
        pclr = plclr{1};
    else
        hold all
        pclr = plclr{2};
    end
    
    ofname = [bpath expn gztype{gi} '_fulbd.mat'];
    load(ofname)
    binsize = 30;
    fnum = 10800;
    
    op_extract_f3
end