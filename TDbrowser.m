trn = size(TD_on(1).vals,1);
cn = length(TD_on);
tl = size(TD_on(1).vals,2);

for ti = 15%1:trn
    figure(10);clf; hold all
    for ci = 1:cn
        subplot(cn,1,ci); hold all
        plot(1:tl,TD_on(ci).vals(ti,:),'linewidth',1)
        title(cnmvec{ci})
    end
    
%     [x,y] = ginput(1);
end