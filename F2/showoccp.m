px = [0 xth xth 0]; py = [0 0 yth yth];
patch(px,py,omat(1,1))

hold all
px = [xth 1 1 xth]; py = [0 0 yth yth];
patch(px,py,omat(1,2))

hold all
px = [0 xth xth 0]; py = [yth yth 1 1];
patch(px,py,omat(2,1))

hold all
px = [xth 1 1 xth]; py = [yth yth 1 1];
patch(px,py,omat(2,2))

set(gca,'xticklabel','','yticklabel','')
axis square