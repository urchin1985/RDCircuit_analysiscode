clc
prm.r = [0 0];
prm.tau = 5*[1 1];
prm.dt = .25;
prm.i = 1.1;
prm.ic = 1;
prm.fc = 1;
    xr1 = [-1 3]; xr2 = xr1; inc = 2*[.1 .1];
% mpset.pm = [];
% mpset.lat = [];
% moi.pm = [];
    
figure(39);hold all
XS0=[0 1.1]; % initial condition
for mi = 1:100
    % determine model params:
    prm.ki = 2.5*rand(1,2); % vary between .25-2.5 %[.5 .5]
    prm.ni = 1+3*rand(1,2); % vary between 1-4 % [1 3]
    prm.k = 3*rand(2,2); % vary between .2-3 % [0 1;.3 .5]
    prm.n = 1.7+3.3*rand(2,2); % vary between 1.7-5 % [0 4;3 2]
    prm.b = .5+1.5*rand(1,2); % baseline activity % vary between .5-2 % [.5 .2]+1
    prm.a = .5+rand*ones(1,2)+[0 rand]; % gain on chemosensory input % vary between .5-5 % [1.3 1.8]
    a1o = prm.a(1);
    prm.beta = 1+4*rand(1,2); % gain on mutual inhibition % vary between 1-5 % [3.25 2]
    % specify sensory inputs
    %
    inp.i = [prm.i*ones(1,50) (prm.i:-.025:.05) .05*ones(1,500)]; %  .3*ones(1,idn) 0.1*ones(1,200)
    inp.fc = prm.fc*ones(1,length(inp.i));
    
    XS = runmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);
    % if state switch happened, calculate time to half max
    if XS(end,2)<XS(50,2)/4&&XS(end,1)>4*XS(50,1)
        xmax = XS(end,1);
        xid = find(XS(:,1)>=(xmax/2));
        act1 = xid(1)-50;
    else
        act1 = nan;
    end
    
    % now eliminate sensory input to dwelling circuit
    prm.a(1) = 0;
    XS = runmod(XS0,prm,inp,0,xr1,xr2,inc,[],[]);
    % if state switch happened, calculate time to half max
    if XS(end,2)<XS(50,2)/4&&XS(end,1)>4*XS(50,1)
        xmax = XS(end,1);
        xid = find(XS(:,1)>=(xmax/2));
        act2 = xid(1)-50;
    else
        act2 = nan;
    end
    
    prm.a(1) = a1o;
    if act1<0||act2<0
        break
    elseif act2-act1>=10
        prm
        prm.k
        prm.n
%         reply = input('Check out this model ....','s');
        moi.pm = [moi.pm prm];
    end
    if ~isnan(act1)&&~isnan(act2)
        plot(act1,act2,'o')
        mpset.pm = [mpset.pm prm];
        mpset.lat = [mpset.lat;[act1 act2]];
    end
end
xlim([0 300]);ylim([0 300])
% save('modprset.mat','mpset','moi')