function p = behclass_bp(cdata,bvec,clset,bwh)
hold all;box off
bcs = unique(bvec(bvec~=0));
if isempty(bwh)
bwh = 0.8;
end
ops = statset('UseParallel',true); clrs = getstateclr;

for bi = 1:length(bcs)
    caf = cdata(bvec==bcs(bi));
    cam = nanmedian(caf); caci = bootci(50,{@nanmedian,caf},'Options',ops);
    bar(bi,cam,'barwidth',bwh,'facecolor',clset{bi})
    errorbar(bi,cam,cam-caci(1),caci(2)-cam,'k.','linewidth',1.5)
    cfd{bi} = caf;
end
cx = cfd{1}; cy = cfd{2};
[p,h] = ranksum(cx(randperm(length(cx),round(.05*length(cx)))),cy(randperm(length(cy),round(.05*length(cy)))));
% hold all
% car = cdata(bvec==-1);
% [hy,hx] = hist(car,cx); hy = hy/sum(hy);
% barh(hx,hy,1,'facecolor',clset{2},'edgecolor','none','facealpha',.5);

