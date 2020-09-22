
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
cset = [.6 .6 .6;0 0 0]; bwth = [1 1]*.05;
ln = 3;
fi1 = 30; fi2 = 40;
fgl = length(fgtype); ocmat = cell(1,fgl);
clear fh

for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids);
    bdata = Bst2(fids);
    vlx = vax_clust(fids);
    
    
    % idx = vdata>-10&(cdata(:,4)>0)&(cdata(:,1)>0); % vdata>10&(cdata(:,4)>0.01);
    clrs = {[.93 .69 .13],[.49 .18 .56],[.4 .67 .19]};
    clrm = getstateclr;
    clrs = {clrm(2,:),clrm(1,:)};
    boi = [2 1];
    
    fh(fgi)=figure(fi1+fgi-1);clf; hold all
    for bi = 1:length(boi)
        bsi = boi(bi);
        idx = bdata==bsi;
        
        %         xset = {wcdata(idx,1),cdata(idx,1)};
        %         yset = {wcdata(idx,4),cdata(idx,4)};
        % cmap = cmap_gen(clrs{bi});
        if ismember(fgi,[1 2 4 6])
            ap = .045;
        else
            ap = 0.085;
        end
        hold all
        scatter(cdata(idx,1),cdata(idx,4),15,clrs{bsi},'filled','markerfacealpha',ap);caxis([0 .1]);
        
    end
    
    if fgi == 1
        xth = multithresh(cdata(:,1));
        yth = multithresh(cdata(:,4));
    end
    plot([xth xth;-1 2]',[-1 2;yth yth]','k:','linewidth',1.5)
    
    xlim([-.15 1.2]);ylim([-.15 1.2])
    axis square
    plotstandard
    set(gca,'xtick',0:.5:1,'ytick',0:.5:1,'yticklabel','')
    fh(fgi).OuterPosition = [31+230*(fgi-1) 350 260 260];
    title(fgtype{fgi})
    
    % quantify occupancy
    o21 = sum(cdata(:,1)<xth&cdata(:,4)>yth);
    o22 = sum(cdata(:,1)>xth&cdata(:,4)>yth);
    o11 = sum(cdata(:,1)<xth&cdata(:,4)<yth);
    o12 = sum(cdata(:,1)>xth&cdata(:,4)<yth);
    omat = [o11 o12;o21 o22]; omat = (-omat/sum(omat(:)));
    ocmat{fgi} = omat;
    
    if svon
        savname = [fgtype{fgi} '_nsm_avb_histbyst'];
        saveas(fh(fgi),[savpath2 savname '.tif'])
        saveas(fh(fgi),[savpath2 savname '.fig'])
        saveas(fh(fgi),[savpath2 savname '.eps'],'epsc')
    end
    
    figure(fi1+fgl); hold all
    subplot(1,fgl,fgi); cla;hold all
    showoccp
    caxis([-.95 -0.05]);
    cmap = cmap_gen({[0 0 1]},0);
    colormap(cmap(1:200,:))
    
end

figure(fi1+fgl)
set(gcf,'outerposition',[-10.2000  618.6000  761.6000  170.4000])
if svon
    savname = ['wtmt_nsm_avb_occp2'];
    saveas(gcf,[savpath2 savname '.tif'])
    saveas(gcf,[savpath2 savname '.fig'])
    saveas(gcf,[savpath2 savname '.eps'],'epsc')
    
    save([savpath savname(1:(end-1)) '.mat'],'ocmat','fgtype')
end
%% NSM vs speed activitiy histogram
clc
cset = [.6 .6 .6;0 0 0]; bwth = [1 1]*.05;
ln = 3;
fi1 = 30; fi2 = 40;

for fgi = 4%1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids);
    bdata = Bst2(fids);
    vlx = vax_clust(fids);
    
    
    % idx = vdata>-10&(cdata(:,4)>0)&(cdata(:,1)>0); % vdata>10&(cdata(:,4)>0.01);
    clrs = {[.93 .69 .13],[.49 .18 .56],[.4 .67 .19]};
    boi = [2 1];
    if ismember(fgi,[1 2 4 6])
        ap = .035;
    else
        ap = 0.085;
    end
    
    fh(fgi)=figure(fi2+fgi-1);clf; hold all
    for bi = 1:length(boi)
        bsi = boi(bi);
        idx = bdata==bsi;
        
        %         xset = {wcdata(idx,1),cdata(idx,1)};
        %         yset = {wcdata(idx,4),cdata(idx,4)};
        % cmap = cmap_gen(clrs{bi});
        
        hold all
        scatter(cdata(idx,1),vdata(idx)/20000,15,clrs{bsi},'filled','markerfacealpha',ap);caxis([0 .1]);
        
    end
    
    if fgi == 1
        xth = multithresh(cdata(:,1));
        yth = multithresh(abs(vdata))/20000;
    end
    plot([xth xth;-1 2]',[-1 2;yth yth]','k:','linewidth',1.5)
    
    xlim([-.15 1.2]);ylim([-.005 .1])
    axis square
    plotstandard
    set(gca,'xtick',0:.5:1,'ytick',0:.05:1,'yticklabel','')
    fh(fgi).OuterPosition = [31+230*(fgi-1) 350 260 260];
    title(fgtype{fgi})
    
    % quantify occupancy
    o21 = sum(cdata(:,1)<xth&cdata(:,4)>yth);
    o22 = sum(cdata(:,1)>xth&cdata(:,4)>yth);
    o11 = sum(cdata(:,1)<xth&cdata(:,4)<yth);
    o12 = sum(cdata(:,1)>xth&cdata(:,4)<yth);
    omat = [o11 o12;o21 o22]; omat = (-omat/sum(omat(:)));
    
    if svon
        savname = [fgtype{fgi} '_nsm_asp_histbyst'];
        saveas(fh(fgi),[savpath2 savname '.tif'])
        saveas(fh(fgi),[savpath2 savname '.fig'])
        saveas(fh(fgi),[savpath2 savname '.eps'],'epsc')
    end
    
end
