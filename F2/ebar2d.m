function eh = ebar2d(x,y,xe,ye,xci,yci,clrs)
xne = xe; xpe = xe; yne = ye; ype = ye;
if isempty(xe)
    xne = x-xci(1,:);
    xpe = xci(2,:)-x;
    yne = y-yci(1,:);
    ype = yci(2,:)-y;
end

if size(clrs,1)==1
eh = errorbar(x,y,yne,ype,xne,xpe,'o','color',clrs,'markerfacecolor',clrs,'linewidth',1);
else
    for ei = 1:length(x)
        hold all
       eh(ei) = errorbar(x(ei),y(ei),yne(ei),ype(ei),xne(ei),xpe(ei),'o','color',clrs(ei,:),'markerfacecolor',clrs(ei,:),'linewidth',1); 
    end
end