function po = compmn(pdat,td)
pl1 = size(pdat,1); pl2 = size(pdat,2);
pl = numel(pdat);
po = nan(pl1,pl2);
if isempty(td); td = 'both'; end

for p1 = 1:pl
   for p2 = (p1+1):pl 
    px = pdat{p1}; py = pdat{p2};
       p = ranksum(px,py,'tail',td);
       po(p1,p2) = p;
   end
end