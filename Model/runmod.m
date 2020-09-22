function XS = runmod(XS0,prm,inp,pln,xr1,xr2,inc,fid,dq)
XS = XS0;
Xt=XS;
N = length(inp.i);

for ti=2:N
    % update circuit state
    run_cmod2
    
    Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
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
    [nco,uo] = nullcfun(xr1,xr2,inc,prm,fid,dq);
    
    plot(XS(:,1),XS(:,2),'bo-','linewidth',1)
    plot(XS(end,1),XS(end,2),'bo','linewidth',1)
    colormap parula
    figure(14); clf; hold all
    subplot 211; hold all
    plot(XS(:,1),'linewidth',1)
    subplot 212; hold all
    plot(XS(:,2),'linewidth',1)
end