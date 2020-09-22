mclr = getstateclr;
tclrs = {[0 0 0],mclr(2,:),mclr(1,:)};

% load('BNM_ctz_wt_aiaunc.mat','bnstat')
load('BNM_ctz_wt_mt.mat','bnstat')
%%
figure(107);clf;hold all
set(gcf,'outerposition',[1 680 200 268])
plot([700 800],.65*[1 1],'k','linewidth',1)
plotstandard

pb = 1; bdat = cell(1,2); bfrc = bdat;
for bi = 1:length(bnstat)
ploc = bnstat(bi).ploc; 
pst = bnstat(bi).pst; 
pinp = bnstat(bi).pinp;
tclr = tclrs{bi};

st_trigprof
% plot_bci([],dout.ci,dout.mean,tclr,[],[])
% rlf(rlf==60) = 30;
bdat{bi} = rlf;
bfrc{bi} = sum(pst,2)/N;%rlf;
% bdat{bi} = btmp./(btmp+(1-btmp)*2);
end
set(gca,'ytick',.25:.1:2,'yticklabel','')
xlim([772 800])
%% compare fraction roaming
bx = []; 
fid = 108; 
[bm,bci] = make_barplt(bx,bfrc,tclrs,fid,[],1);
plotstandard
set(gca,'yticklabel','','ytick',0:.25:.6,'ylim',[0 .7])
set(gcf,'outerposition',[80 720 196 269])


