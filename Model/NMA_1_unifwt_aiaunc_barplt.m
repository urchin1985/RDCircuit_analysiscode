% specify circuit params
clear
nmparams5620
xr1 = [-1 10]; xr2 = xr1; inc = [.2 .2];
prm.b = [0 .5];
prm.tau = 5*[1 1];
prm1 = prm; prm1.ic = 0; prm.ic = 2;

idn = 1300; icf = 1;
fid = 0; dq = 0; nl = .25;
XS0=[6 0]; rN = 200;
svon = 0;
%%
ip0 = .75; prm.b(1) = 0; prm1.b(1) = prm.b(1);
inp.i = ip0*ones(1,idn); %  .3*ones(1,idn) 0.1*ones(1,200)

rmpc = cell(1,2);
for ri = 1:rN
    XS1 = runnmod_nsy_icf(XS0,prm,icf,inp,nl);
    rdtp = (XS1(300:end,1)<=3.5&XS1(300:end,2)>=1.6);
    rmpc{1}(ri) = sum(rdtp)/length(rdtp);
    
    XS2 = runnmod_nsy_icf(XS0,prm1,icf,inp,nl);
    rdtp = (XS2(300:end,1)<=3.5&XS2(300:end,2)>=1.6);
    rmpc{2}(ri) = sum(rdtp)/length(rdtp);
    
end

%%
bx = []; 
tclrs = {.5*ones(1,3),[.3 .8 .3]};
fid = 108; 
[bm,bci] = make_barplt(bx,rmpc,tclrs,fid,[],1);
plotstandard
set(gca,'yticklabel','','ytick',0:.25:.6,'ylim',[0 .5])
set(gcf,'outerposition',[80 720 196 269])
%% saving plot and data
setsavpath
if svon
    savname = 'NMA_rmfrc_wtaia_bp';
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
end