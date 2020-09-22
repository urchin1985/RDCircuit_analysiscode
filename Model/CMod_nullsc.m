% scan for param sets that give suitable switching behavior for ctx
idn = 200; XS0=[0 1.1];
xr1 = [-3 5]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 1; nfi = 30; ihi = 1.8;
mbi = [];
for mi = 1:length(mpset.pm)
    %%
    prm = mpset.pm(mi);
    prm.k(4)= 1.35; %prm.n(4)=2;

    prm.a(1) = 1.3;
  
    % simulate dynamics
    lt = nan(1,2);
    inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
    inp.fc = prm.fc*ones(1,length(inp.i));
    XS = runmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);
%     if XS(idn*2,2)>1.5&&XS(idn*2,1)<.5&&XS(end,2)<XS(idn*2,2)/4&&XS(end,1)>4*XS(idn*2,1)
%         xmax = XS(idn*2,1);
%         xid = find(XS((idn*2):end,1)>=(xmax/2));
%         lt(1) = xid(1)-idn*2;
%     end
% verify if state switching happened
checkswitch
if ckt
    xmax = XS(idn,1);
    xid = find(XS((2*idn):end,1)>=(xmax/2));
    lt(1) = xid(1);
end
XS1 = XS;
   
    %%
    %%%%% now reduce sensory coupling to x1 %%%%%%%
    prm.a(1) = .02;
    
    % simulate dynamics
    inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
%             inp.i = [.05*ones(1,idn) prm.i*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
    inp.fc = prm.fc*ones(1,length(inp.i));
    XS = runmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);

    % verify if state switching happened
    checkswitch
    if ckt
        xmax = XS(idn,1);
        xid = find(XS((idn*2):end,1)>=(xmax/2));
        lt(2) = xid(1);
    end
    
    XS2 = XS;
    
    %
    if ~isnan(sum(lt))
        if lt(2)-lt(1)>15
            pt = 1;
            plotswitch
            drawnow
    rpl = input('Keep?','s');
    if ~isempty(rpl)
       mbi = [mbi mi]; 
    end
        end
    end
end
%%
setsavpath
% save([savpath 'modoi.mat'],'mpset','mbi')
