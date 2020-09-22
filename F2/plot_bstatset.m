% gather data
clear bfm bfci ndm ndci dwm dwci rmm rmci
for fgi = 1:length(bstat)
   bfm(fgi) = bstat(fgi).bfmn(1);
   bfci(:,fgi) = (bstat(fgi).bfmn(2:3))';
   
   ndm(fgi) = bstat(fgi).ndmn(1);
   ndci(:,fgi) = (bstat(fgi).ndmn(2:3))';
    
   dwm(fgi) = bstat(fgi).dwmn(1);
   dwci(:,fgi) = (bstat(fgi).dwmn(2:3))';
   
   rmm(fgi) = bstat(fgi).rmmn(1);
   rmci(:,fgi) = (bstat(fgi).rmmn(2:3))';
end

figure(fi1);clf;hold all
subplot 141; hold all
plot_bcibar([],bfci,bfm,'b',15,[],.5,0)

subplot 142; hold all
plot_bcibar([],ndci,ndm,'b',15,[],.5,0)

subplot 143; hold all
plot_bcibar([],dwci,dwm,'b',15,[],.5,0)

subplot 144; hold all
plot_bcibar([],rmci,rmm,'b',15,[],.5,0)
