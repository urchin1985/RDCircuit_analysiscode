% clear
setsavpath

grpath = 'C:\Users\Ni Ji\Google Drive\Opto exp\AIAChrim_pdfr1\';
gtype = {'AIAChrim_pdfr1_ATR','AIAChrim_pdfr1_ATR_wtctrl','AIAChrim_pdfr1_noATR'};
%% combine data based on genotype and make plots
binsize = 30;
for gi = 1:length(gtype)
    cgpath = [grpath gtype{gi} '\'];
    ftrk = [];     

    tf = dir([cgpath '*finalTracks.mat']);  
    for fi = 1:length(tf)
        load([cgpath tf(fi).name])      
        ftrk = [ftrk,trimfields(finalTracks)];
    end
    
        tl = dir([cgpath '*linkedTracks.mat']);  
    for fi = 1:length(tl)
        load([cgpath tl(fi).name])      
        ftrk = [ftrk,trimfields(linkedTracks)];
    end
    
        [NewSeq,States,trans,emis] = getHMMStates(ftrk,binsize);
    
   save([bpath gtype{gi} '_fulbd.mat'],'ftrk','States','trans','emis','NewSeq','-v7.3')     
end

