% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-2 6]; xr2 = [-2 6]; inc = [.2 .2];
fid = 0; dq = 0; 

prm.tau = [1 1];
prm.beta = [4 2];
prm.k = [1 1]; %prm.n(4)=2;
prm.n = [.9 9];%[1.6 2];
prm.b = [-0.5 -.5];
ilst = 0:4;%0:.2:3;
rl = ceil(length(ilst)/2);

figure(17);clf;hold all

for ii = 1:length(ilst)
    subplot(2,rl,ii); hold all;
    prm.i = ilst(ii);
    title(num2str(prm.i))
    [nco,uo] = nullcfun_mi(xr1,xr2,inc,prm,fid,dq);
    caxis([0 .75])
    if ii>1
        plot(nco.x,pry,'k:','linewidth',1.5); 
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
    prx = nco.nx; pry = nco.ny;
    end
    prx(27)
end

cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)

%%
%%%%% now reduce sensory coupling to x1 %%%%%%%
% prm.fc = .001;
% 
% inpfun_plot
