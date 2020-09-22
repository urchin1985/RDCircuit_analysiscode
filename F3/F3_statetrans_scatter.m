% clear
DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
load([savpath 'wt_alldata.mat'])
load([savpath 'wt_NSMon_trigdata.mat'])
cls = 1:10;
fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
% fids = find(Fdx>0);
cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

%%
tpre = 500; tpost = 30;

varout = nsmtrigger_on(NTR,cdata,vdata,fidata,nsm_gmfit,tpre,tpost);
T_on = varout.tdon;
for ci = 1:length(T_on)
   Tpost(ci).vals = T_on(ci).vals(:,470:500); 
end

figure(27);clf; hold all
scatter3(cdata(:,8),cdata(:,3),cdata(:,9),2,'filled','markerfacecolor',.7*[1 1 1])
scatter3(T_on(8).vals(:),T_on(3).vals(:),T_on(9).vals(:),5,'b','filled')
% scatter3(Tpost(8).vals(:),Tpost(3).vals(:),Tpost(9).vals(:),'r','filled')
xlabel('AIA');ylabel('RIB');zlabel('AVA');
xlim([-.2 1.2]);ylim([-.2 1.2]);zlim([-.2 1.2]);
%%
d1 = 1; d2 = 2;
fm = 0;
cvals = cdata(:,1);

figure(17); 
clf
hold all

% subplot(5,1,[1:4]); cla; 
%     scatter3(smcore(:,d1),smcore(:,d2),smcore(:,3),1,cvals)
tid = randperm(size(smcore,1)); trng = tid(1:3000);
% scatter3(smcore(trng,d1),smcore(trng,d2),smcore(trng,3),6,.6*ones(1,3))
%     caxis([-.1 .1])
%     caxis([0 1])
% flst = find(P_on(1).fi==8|P_on(1).fi==3|P_on(1).fi==9);
rng = 1:size(P_on(1).vals,2);
smlen = size(smcore,1); sint = round(smlen/4);
smi = 1:sint:smlen;

rn1 = 480:500; rn2=510:size(T_on(1).vals,2);
predat = nan(size(T_on(1).vals,1),length(P_on)); posdat = predat;
for ti = 1:size(T_on(1).vals,1)
    switch aln
        case 1
    [~,mi1] = nanmax(T_on(1).vals(ti,470:500));
    [~,mi2] = nanmax(T_on(1).vals(ti,501:end));
    
    for di = 1:length(P_on)
        predat(ti,di) = P_on(di).vals(ti,mi1);
        posdat(ti,di) = P_on(di).vals(ti,500+mi2);
    end
        case 2
    for di = 1:length(P_on)
        predat(ti,di) = mean(P_on(di).vals(ti,rn1));
        posdat(ti,di) = mean(P_on(di).vals(ti,rn2));
    end    
    end
    
end


scatter3(predat(:,d1),predat(:,d2),predat(:,3),25,[1 .8 .8],'filled')
scatter3(posdat(:,d1),posdat(:,d2),posdat(:,3),25,[.8 .8 1],'filled')

prm = nanmean(predat); pom = nanmean(posdat);
pl = [prm;pom];
plot3(pl(:,1),pl(:,2),pl(:,3),'k','linewidth',2)
scatter3(prm(1),prm(2),prm(3),55,'r','filled')
scatter3(pom(1),pom(2),pom(3),55,'b','filled')

caxis([0 .6])
colormap parula
xlabel('PC1');ylabel('PC2');zlabel('PC3');
zlim([-3 5]); xlim([-3 3]); ylim([-4 4])
switch aln
    case 1
view(gca,[-65.6 10.8]); grid on % -66.8 5.19
    case 2
        view(gca,[0.700000000000045 90]); grid on
end
 

% %     subplot(5,1,5);hold all
% %     plot(find(fidata>fm),cdata(fidata>fm,1)); 
% %     plot(find(fidata>fm&nlab==3),cdata(find(fidata>fm&nlab==3),1),'.')