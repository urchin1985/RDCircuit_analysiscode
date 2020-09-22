tpre = 240; tpost = 720; 
if ~exist('ncmap','var')
    ncmap = jet(100);
end

varout = nsmtrigger_dur(NTR,smcore,vdata,fidata,nsm_gmfit,tpre,tpost);
P_fc = varout.tdfc;

varout = nsmtrigger_dur(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
T_fc = varout.tdfc;

% dn = [4 5 14 15];
% for i = 1:length(P_on)
% T_on(i).vals(dn,:) = [];
% P_on(i).vals(dn,:) = [];
% end

% cvc1 = linspace(.01 )
if ~exist('dt','var')
dt = 90;
end
prn = 1:dt:tpre; pon = prn(end)+(1:dt:tpost);
rl1 = length(prn)-1; rl2 = length(pon)-1;
predat = nan(size(T_fc(1).vals,1),rl1,length(P_fc)); posdat = nan(size(T_fc(1).vals,1),rl2,length(P_fc));
prebl = predat; prebh = prebl; posbl = posdat; posbh = posbl;
preca = nan(size(T_fc(1).vals,1),rl1); posca = nan(size(T_fc(1).vals,1),rl2);
cvc = 'b';


for ti = 1:size(T_fc(1).vals,1)
    
    for di = 1:length(P_fc)
        for ri1 = 1:rl1
            curn = prn(ri1):(prn(ri1+1)-1);
            mdat = P_fc(di).vals(ti,curn);
            predat(ti,ri1,di) = nanmean(mdat);
            if sum(~isnan(mdat))
                bci = bootci(100,@nanmean,mdat);
                prebl(ti,ri1,di) = bci(1);
                prebh(ti,ri1,di) = bci(2);
            end
        end
        
        for ri2 = 1:rl2
            curn = pon(ri2):(pon(ri2+1)-1);
            mdat = P_fc(di).vals(ti,curn);
            posdat(ti,ri2,di) = nanmean(mdat);
            if sum(~isnan(mdat))
                bci = bootci(100,@nanmean,mdat);
                posbl(ti,ri1,di) = bci(1);
                posbh(ti,ri1,di) = bci(2);
            end
        end
    end
   
       for ri1 = 1:rl1
        curn = prn(ri1):(prn(ri1+1)-1);
        tdat = T_fc(coi).vals(ti,curn);
        preca(ti,ri1) = nanmean(tdat);
    end
    
    for ri2 = 1:rl2
        curn = pon(ri2):(pon(ri2+1)-1);
        tdat = T_fc(coi).vals(ti,curn);
        posca(ti,ri2) = nanmean(tdat);
    end 
end

prm = nanmean(predat,1); pom = nanmean(posdat,1);
prm = squeeze(prm); pom = squeeze(pom);
pl = [prm;pom];
prc = nanmean(preca,1); poc = nanmean(posca,1);

% gather data for storage
TP.prepc = predat; TP.pospc = posdat; TP.preca = preca; TP.posca = posca; 
TP.prem = prm; TP.posm = pom;TP.nsmpre = prc; TP.nsmpos = poc;
TP.pvals = pl; 

%%
if ~exist('foi','var')
    foi = 17;
end
    pset = [predat posdat];


figure(foi); clf; hold all
% for ri = 16%:size(predat,1)
%     plot3(pset(ri,:,1),pset(ri,:,2),pset(ri,:,3),'color',.5*ones(1,3)) 
%         plot3(pset(ri,end,1),pset(ri,end,2),pset(ri,end,3),'o','color',.5*ones(1,3)) 
% 
% end

plot3(pl(:,1),pl(:,2),pl(:,6),cvc,'linewidth',2)
% errorbar(prm(:,1),prm(:,2),prm(:,1)-prebl(),ypos,xneg,xpos)
plot3(prm(:,1),prm(:,2),prm(:,6),'ko-','markersize',9)
scatter3(prm(:,1),prm(:,2),prm(:,6),75,ncmap(round(prc*150),:),'filled','o')

plot3(pom(:,1),pom(:,2),pom(:,6),'k^-','markersize',9)
scatter3(pom(:,1),pom(:,2),pom(:,6),75,ncmap(round(poc*150),:),'filled','^')

% caxis([0 .6])
% colormap jet
xlabel('PC1');ylabel('PC2');zlabel('PC3');
xlim([-1.2 1]); ylim([-.4 1.8]); zlim([-1 .6])
set(gca,'ydir','reverse')
view(gca,[-107.6 17.9]); grid on
%% save data for direct plotting
saveas(gcf,[savpath2 gtype '_statetranspca.tif'])
saveas(gcf,[savpath2 gtype '_statetranspca.fig'])
saveas(gcf,[savpath2 gtype '_statetranspca.eps'],'epsc')

save([savpath gtype '_statetrans_PCA.mat'],'T_on','P_on','tpre','tpost','TP')