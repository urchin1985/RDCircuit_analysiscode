% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-2 9]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 30; 
ihi = 1.8; iml = 1.1; imi = .53;

mbi = [];
inp.i = [ihi*ones(1,idn) imi*ones(1,idn) ihi*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
% inp.i = [.05*ones(1,idn) ihi*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)

prm = mpset.pm(end);
prm.k = [3.5 2.75]; %prm.n(4)=2;
prm.n = [1.6 2];
prm.a = [1.2 3.8];
prm.ki = [0 1];
prm.ni = [4 8];
prm.b = [0 0];
prm.beta = [4 3.7];

aoi = prm.a(1);

% simulate dynamics
lt = nan(1,2);
XS = runnmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);
%     if XS(idn*2,2)>1.5&&XS(idn*2,1)<.5&&XS(end,2)<XS(idn*2,2)/4&&XS(end,1)>4*XS(idn*2,1)
%         xmax = XS(idn*2,1);
%         xid = find(XS((idn*2):end,1)>=(xmax/2));
%         lt(1) = xid(1)-idn*2;
%     end
% verify if state switching happened
% checkswitch
% if ckt
xmax = XS(idn,1);
xid = find(XS((2*idn):end,1)>=(xmax/2));
lt(1) = xid(1);
% end
XS1 = XS;

%%
%%%%% now reduce sensory coupling to x1 %%%%%%%
prm.fc = .001;

% simulate dynamics
%             inp.i = [.05*ones(1,idn) prm.i*ones(1,idn) .05*ones(1,idn)]; %  .3*ones(1,idn) 0.1*ones(1,200)
XS = runnmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);

% verify if state switching happened
%     checkswitch
%     if ckt
xmax = XS(idn,1);
xid = find(XS((idn*2):end,1)>=(xmax/2));
lt(2) = xid(1);
%     end

XS2 = XS;
%     prm.a(1) = aoi;
%
if ~isnan(sum(lt))
    %         if lt(2)-lt(1)>15
    pt = 1;
    plotswitch_nm
    drawnow
    %             prm
    %             [x,y] = ginput(1);
    % %     rpl = input('Keep?','s');
    % %     if ~isempty(rpl)
    % %        mbi = [mbi mi];
    % %     end
    %         end
end
inpfun_plot
%%
setsavpath
% save([savpath 'NMpoi.mat'],'mpset','mbi')
