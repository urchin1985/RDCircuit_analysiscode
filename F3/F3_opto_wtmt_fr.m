setsavpath

gztype = {'WT_noATR','WT_ATR','tph-1_noATR','tph-1_ATR','pdfr1_noATR','pdfr1_ATR'};
expn = 'AIAChrim_';
svon = 0;
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
plclr = {.65*ones(1,3),.1*ones(1,3),.65*ones(1,3),[0 0 .8]};
cls1 = getstateclr; gln = length(gztype);
cls0 = .65*ones(2,3); cls00 = .1*ones(2,3);
cls2 = [.9 .6 .1;0 .5 .8];
fid = 28; pth = .0786;
gfrm = nan(2,gln); gfrci = nan(4,gln); gfrd = cell(1,gln); gfdd = gfrd;

for gi = 1:length(gztype)
    figure(fid+round(gi/2)-1);
    set(gcf,'outerposition',[8+(round(gi/2)-1)*200 540 176 276])
    if mod(gi,2)
        clf; hold all
        makepatch([30 210],[.1 .1],.1,'r',.1)
        clset = cls0;
    else
        hold all
        clset = cls1;
    end
    ls = '-';
    
    ofname = [bpath expn gztype{gi} '_fulbd.mat'];
    load(ofname)
    binsize = 30;
    fnum = 10800;
    
%     op_disc_f3
%     
%     if gi==2; wpm1 = opm1; wpm2 = opm2; end
%     if mod(gi,2)&gi>1
%         ls = ':';
%         plot_bci([],wpm1.ci,wpm1.mean,cls00(1,:),[],ls)
%         plot_bci([],wpm2.ci,wpm2.mean,cls00(2,:),[],ls)
%     end
    
    % calculate fraction increase and decrease
    op_disc_frc
    gfrm(:,gi) = [frcs.dwim;frcs.rmdm];
    gfrci(:,gi) = [frcs.dwci(:);frcs.rmci(:)];
    gfdd{gi} = frcs.dwi(~isnan(frcs.dwi));
    gfrd{gi} = frcs.rmd(~isnan(frcs.rmd));
    
end

grmp = compmn(gfrd,[]); gdwp = compmn(gfdd,[]);
gsb = [1 2;1 3;1 5;2 4;2 6;3 4;5 6];
gid = sub2ind(size(grmp),gsb(:,1),gsb(:,2));
gff = mafdr([grmp(gid) gdwp(gid)],'BHFDR',true);
gpfdr = [gff(1:length(gid));gff((length(gid)+1):end)];

%%
ptclr = getstateclr;
bbol = 1; bw = .25; cr = 2.5;
figure(fid-2);clf;hold all
subplot 211; hold all
pst = ptclr(1,:); pst = [pst/cr;pst;pst/cr;pst;pst/cr;pst];
plot_bcibar([.8 1.2 1.8 2.2 2.8 3.2],gfrci(3:4,:),gfrm(2,:),pst,2,[],bw,bbol)
plotstandard
set(gca,'yticklabel','','ylim',[0 1],'xlim',[.5 gln/2+.5])

subplot 212; hold all
pst = ptclr(2,:); pst = [pst/cr;pst;pst/cr;pst;pst/cr;pst];
plot_bcibar([.8 1.2 1.8 2.2 2.8 3.2],gfrci(1:2,:),gfrm(1,:),pst,2,[],bw,bbol)
plotstandard
set(gca,'yticklabel','','ylim',[0 .8],'xlim',[.5 gln/2+.5])

%% save plots
if svon
    for gi = [2 4]
        figure(fid+round(gi/2)-1);
        savname = [gztype{gi} '_aiachrm_repbyst'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
    
    figure(fid-2)
    savname = 'AIAopresp';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    save([savpath savname '.mat'],'gfrm','gfrci','gztype')
    
    save([savpath savname '.mat'],'gztype','gfdd','gfrd','gfrm','gfrci','grmp','gdwp','gpfdr')
end