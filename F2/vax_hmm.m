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
load([savpath ref_gtype '_vax_gmfit.mat'],'gmfit')
clx = cluster(gmfit,Xd);
ckflg = 0;

seqs = [];
for fi = unique(Fdx')
fid = find(Fdx == fi);
qtmp = (clx2(fid))';
sq = uint8(slidingmedian([],qtmp,60,0));
seqs{fi} = sq;
end

chk_hmmvax

save([savpath gtype '_alldata.mat'],'Xd','clx','seqs','bstates','Bst','estTR','estE','-append')
