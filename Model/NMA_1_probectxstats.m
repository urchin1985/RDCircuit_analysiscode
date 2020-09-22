% specify circuit params
clear
nmparams5620

% specify locomotion params
nth = 3.5; dwd = 60; rmd = 500; icf = 1;
aem = 3.2; hp1 = .1; rsp = .35; % roaming speed
wsp = rsp; inp.fc = prm.fc;
rmg = 1; bx = 50;
gd = 2.5; % max sensory input per unit movement along gradient direction (x axis)
nf = .5;

N = 800;
XS0=[0 1.1]; % initial condition
XS = XS0;
loc0 = [0 0];
loc = loc0;
clear ha RD inc.i
ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
han = normrnd(0,aem,[1 N]); han = smooth(han,81);
mN = 200; rmx = 30;
%% simulate population behavior
bnstat = struct('ploc',[],'pst',[],'pinp',[]);
% wild type
prm.ic = 2; gtp = 1;
XS0=[0 1.1]; % initial condition

ploc1 = []; pst1 = []; pinp1 = [];
for mi = 1:mN
    loc0 = [0 0]; loc = loc0;
    XS = XS0;
    ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
    
    rmg = 1;
    han = normrnd(0,aem,[1 N]); han = smooth(han,71);
    
    % note: 1) duration of dwelling set to 5 tps; 2) keep speed binary for
    % simplicity
    
    Xt=XS;
    for ti=2:N
        update_traj
    end
    
    ploc1 = [ploc1; loc(end,:)];
    pst1(mi,:) = RD;
    pinp1(mi,:) = inp.i;
end

% AIA silenced
prm.ic = 0; gtp = 1; 

ploc2 = []; pst2 = []; pinp2 = [];
for mi = 1:mN
    loc0 = [0 0]; loc = loc0;
    XS0=[0 1.1]; % initial condition
    XS = XS0;
    ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
    
    rmg = 1;
    han = normrnd(0,aem,[1 N]); han = smooth(han,71);
    
    % note: 1) duration of dwelling set to 5 tps; 2) keep speed binary for
    % simplicity
    
    Xt=XS;
    for ti=2:N
        update_traj
    end
    
    ploc2 = [ploc2; loc(end,:)];
    pst2(mi,:) = RD;
    pinp2(mi,:) = inp.i;
end
bnstat(1).ploc = ploc1;
bnstat(1).pst = pst1;
bnstat(1).pinp = pinp1;

bnstat(2).ploc = ploc2;
bnstat(2).pst = pst2;
bnstat(2).pinp = pinp2;
save('BNM_ctz_wt_aiaunc.mat','bnstat')
%% plotting to be done after data generation
plot_bnstat