% scan for param sets that give suitable switching behavior for ctx
idn = 6500; XS0=[0 4];
xr1 = [-1 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;
xbn{1} = 0:.2:xr1(end);
xbn{2} = 0:.2:xr2(end);

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = [-.5 .75]; %prm.n(4)=2;
prm.n = [5 9];%[1.6 2];
prm.b = [0.2 0.25];
prm.i = 0.1;
inp.i = prm.i*ones(1,idn);
iclst = [0 .9 1.8 3.5]; cl = length(iclst);
prm.dt = .25;
nf = 1.1;
%
fiid = 128;
figure(fiid);clf;hold all

rmp = [];
for ici = 1:cl
    prm.ic = iclst(ici); % AIA on
    % prm.ic = 0.5; % AIA on
    subplot(2,cl,ici); hold all; %%%% phase portrait
    title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
    [nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
    caxis([0 5])
    if ici==1
    ylabel('Roaming strength'); 
    end
    
    %%%% simulation to obtain state probabilities
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS2 = XS; %figure(115);hold all;subplot 211;cla;plot(XS)
    
    subplot(2,cl,cl+ici); hold all;
    make2dhist(XS(:,1),XS(:,2),xbn)
    if ici == 2
    xlabel('Dwelling strength')
    end
%     rmp(ici) = sum((XS(:,2)-XS(:,1))>0&(XS(:,2)>2.5)&(XS(:,1)<2.5))/size(XS,1);
    rmp(ici) = sum((XS(:,2)-XS(:,1))>0)/size(XS,1);

end
rmp
colormap jet
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = ['mod_dynbif_I' num2str(prm.i)];
svfig(fiid,svname,svpath)

% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % cmap = cmap(end:-1:1,:);
% % colormap(cmap)


