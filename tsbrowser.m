function tsbrowser(td,coi,fid)
if isempty(fid)
    fid = 10;
end
pn = length(coi);

if ~iscell(td)
    tn = size(td(1).vals,1);
else
    tn = size(td{1},1);
end

for ti = 1:tn
    figure(fid);clf; hold all
    for ci = 1:length(coi)
        if ~iscell(td)
            y1 = td(coi(ci)).vals(ti,:);
        else
            y1 = td{coi(ci)}(ti,:);
        end
        y2 = diff(y1);
        
        subplot(pn,1,ci); hold all
        yyaxis left
        plot(1:length(y1),y1,'.-');hold all
        plot([1 length(y2)],.5*[1 1],'b:')
        
        yyaxis right
        plot(1:length(y2),y2); 
    end
    [x,y] = ginput(1);
end