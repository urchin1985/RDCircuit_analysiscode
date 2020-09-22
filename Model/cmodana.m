% assemble params
mk = []; mn = [];
mki = cat(1,mpset.pm.ki);
mni = cat(1,mpset.pm.ni);
mb = cat(1,mpset.pm.b);
ma = cat(1,mpset.pm.a);
mbt = cat(1,mpset.pm.beta);

for mi = 1:length(mpset.pm)
mk = [mk;[mpset.pm(mi).k(1,2) mpset.pm(mi).k(2,1)]];
mn = [mn;[mpset.pm(mi).n(1,2) mpset.pm(mi).n(2,1)]];
end
%% analyze high performing models
hid = find((mpset.lat(:,2)-mpset.lat(:,1))>=10);
hki = []; hni = []; hk = []; hn = []; hb = []; ha = []; hbt = [];
for hi = (hid(:))'
hki = [hki;mpset.pm(hi).ki];
hni = [hni;mpset.pm(hi).ni];
hk = [hk;[mpset.pm(hi).k(1,2) mpset.pm(hi).k(2,1)]];
hn = [hn;[mpset.pm(hi).n(1,2) mpset.pm(hi).n(2,1)]];
hb = [hb;mpset.pm(hi).b];
ha = [ha;mpset.pm(hi).a];
hbt = [hbt;mpset.pm(hi).beta];

end
%%
bn = 12;
figure(19);clf;hold all
subplot 241; histogram2(hki(:,1),hki(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('ki')
subplot 242; histogram2(hni(:,1),hni(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('ni')
subplot 243; histogram2(hk(:,1),hk(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('k')
subplot 244; histogram2(hn(:,1),hn(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('n')
subplot 245; histogram2(hb(:,1),hb(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('b')
subplot 246; histogram2(ha(:,1),ha(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('a')
subplot 247; histogram2(hbt(:,1),hbt(:,2),bn,'DisplayStyle','tile','ShowEmptyBins','on'); title('bt')

%% test if reverse grouping works the same
sizeOfCircle = 4; opacity = .35; color = [0 0 .7];
xl = 340;

mid = find(mni(:,1)<mni(:,2)&mb(:,1)>mb(:,2)...
    ); % &mk(:,1)>mk(:,2)
figure(20);clf;hold all
transparentScatter(mpset.lat(:,1),mpset.lat(:,2),...
    sizeOfCircle,opacity,.3*ones(1,3))
xlim([0 xl]);ylim([0 xl])
transparentScatter(mpset.lat(mid,1),mpset.lat(mid,2),...
    sizeOfCircle,.5,color)
