setsavpath

set_gdirs

gtype = {'wt','aiaunc','pdfr1','tax4'};
pclr = {[0 0 0],[0 0 1],[.5 .5 0],[0 .5 .5]};
load([bpath gtype{gi} '_fuldata.mat'])
%% combine data based on genotype and make plots
mw = 20;

%
gi = 1;
chrm = nan(1,20); chrel = chrm; chreh = chrm; chz = chrm;

for fi = 1:15
fst = 10*fi; fdur = 30;

plclr = pclr{gi};

toi = 1;
state_trigg_dran
chdat = [cxmat1(stmat1==2&dsmat1<500) cxmat2(stmat2==2&dsmat2<500)];
spdat = [spmat1(stmat1==2&dsmat1<500) spmat2(stmat2==2&dsmat2<500)];


% compute and compare overall chemotaxis bias across genotypes
cmn = nanmean(chdat);
%     cci = bootci(200,@nanmean,chdat);
cse = nanstd(chdat)/sqrt(length(chdat));
chrm(fi) = cmn;
chz(fi) = length(chdat);
%     chrel(gi) = cmn-cci(1);
%     chreh(gi) = cci(2)-cmn;
chre(fi) = cse;
end
figure(20); hold all
subplot 211; hold all; plot(chrm)
subplot 212; hold all; plot(chz)