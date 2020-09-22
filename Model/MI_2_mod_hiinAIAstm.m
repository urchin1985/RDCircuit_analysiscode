% scan for param sets that give suitable switching behavior for ctx
idn = 3500; 
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.dt = .25;
nf = .6;
%        
fiid = 90; xcc = 0:.25:5.5; XS0=[0 4];
figure(fiid);clf;hold all

% high input, AIA on vs off
prm.i = 1.25;inp.i = [prm.i*ones(1,idn)]; 
prm.ic = 2.5; % AIA over high

%%%% simulation to obtain state probabilities
XS = runmmod_nsf(XS0,prm,inp,nf);
XS1 = XS; [hxc,hxt] = hist(XS(:,2),xcc);
figure(fiid);hold all
subplot(2,3,1:2); hold all;
plot(XS(:,1),'color','b');
plot(XS(:,2),'color',[.8 .4 .1]);
subplot(2,3,3); hold all;
barh(hxt,hxc/sum(hxc));
ylim([0 6]); xlim([0 .45])
ylabel('Roamng strength');xlabel('Probability')
%

% low input, AIA on
prm.i = 1.25;inp.i = [prm.i*ones(1,80)]; 
prm.ic = 4.2; % AIA on
XS0 = XS(end,:);
%%%% simulation to obtain state probabilities
XS2 = [];
for mi = 1:500
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = [XS2;XS(end,:)]; 
subplot(2,3,4:5); hold all;
plot(XS(:,1),'color','b');
plot(XS(:,2),'color',[.8 .4 .1]);
end
[hxc,hxt] = hist(XS2(:,2),xcc);

subplot(2,3,6); hold all;
barh(hxt,hxc/sum(hxc));
ylim([0 6]); xlim([0 .45])
ylabel('Roamng strength');xlabel('Probability')

%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'hiin_aiastmtrc';
svfig(fiid,svname,svpath)




% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % cmap = cmap(end:-1:1,:);
% % colormap(cmap)


