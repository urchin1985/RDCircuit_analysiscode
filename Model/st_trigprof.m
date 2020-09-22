ipmat = []; rlf = [];
pi = 1;
for mi = 1:size(ploc,1)
    crd = pst(mi,:);
    rp = regionprops(crd>0,'PixelIdxList','PixelList','Area');
    cip = pinp(mi,:);
    
    for ri = 1:length(rp)
        if rp(ri).Area>=rmx
            ipmat(pi,:) = nan(1,N);
            rdi = rp(ri).PixelIdxList;
            idt = cip(rdi); rl = length(idt);
            ipmat(pi,(end-rl+1):end) = idt;
            rlf = [rlf rl];
            
            pi = pi+1;
        end
    end
end
%
dout = cal_matmean(ipmat,1,1);

hold all
if ~exist('tclr','var')
    tclr = 'k';
end

if pb
plot_bci([],dout.ci,dout.mean,tclr,[],[])
end