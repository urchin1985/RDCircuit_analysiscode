% gtype = {'wt','wtld','aiaunc','pdfr1','tax4'};
% gi = 3;  
% load([bpath gtype{gi} '_fuldata.mat'])

%%
xrmat = [];
if ~exist('xb','var')
    xb = 90;
end
if ~exist('fid','var')
   fid = 101; 
end

for ti = 1:size(xgt.d2b,1)
    if sum(~isnan(xgt.d2b(ti,:)))>0
        spd = xgt.sp2b(ti,:);
        cid = find(~isnan(spd)); spd = smooth(spd(cid),60);
        if length(spd)>xb
            ctx = smooth(xgt.ch2b(ti,cid),60);
            
            xcf = crosscorr(ctx,spd,xb);
            xrmat = [xrmat;xcf'];
        end
    end
end

xmf = cal_matmean(xrmat,1,1);
figure(fid); hold all
if gi<4
    plot_bci(-xb:xb,xmf.ci,xmf.mean,plclr,[],[])
else
    smw = 19;
    xml = smooth(xmf.ci(1,:),smw);
    xmh = smooth(xmf.ci(2,:),smw);
    xmm = smooth(xmf.mean,smw);
    plot_bci(-xb:xb,[xml';xmh'],xmm',plclr,[],[])
end
plotstandard
set(gca,'xlim',[-xb xb],'ylim',[-.2 .45],'ytick',-.4:.2:.4,'yticklabel','','xtick',-270:90:270)
set(gcf,'outerposition',[85 740 160 212])
