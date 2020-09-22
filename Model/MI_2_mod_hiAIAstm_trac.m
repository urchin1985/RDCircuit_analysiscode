% scan for param sets that give suitable switching behavior for ctx
idn = 120;
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.dt = .25;
nf = .6;
%%
fiid = 90; xcc = 0:.25:5.5;
figure(fiid);clf;hold all

% high input, AIA on vs off
prm.i = 1.25;inp.i = [prm.i*ones(1,idn)];
subplot 211; hold all

%%%% simulation to obtain state probabilities
XS2 = [];
for mi = 1:200
    prm.ic = 2.5; % AIA on
    XS0=[0 4];
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS1 = XS;
    
    prm.ic = 4.2; % AIA over high
    XS0 = XS1(end,:);
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS2 = XS;
    
    XSf = [XS1;XS2]; xt = 1:length(XSf); xt = xt-idn;
    plot(xt,XSf(:,1),'color','b');
    plot(xt,XSf(:,2),'color',[.8 .4 .1]);
end
set(gca,'xlim',xt([60 end]),'ylim',[0 6.2])
xlabel('Time'); ylabel('Model state')
%% stim AIA from dwelling
subplot 212; cla;hold all
% prm.i = .1;
%%%% simulation to obtain state probabilities
% for mi = 1:150
%     inp.i = [prm.i*ones(1,idn)];
%     prm.ic = .75; % AIA on
%     XS0=[4 0];
%     XS = runmmod_nsf(XS0,prm,inp,nf);
%     XS1 = XS;
%      
%     c8 = ceil(rand*50);
%     inp.i(c8) = 3.45;
%     prm.ic = 2.5; % AIA over high
%     XS0 = XS1(end,:); XS0=[4 0];
%     XS = runmmod_nsf(XS0,prm,inp,nf);
%     XS2 = XS;
%     
%     XSf = [XS1;XS2]; xt = 1:length(XSf); xt = xt-idn;
%     plot(xt,XSf(:,1),'color','b');
%     plot(xt,XSf(:,2),'color',[.8 .4 .1]);
% end
prm.i = .1;inp.i = [prm.i*ones(1,idn)]; 
XS0 = [4 0];     prm.ic = .75 % AIA on
figure(90);hold all
subplot 212; cla;hold all;
XE1 = [];
for mi = 1:200%00
    inp.i = [prm.i*ones(1,idn)];
    XS0=[4 0];
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS1 = XS; XE1 = [XE1;XS1(end,:)]  
    plot(xt(1:idn),XS(:,1),'color','b');
plot(xt(1:idn),XS(:,2),'color',[.8 .4 .1]);
end
%
prm.ic = 2.5;
prm.i = .1;inp.i = [prm.i*ones(1,idn)]; 
for mi = 1:200
    c8 = ceil(rand*80);  
inp.i(c8+0) = 3.35;
XS0 = XE1(mi,:);
XS = runmmod_nsf(XS0,prm,inp,nf);
XS2 = XS; 

% XSf = [XS1;XS2];

plot(xt(idn-1+(1:idn)),XS(:,1),'color','b');
plot(xt(idn-1+(1:idn)),XS(:,2),'color',[.8 .4 .1]);
end
set(gca,'xlim',xt([60 end]),'ylim',[0 6.2])
xlabel('Time'); ylabel('Model state')
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = 'AIAstm_statedep';
svfig(fiid,svname,svpath)




% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % cmap = cmap(end:-1:1,:);
% % colormap(cmap)


