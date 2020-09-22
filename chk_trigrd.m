DirLog
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
%%
gtype = 'wt';
load([savpath 'wtorig\' gtype '_alldata.mat'])
load([savpath 'wtorig\' gtype '_NSM_triggstat.mat'])

fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
tpre = 240; tpost = 720;

cdata = Cdat(fids,:);
fidata = Fdx(fids);
vdata = Vdat(fids);
nlab = nsm_clust(fids);
vlab = vax_clust(fids);

cls = 1:10; %cls(cls == 4) = [];
pdat = cdata(:,cls);
dt = 60;

cvals = vdata;
% cvals = vlab;
cvals = cdata(:,1);

[pc,score,latent,explnd] = runPCA(pdat,0,0,cvals);
score = zscore(pdat)*pc;
smcore = [];
for pdi = 1:size(score,2)
    smcore(:,pdi) = smooth(score(:,pdi),31);
end
%%

cid = 3;
% check if each event in NTR is properly extracted from the original data
% set
en = 1;
for fi = 1:size(NTR,2)
    fid = find(fidata==fi);
    cdt = cdata(fid,:);
    vdt = vdata(fid);
    
    figure(65);clf;hold all
    plot(cdt(:,1));
    
    cid = 1;
    for ei = 1:length(NTR(cid,fi).cldur)
        eid = [NTR(cid,fi).clstrt(ei,1):NTR(cid,fi).clend(ei,1)];
        ced = cdt(eid,1);
        plot(eid,ced,'r','linewidth',1.5)
    end
    
    cid = 2;
    for ei = 1:length(NTR(cid,fi).cldur)
        eid = [NTR(cid,fi).clstrt(ei,1):NTR(cid,fi).clend(ei,1)];
        ced = cdt(eid,1);
        plot(eid,ced,'g','linewidth',1.5)
    end
    
    cid=3;
    for ei = 1:length(NTR(cid,fi).cldur)
        eid = [NTR(cid,fi).clstrt(ei,1):NTR(cid,fi).clend(ei,1)];
        ced = cdt(eid,1);
        plot(eid,ced,'b','linewidth',1.5)
    end
    
    % check triggered data
    while T_on(1,en).fi==fi
        
        figure(66);clf; hold all
        subplot 122; plot(T_on(1,en).prei+(1:length(T_on(1,en).valex)),T_on(1,en).valex)
        title(num2str(en))
        en = en+1
        [x,y] = ginput(1);
    end
    
end