% fraction roaming
fcr1 = sum(pst1,2)/N;
fcr2 = sum(pst2,2)/N;

% fm1 = nanmean(fcr1); fci1 = bootci(100,@nanmean,fcr1)
% fm2 = nanmean(fcr1); fci2 = bootci(100,@nanmean,fcr2)
% figure(22);clf;hold all
bx = []; bdat = {fcr1,fcr2};
clrs = {[0 0 0],[0 .6 0]};
fid = 22; 
[bm,bci] = make_barplt(bx,bdat,clrs,fid,[],1);
plotstandard
set(gca,'yticklabel','','ytick',0:.25:.6,'ylim',[0 .7])
%% trigger on R->D transition 
ipmat = [];
pi = 1;
for mi = 1:size(ploc1,1)
    crd = pst1(mi,:);
    rp = regionprops(crd,'PixelIdxList','PixelList','Area');
    cip = pinp1(mi,:);
    
    for ri = 1:length(rp)
        if rp(ri).Area>20
            ipmat(pi,:) = nan(1,N);
            rdi = rp(ri).PixelIdxList;
            idt = cip(rdi); rl = length(idt);
            ipmat(pi,(end-rl+1):end) = idt;
            
            pi = pi+1;
        end
    end
end
%
wout = cal_matmean(ipmat,1,1);

figure(27);clf; hold all
plot_bci([],wout.ci,wout.mean,'k',[],[])
%%
ipmat2 = [];
pi = 1;
for mi = 1:size(ploc2,1)
    crd = pst2(mi,:);
    rp = regionprops(crd,'PixelIdxList','PixelList','Area');
    cip = pinp2(mi,:);
    
    for ri = 1:length(rp)
        if rp(ri).Area>20
            ipmat2(pi,:) = nan(1,N);
            rdi = rp(ri).PixelIdxList;
            idt = cip(rdi); rl = length(idt);
            ipmat2(pi,(end-rl+1):end) = idt;
            
            pi = pi+1;
        end
    end
end
%
aout = cal_matmean(ipmat2,1,1);

figure(28);clf; hold all
plot_bci([],aout.ci,aout.mean,'k',[],[])

%% combined plot
figure(21);clf; hold all
plot([0 N],[0 0],'-','linewidth',1)
plot_bci([],aout.ci,aout.mean,[0 .6 0],[],[])
plot_bci([],wout.ci,wout.mean,'k',[],[])
plotstandard
set(gca,'ytick',-.4:.4:.8,'yticklabel','','ylim',[-.4 .8])
set(gcf,'outerposition',[1 680 213 290])
xlim([500 600])