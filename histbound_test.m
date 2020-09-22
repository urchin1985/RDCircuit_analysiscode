gtype = fgtype{fgi};
load([savpath gtype '_alldata.mat'])
load([savpath gtype '_NSM_triggstat.mat'])
if strcmp(gtype,'wt')
    fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
else
    fids = find(Fdx>0);
end

cdata = Cdat(fids,:);
% cdata = zscore(cdata,[],1);
fdata = Fdx(fids);
vdata = Vdat(fids);
bdata = Bst(fids);
vlx = vax_clust(fids);
if fgi==1
wcdata = cdata;
end

% idx = vdata>-10&(cdata(:,4)>0)&(cdata(:,1)>0); % vdata>10&(cdata(:,4)>0.01);
clrs = {[.49 .18 .56],[.4 .67 .19],[.93 .69 .13]};

idx = bdata'~=2&vdata>-0.02;
  
xset = {wcdata(idx,1),cdata(idx,1)};
yset = {wcdata(idx,4),cdata(idx,4)};
%
xeds = -.1:.1:1.1; yeds = xeds;
[xm,ym] = meshgrid(xeds(2:end),yeds(2:end));

[N,Xeds,Yeds] = histcounts2(xset{2},yset{2},xeds,yeds);
N = N/sum(N(:)); %N(N<0.00007) = 0;
% imagesc(N)
% hold all
% caxis([0 .007])
%
% ng = imgaussfilt(N,1.5);
% se = strel('disk',1);
% ng = imopen(N,se);
% ng = ng>.0007;
% D = bwdist(~ng);
ng = N>.0035;
figure(2);clf;imagesc(N)
caxis([0 .01])
ftr = 1; smf = 9;
%
% figure(30);ftr = 20; smf = 15;
hold all
% [~,hc] = contour(N,ln,'linecolor','k','levelstep',.25,'levelstepmode','manual',...
%     'linewidth',2,'linestyle',':');  shading flat
smbnd = sgolay_smbound(ng,smf,0);
ctx = smbnd.X/ftr+2*xeds(1); cty = smbnd.Y/ftr+2*yeds(1);
plot(ctx,cty,'k:','linewidth',1.5)

figure(30);hold all
ftr = 1/mean(diff(xeds));
ctx = smbnd.X/ftr+2*xeds(1); cty = smbnd.Y/ftr+2*yeds(1);
plot(ctx,cty,'k:','linewidth',1.5)