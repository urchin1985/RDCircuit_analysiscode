% scan for param sets that give suitable switching behavior for ctx
idn = 7500; XS0 = [2 3];
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
iclst = 0.3:.5:2.8; cl = length(iclst);
prm.dt = .25;
nf = 1.7;%1.1;
%
fiid = 128;
figure(fiid);clf;hold all

rmp = [];
prm.ic = 0;
for ici = 1:cl
    prm.i = iclst(ici); % AIA on
    inp.i = prm.i*ones(1,idn);
    % prm.ic = 0.5; % AIA on
    subplot(4,cl,ici); hold all; %%%% phase portrait
    title(['Input ' num2str(prm.i)])
    [nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
    caxis([0 5])
    plotstandard
    if ici==1
    ylabel('Roaming strength'); 
    else
        set(gca,'yticklabel','')
    end
    
    %%%% simulation to obtain state probabilities
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS2 = XS; %figure(115);hold all;subplot 211;cla;plot(XS)
    
    subplot(4,cl,cl+ici); hold all;
    make2dhist(XS(:,1),XS(:,2),xbn);
    plotstandard; set(gca,'yticklabel','')
% %     if ici == 2
% %     xlabel('Dwelling strength')
% %     end
%     rmp(ici) = sum((XS(:,2)-XS(:,1))>0&(XS(:,2)>2.5)&(XS(:,1)<2.5))/size(XS,1);
    rmp(ici) = sum((XS(:,2)-XS(:,1))>0)/size(XS,1);

end
rmp
colormap jet
%%
rmp = []; XS0 = [2 3]; nf = 1.7; 
prm.ic = 2.5;
for ici = 1:cl
    prm.i = iclst(ici); % AIA on
    inp.i = prm.i*ones(1,idn);
    % prm.ic = 0.5; % AIA on
    subplot(4,cl,2*cl+ici); cla;hold all; %%%% phase portrait
%     title(['Input ' num2str(prm.i) ', AIA ' num2str(prm.ic)])
    [nco,uo] = nullcfun_mif(xr1,xr2,inc,prm,fid,dq);
    caxis([0 5])
        plotstandard
    if ici==1
%     ylabel('Roaming strength'); 
    else
        set(gca,'yticklabel','')
    end
    
    %%%% simulation to obtain state probabilities
    XS = runmmod_nsf(XS0,prm,inp,nf);
    XS2 = XS; %figure(115);hold all;subplot 211;cla;plot(XS)
    
    subplot(4,cl,3*cl+ici); cla;hold all;
    make2dhist(XS(:,1),XS(:,2),xbn);
        plotstandard; set(gca,'yticklabel','')
    if ici == 2
    xlabel('Dwelling strength')
    end
%     rmp(ici) = sum((XS(:,2)-XS(:,1))>0&(XS(:,2)>2.5)&(XS(:,1)<2.5))/size(XS,1);
    rmp(ici) = sum((XS(:,2)-XS(:,1))>0)/size(XS,1);

end
rmp
%%
setsavpath
svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
svname = ['mod_dynbif_Ihst'];
svfig(fiid,svname,svpath)

% % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % cmap = cmap(end:-1:1,:);
% % colormap(cmap)


