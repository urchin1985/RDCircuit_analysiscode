setsavpath

gztype = {'WT_noATR','WT_ATR','tph-1_noATR','tph-1_ATR'};
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
plclr = getstateclr;
fid = 28; pth = .0786; gddf = nan(1,length(gztype)); grdf = gddf;
% grp = nan(length(gztype),2);
gln = length(gztype);
gfrm = nan(2,gln); gfrci = nan(4,gln);

for gi = 1:gln
% %     foi = fid+gi-1;
% %     figure(foi);clf;hold all
% %     set(gcf,'outerposition',[8+(gi-1)*400 540 414 500])
% %     if mod(gi,2)
% %         clf; hold all
% %         pclr = plclr{1};
% %     else
% %         hold all
% %         pclr = plclr{2};
% %     end
    
    ofname = [bpath expn gztype{gi} '_fulbd.mat'];
    load(ofname)
    binsize = 30;
    fnum = 10800;
    
    op_disc_frc
    
%     gddf(gi) = ddf; grdf(gi) = rdf;
% grp(gi,:) = [dwfr rmfr];
gfrm(:,gi) = [frcs.dwim;frcs.rmdm];
gfrci(:,gi) = [frcs.dwci;frcs.rmci];
end

%%
bbol = 1; bw = .4; cr = 2.5;
figure(fid);clf;hold all
subplot 211; hold all
pst = plclr(1,:); pst = [pst/cr;pst;pst/cr;pst];
plot_bcibar([],gfrci(3:4,:),gfrm(2,:),pst,2,[],bw,bbol)
plotstandard
set(gca,'yticklabel','','ylim',[0 .75],'xlim',[.25 gln+.75])

subplot 212; hold all
pst = plclr(2,:); pst = [pst/cr;pst;pst/cr;pst];
plot_bcibar([],gfrci(1:2,:),gfrm(1,:),pst,2,[],bw,bbol)
plotstandard
set(gca,'yticklabel','','ylim',[0 .7],'xlim',[.25 gln+.75])

%%
if svon
    figure(fid)
    savname = 'AIAopresp';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname '.mat'],'gfrm','gfrci','gztype')
end

