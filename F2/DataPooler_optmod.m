% clear
setsavpath
addpath(genpath('C:\Users\cm\Dropbox\PD work\Matlab\'))

grpath = 'C:\Users\Ni Ji\Dropbox (MIT)\PD work\RIF_AIY_pdfr1\N2_controls_forRIFAIY\';
gtype = 'mod1chrmN2ctrl';
%% combine data based on genotype and make plots
    ftrk = [];     

    tf = dir([grpath '*finalTracks.mat']);  
    for fi = 1:length(tf)
        load([grpath tf(fi).name])      
        ftrk = [ftrk,trimfields(finalTracks)];
    end
    
        tl = dir([grpath '*linkedTracks.mat']);  
    for fi = 1:length(tl)
        load([grpath tl(fi).name])      
        ftrk = [ftrk,trimfields(linkedTracks)];
    end
    
    [NewSeq,States,trans,emis] = getHMMStates(ftrk,binsize);
   save([bpath gtype '_fulbd.mat'],'ftrk','States','trans','emis','NewSeq','-v7.3')     

