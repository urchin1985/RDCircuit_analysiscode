function [nco,uo] = nullcfun_sc(xr1,xr2,inc,prm,fid,dq)
% plot nullclines
x1 = xr1(1):inc(1):xr1(2);
x2 = xr2(1):inc(2):xr2(2);
xo = mifunc(x1,x2,prm);
[ux1,ux2] = meshgrid(x1,x2);
uo = mifunc(ux1,ux2,prm);
up = sqrt((uo.dx1).^2+(uo.dx2).^2);

if isempty(fid)
    fid = 102;
end

if fid>=0
    if fid>0
    figure(fid);clf;
    end
    hold all
    % plot vector field
    surf(ux1,ux2,zeros(size(ux1)),up,'linestyle','none')
    caxis([0 1])
    if dq
        quiver(ux1,ux2,uo.dx1,uo.dx2,'b','LineWidth',1.5);
    end
%     plot([xr1(1) xr1(2);0 0]',[0 0;xr2(1) xr2(2)]','k:','linewidth',1.5)
    hold all
    plot(xo.nx1,x2,'r','LineWidth',1.5);
    hold on; plot(x1,xo.nx2,'k','LineWidth',1.5)
    
    xlim([xr1(1) xr1(2)]);ylim([xr2(1) xr2(2)])
end
nco.x = x1; nco.y = x2; nco.nx = xo.nx1; nco.ny = xo.nx2;
uo.x = ux1; uo.y = ux2; uo.ux = uo.dx1; uo.uy = uo.dx2;
uo.sp = up;
% o