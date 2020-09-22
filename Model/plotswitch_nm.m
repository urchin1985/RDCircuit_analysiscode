ih = inp.i(1);
if ~exist('iml','var')
iml = .6;
end
% compute and visualize nullclines
figure(nfi);clf;hold all
prm.fc = 1;
subplot 231; hold all;title(['a1=' num2str(aoi) '  i=' num2str(ih)])
prm.i = ih;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 232; hold all; title(['a1=' num2str(aoi) '  i=' num2str(iml)])
prm.i = iml;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 233; hold all; title(['a1=' num2str(aoi) '  i=' num2str(imi)])
prm.i = imi;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);

prm.fc = .001;
subplot 234; hold all;title(['a1=.002 i=' num2str(ih)])
prm.i = ih;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 235; hold all;title(['a1=.002 i=' num2str(iml)])
prm.i = iml;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
subplot 236; hold all;title(['a1=.002 i=' num2str(imi)])
prm.i = imi;
[nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);


if pt
    rn2 = idn*2+(-50:5:250); rn1 = idn+(-50:5:250);
subplot 231; hold all; 
plot(XS1(rn2,1),XS1(rn2,2),'k.','linewidth',1.5)
plot(XS1(rn2(end),1),XS1(rn2(end),2),'bo','linewidth',1)
subplot 233; hold all
plot(XS1(rn1,1),XS1(rn1,2),'k.','linewidth',1.5)
plot(XS1(rn1(end),1),XS1(rn1(end),2),'bo','linewidth',1)
colormap parula
subplot 234; hold all
plot(XS2(rn2,1),XS2(rn2,2),'k.','linewidth',1.5)
plot(XS2(rn2(end),1),XS2(rn2(end),2),'bo','linewidth',1)
subplot 236; hold all
plot(XS2(rn1,1),XS2(rn1,2),'k.','linewidth',1.5)
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
title([num2str(mi) ' NSM'])
subplot 212; hold all
plot(XS2(:,2),'linewidth',1)
title('PDF')

end