zl = size(ozmat,1);
pri = prt*3; pei = (60+prt)*3;
oldur = nan(1,zl);
for zi = 1:zl
    %%
%     zi = 710;
    cdt = ozmat(zi,pri:pei);
    ws1 = (.06); ws2 = ((.6*ozpre(zi)));
    wth = mean([ws1,ws2]);
    cdb = cdt<wth; cdb2 = cdt<mean([.08,(.8*ozpre(zi))]);
    cdbc = (cdb+cdb2)>0;
    cdd = imclose(cdbc,strel('rectangle',[1 7]));
    ac = regionprops(cdd,'PixelIdxList','Area');
    if ~isempty(ac)
    if ac(1).PixelIdxList(1)<30
        oldur(zi) = ac(1).Area;
    else
        oldur(zi) = -(1/zi);
    end
    else
        oldur(zi) = -(1/zi);
    end
%     figure(2);plot(cdt)
%     figure(5);imagesc(cdd)
end
%%
ni = find(isnan(oldur)); nni = find(~isnan(oldur));
[~,osd] = sort(oldur(nni),'ascend');
osmat = ozmat(nni(osd),:);
onmat = ozmat(ni,:);
opm = cal_matmean(ozmat,1,1);
%%
if ~exist('fgid','var')
    fgid = 120;
end
figure(fgid);clf; hold all
subplot(5,1,1)
plot_bci([],opm.ci,opm.mean,[0 0 1],[],[])
plot([45 45],get(gca,'ylim'),'k')
xlim([0 length(opm.mean)])
subplot(5,1,2:5)
plmat = [onmat;osmat];
plmat = plmat(end:-1:1,:);
imagesc(plmat)
hold all
plot([45 45],get(gca,'ylim'),'k')
caxis([0 .15])