function XS = runnmod(XS0,prm,inp,pln,xr1,xr2,inc,fid,dq)
XS = XS0;
Xt=XS;
N = length(inp.i);

% simulate dynamics
for ti=2:N
    % update circuit state
    x1 = Xt(1);
    x2 = Xt(2);
    %     run_nmod2
    prm.i = inp.i(ti);
    xo = nmfun(x1,x2,prm);
    dX = [xo.dx1 xo.dx2];
    
    Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
%     if ti==255; o; end
end

if pln
    % plot nullcline field
    if isempty(fid)
        fid = 11;
    end
    if isempty(dq)
        dq = 1;
    end
    % figure(fid);clf;hold on;
    [nco,uo] = nullcfun_nm(xr1,xr2,inc,prm,fid,dq);
    
    plot(XS(:,1),XS(:,2),'bo-','linewidth',1)
    plot(XS(end,1),XS(end,2),'bo','linewidth',1)
    colormap parula
    figure(14); clf; hold all
    subplot 211; hold all
    plot(XS(:,1),'linewidth',1)
    subplot 212; hold all
    plot(XS(:,2),'linewidth',1)
end