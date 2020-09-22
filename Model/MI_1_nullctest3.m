% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-3 6]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; 

prm.tau = [1 1];
prm.beta = [5 4];
prm.k = -.5*[3.1 6];%-.5*[1 1]; %prm.n(4)=2;
prm.n = [2 8];%[1.6 2];
prm.b = [0 -2];%[1.5 0];
prm.ic = 1; prm.ac = .51;
ilst = 0:.75:3.5;%0:.2:3;
il = (length(ilst));
rl = ceil(length(ilst)/2);

figure(20);clf;hold all

for ii = 1:length(ilst)
    prm.ic = 1;
    subplot(2,il,ii); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_mi(xr1,xr2,inc,prm,fid,dq);
        caxis([-.2 5])
    if ii>1
        plot(nco.x,pry,'k:','linewidth',1.5); 
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
    prx = nco.nx; pry = nco.ny;
    end
    
    prm.ic = 0;
    subplot(2,il,ii+il); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_mi(xr1,xr2,inc,prm,fid,dq);
    caxis([-.2 5])
    prx(27)
end
colormap jet

% % % cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% % % % cmap = cmap(end:-1:1,:);
% % % colormap(cmap)

%%
%%%%% now reduce sensory coupling to x1 %%%%%%%
% prm.fc = .001;
% 
% inpfun_plot
