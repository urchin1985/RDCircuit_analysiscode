ih = 1.8;
% compute and visualize nullclines
figure(nfi);clf;hold all
aoi = prm.a(1);
subplot 221; hold all;title(['a1=' num2str(aoi) '  i=' num2str(ih)])
prm.i = ih;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 222; hold all; title(['a1=' num2str(aoi) '  i=0'])
prm.i = 0;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);

prm.a(1) = .002;
subplot 223; hold all;title(['a1=.002 i=' num2str(ih)])
prm.i = ih;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 224; hold all;title('a1=.002 i=0')
prm.i = 0;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);

if pt
    rn1 = 350:550; rn2 = 150:350;
subplot 221; hold all; 
plot(XS1(rn2,1),XS1(rn2,2),'k-','linewidth',1.5)
plot(XS1(rn2(end),1),XS1(rn2(end),2),'bo','linewidth',1)
subplot 222; hold all
plot(XS1(rn1,1),XS1(rn1,2),'k-','linewidth',1.5)
plot(XS1(rn1(end),1),XS1(rn1(end),2),'bo','linewidth',1)
colormap parula
subplot 223; hold all
plot(XS2(rn2,1),XS2(rn2,2),'k-','linewidth',1.5)
plot(XS2(rn2(end),1),XS2(rn2(end),2),'bo','linewidth',1)
subplot 224; hold all
plot(XS2(rn1,1),XS2(rn1,2),'k-','linewidth',1.5)
plot(XS2(rn1(end),1),XS2(rn1(end),2),'bo','linewidth',1)
colormap parula

figure(14); clf; hold all
subplot 211; hold all;
plot(XS1(:,1),'linewidth',1)
subplot 212; hold all;
plot(XS1(:,2),'linewidth',1)
figure(14); hold all
subplot 211; hold all
plot(XS2(:,1),'linewidth',1)
subplot 212; hold all
plot(XS2(:,2),'linewidth',1)
title(num2str(lt))

end