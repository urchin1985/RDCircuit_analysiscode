% clear
cnmvec = {'NSM','AIY','RIB','AVB','RME','RIA','ASI','AIA','AVA','RIF'};

setsavpath
DirLog

fgtype = {'wtf','tph1','mod1','pdfr1','tph1pdfr1','tph1i','pdfracy1'};
cid = 3; % 3~NSM high periods
bid = 3;
svon = 0;
%% extract transition period data and project onto PC space as defined by wild type
bstdur = cell(1,length(fgtype)); ndur = bstdur;
ffi = 22;
for gi = 1%:length(fgtype)
    gtype = fgtype{gi};
    load([savpath gtype '_alldata.mat'])
        if strcmp(gtype,'wtf')
            load([savpath gtype '_NSM_triggstat_2.mat'])
    else
    load([savpath gtype '_NSM_triggstat.mat'])
        end
        
    fids = find(Fdx>0);
    
    extract_ndur_bstdur
    
    figure(ffi+fgi-2);clf;hold all;
    x = ndur{gi}/2; y = bstdur{gi}/2;
    transparentScatter(x',y',20,.6,.2*ones(1,3))
    axis square
end
%%
if svon
    for fgi = 2:length(fgtype)
        figure(ffi+fgi-2);
        
        % save data for direct plotting
        savname = ['wt_' fgtype{fgi} '_nsmdwdur_sct'];
        saveas(gcf,[savpath2 savname '.tif'])
        saveas(gcf,[savpath2 savname '.fig'])
        saveas(gcf,[savpath2 savname '.eps'],'epsc')
    end
end
