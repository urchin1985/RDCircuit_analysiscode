% prep seq data
seqs = [];
for fi = unique(Fdx')
fid = find(Fdx == fi);
qtmp = (clx(fid))';
sq = uint8(slidingmedian([],qtmp,60,0));
seqs{fi} = sq;
end
%% 3- state
trans = [0.9,.05,0.05; .2 .6 .2; .1 .05 0.85];
emis = [.2, .05 .7 .05;
   .6 .3 .05 .05; .07 .1 .03 .8];
gmu = gmfit.mu;
[~,rm] = max(gmu(:,1)); [~,dw] = max(abs(gmu(:,2)));
[~,rv] = min(gmu(:,1)); ts = find(~ismember(1:4,[rm dw rv]));

emis(1,[rm dw rv ts]) = [.7 .1 .15 .05];
emis(2,[rm dw rv ts]) = [.05 .05 .35 .55];
emis(3,[rm dw rv ts]) = [.07 .8 .1 .03];


[estTR,estE] = hmmtrain(seqs,trans,emis)
% [PSTATES logp] = hmmdecode(seq,TRANS,EMIS);

chk_hmmvax


%% 2 state
trans = [0.99,.01; 01 0.99];
emis = [.1, .05 .8 .05;
   .07 .1 .03 .8];

[estTR,estE] = hmmtrain(seqs,trans,emis);

chk_hmmvax

%% test on new data set
gtype = 'wtf'; ref_gtype = 'wtf';
load([savpath gtype '_alldata.mat'],'Cdat','Tdat','Vdat','Fdx')
Xd = extract_vel_medvar_m(Vdat,Fdx);
% load([savpath ref_gtype '_vax_gmfit_e2.mat'],'gmfit')
clx = cluster(gmfit,Xd);
ckflg = 1;

seqs = [];
for fi = unique(Fdx')
fid = find(Fdx == fi);
qtmp = (clx(fid))';
sq = uint8(slidingmedian([],qtmp,60,0));
seqs{fi} = sq;
end

chk_hmmvax
%%
hmm_e = estE; hmm_tr = estTR;
save([savpath gtype '_alldata_e2.mat'],'Xd','clx','seqs','bstates','Bst','hmm_e','hmm_tr','-append')
% 'vax_gmfit',
save([savpath gtype '_velhmm.mat'],'Xd','clx','seqs','bstates','Bst','hmm_e','hmm_tr')
