function cmap = cmap_gen(clrs,kb)    
cmap = [];
if length(clrs)==1
   clrs{2} = [1 1 1]; 
   cran1=cran_gen(clrs{1},clrs{2});  
   cmap = cran1;
else    
    for li = 1:(length(clrs)-1)
        cran1=cran_gen(clrs{li},clrs{li+1});     
        cmap = [cmap;cran1];
    end
end

if kb
figure(199);imagesc(0:100);colormap(cmap)
set(gca,'yticklabel','','xticklabel','')

end
% map has 401 rows