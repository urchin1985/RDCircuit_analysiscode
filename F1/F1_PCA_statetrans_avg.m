% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
load([savpath 'wt_alldata.mat'])
load([savpath 'wt_NSMon_trigdata.mat'])
cls = 2:10; cls(cls == 4) = [];
fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
% fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls);
% for ci = 1:10
%     pdat(:,ci) = smooth(cdata(:,ci),15);
% end

cvals = vdata;
% cvals = vlab;
% cvals = cdata(:,1);

[pc,score,latent,explnd] = runPCA(pdat,0,-1,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(16);clf;hold all
% subplot(5,1,1:4);hold all
scatter3(score(:,1),smcore(:,2),smcore(:,3),15,cvals,'filled')
% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
view(gca,[-65.6 10.8]); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
% subplot 515; hold all
% plot(cdata(:,1)); plot(find(nlab==3),cdata(find(nlab==3),1),'.')
colormap parula

%%
gtype = 'wt'; 
pn = [1 2];

load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])

fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

pdat = cdata(:,cls);
cvals = cdata(:,1);
cvals = vdata;

score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end

figure(13);clf;hold all
scatter(smcore(:,pn(1)),smcore(:,pn(2)),15,cvals,'filled')

% scatter3(smcore(nlab==3,1),smcore(nlab==3,2),smcore(nlab==3,3),3,find(nlab==3))
% view(gca,[-65.6 10.8]); grid on
if prctile(cvals,5)<-.03
    caxis([-.1 .1])
else
    caxis([0 .6])
end
% zlim([-3 5]); xlim([-3 3]); ylim([-4 4])

xlabel('PC1');ylabel('PC2');zlabel('PC3');
colormap parula
%%
tpre = 420; tpost = 660;

varout = nsmtrigger_on(NTR,smcore,vdata,fidata,nsm_gmfit,tpre,tpost);
P_on = varout.tdon;

varout = nsmtrigger_on(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
T_on = varout.tdon;

% cvc1 = linspace(.01 )
prn = 1:60:tpre; pon = prn(end)+(1:60:tpost);
rl1 = length(prn)-1; rl2 = length(pon)-1;
predat = nan(size(T_on(1).vals,1),rl1,length(P_on)); posdat = nan(size(T_on(1).vals,1),rl2,length(P_on));
prebl = predat; prebh = prebl; posbl = posdat; posbh = posbl;
cvc = 'b';

for ti = 1:size(T_on(1).vals,1)
    
    for di = 1:length(P_on)
        for ri1 = 1:rl1
            curn = prn(ri1):(prn(ri1+1)-1);
            mdat = P_on(di).vals(ti,curn);
            predat(ti,ri1,di) = nanmean(mdat);
            if sum(~isnan(mdat))
                bci = bootci(100,@nanmean,mdat);
                prebl(ti,ri1,di) = bci(1);
                prebh(ti,ri1,di) = bci(2);
            end
        end
        
        for ri2 = 1:rl2
            curn = pon(ri2):(pon(ri2+1)-1);
            mdat = P_on(di).vals(ti,curn);
            posdat(ti,ri2,di) = nanmean(mdat);
            if sum(~isnan(mdat))
                bci = bootci(100,@nanmean,mdat);
                posbl(ti,ri1,di) = bci(1);
                posbh(ti,ri1,di) = bci(2);
            end
        end
    end
    
end

prm = nanmean(predat,1); pom = nanmean(posdat,1);
prm = squeeze(prm); pom = squeeze(pom);
pl = [prm;pom];

%%
figure(17); clf; hold all
plot(pl(:,1),pl(:,2),cvc,'linewidth',2)
% errorbar(prm(:,1),prm(:,2),prm(:,1)-prebl(),ypos,xneg,xpos)
plot(prm(:,1),prm(:,2),'bo-','linewidth',1.5,'markerfacecolor','w','markersize',9)
plot(pom(:,1),pom(:,2),'b^-','linewidth',1.5,'markerfacecolor','b','markersize',9)

caxis([0 .6])
colormap parula
xlabel('PC1');ylabel('PC2');
xlim([-1.2 1.2]); ylim([-.5 2])



% %     subplot(5,1,5);hold all
% %     plot(find(fidata>fm),cdata(fidata>fm,1));
% %     plot(find(fidata>fm&nlab==3),cdata(find(fidata>fm&nlab==3),1),'.')