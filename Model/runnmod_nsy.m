function XS = runnmod_nsy(XS0,prm,inp,nf)
XS = XS0;
Xt=XS;
N = length(inp.i);
if isempty(nf)
   nf = .3; 
end

% simulate dynamics
for ti=2:N
    % update circuit state
    x1 = Xt(1);
    x2 = Xt(2);
    %     run_nmod2
    prm.i = inp.i(ti);
    xo = nmfun(x1,x2,prm);
    nst = nf*prm.tau.*normrnd(0,1,1,2);
    dX = [xo.dx1 xo.dx2]+nst;
    
    Xt=max(0,(Xt+(dX*prm.dt)));
    % Xt = Xt+dX;
    XS=[XS;Xt];
%     if ti==255; o; end
end

