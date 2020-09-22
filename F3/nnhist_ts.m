bw = .1;
clm = [.5*ones(1,3); [.1 .6 .15]; [0 0 1]];
cn = length(cset);
cx = 0:.05:1.2;
bnn = 100;

figure(99);clf;hold all
for cii = 1:cn
    ci = cset(cii);
    ctd = CTs(ci).vals(:,crg); 
    if ci==4; ctd(ctd<.02) = []; end
    clear cnt1 hci1 hm1
    for bi = 1:100
        cbd = datasample(ctd(:),bnn);
        [ct1,xl1] = hist(cbd,cx);
        ct1 = smooth(ct1,5);
        cnt1(bi,:) = ct1/sum(ct1);
    end
    for ti = 1:length(cx)
       hci1(ti,:) = prctile(cnt1(:,ti),[2.5 97.5]);
       hm1(ti) = mean(cnt1(:,ti));
    end
    
    ctd = tdgp(ci).gp(1).dat(:); 
    clear cnt2 hci2 hm2
    for bi = 1:100
        cbd = datasample(ctd(:),bnn);
        [ct1,xl1] = hist(cbd,cx);
        ct1 = smooth(ct1,5);
        cnt2(bi,:) = ct1/sum(ct1);
    end    
    for ti = 1:length(cx)
       hci2(ti,:) = prctile(cnt2(:,ti),[2.5 97.5]);
       hm2(ti) = mean(cnt2(:,ti));
    end
    
    ctd = tdgp(ci).gp(2).dat(:); 
    clear cnt3 hci3 hm3
    for bi = 1:100
        cbd = datasample(ctd(:),bnn);
        [ct1,xl1] = hist(cbd,cx);
        ct1 = smooth(ct1,5);
        cnt3(bi,:) = ct1/sum(ct1);
    end 
    for ti = 1:length(cx)
       hci3(ti,:) = prctile(cnt3(:,ti),[2.5 97.5]);
       hm3(ti) = mean(cnt3(:,ti));
    end
    
    subplot(cn,1,cii);hold all
    plot_bci(cx,hci1',hm1,clm(1,:),[],[])
    plot_bci(cx,hci2',hm2,clm(2,:),[],[])
    plot_bci(cx,hci3',hm3,clm(3,:),[],[])
%     xlim([-.1 1.4])
end

