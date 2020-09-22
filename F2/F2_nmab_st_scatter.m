
% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wt','tph1','mod1','pdfr1','pdfracy1','tph1pdfr1'};
svon = 0;
%% NSM vs AVB activitiy histogram
clc
cset = [.6 .6 .6;0 0 0]; bwth = [1 1]*.05;
ln = 3;
fi1 = 30; fi2 = 40;
fgl = length(fgtype);
clrs = getstateclr;     
cmap = cmap_gen_flx({clrs(2,:),clrs(1,:)},[100 100]);
clrc= {clrs(2,:),clrs(1,:)};

% clrs = getstateclr;
% cmap = cmap_gen_flx({[1 0 0],[0 .5 0]},[100 100]);


for fgi = 1:length(fgtype)
    gtype = fgtype{fgi};
    load([savpath gtype '_alldata.mat'])
    %     load([savpath gtype '_NSM_triggstat.mat'])
    if strcmp(gtype,'wt')
        fids = find(Fdx~=2&Fdx~=4&Fdx~=5&Fdx~=6);
    else
        fids = find(Fdx>0);
    end
    
    cdata = Cdat(fids,:);
    cdata(cdata==0) = nan;
    % cdata = zscore(cdata,[],1);
    fdata = Fdx(fids);
    vdata = Vdat(fids)/20000;
        bdata = Bst2(fids);
    %     vlx = vax_clust(fids);
    if fgi>3
        cdt = cdata(:,4); 
        if fgi<6
        cdt = (cdt-prctile(cdt,2))/diff(prctile(cdt,[2 98]));
        else
cdt = (cdt-prctile(cdt,3))/diff(prctile(cdt,[3 97]));
        end
                cdata(:,4) = cdt;
        if fgi~=5
            cdt = cdata(:,1); cdt = (cdt-prctile(cdt,2))/diff(prctile(cdt,[2 98]));
            cdata(:,1) = cdt;
        end
    end
    
        boi = [2 1]; 
    fh(fgi)=figure(fi1+fgi-1);clf; hold all
    for bi = 1:length(boi)
        bsi = boi(bi);
        idx = bdata==bsi;
        % cmap = cmap_gen(clrs{bi});
        if ismember(fgi,[1 2 4])
            ap = .045;
        else
            ap = 0.085;
        end
        hold all
        scatter(cdata(idx,1),cdata(idx,4),15,clrc{bsi},'filled',...
            'markerfacealpha',ap);caxis([0 .1]);
        
    end
    
    colormap(cmap);%caxis([.0065 .065])
    
    if fgi == 1
        xth = multithresh(cdata(:,1));
        yth = multithresh(cdata(:,4));
    end
    plot([xth xth;-1 2]',[-1 2;yth yth]','k:','linewidth',1.5)
    
    xlim([-.1 1.1]);ylim([-.1 1.1])
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
        savname = [fgtype{fgi} '_nsm_avb_sctst'];
        saveas(fh(fgi),[savpath2 savname '.tif'])
        saveas(fh(fgi),[savpath2 savname '.fig'])
        saveas(fh(fgi),[savpath2 savname '.eps'],'epsc')
    end
    
end
