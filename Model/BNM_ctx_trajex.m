% clear;
prm = mpset.pm(end);
% simulate chemotaxis to dense food
clc
prm.a(1) = 1.3; %prm.a(2)=2.1;
% prm.r(2) = .3;
prm.k(4)=1.35; %prm.n(4)=2;

prm.tau = 5*[1 1];
prm.ic = 3;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.15]; % 2.95
prm.k = [3.85 3.75]; %prm.n(4)=2;
prm.n = [2 1.75];%[1.6 2];
nth = 2; dwd = 30;
aem = 3.2; hp1 = .1; rsp = .35; % roaming speed


N = 800;
XS0=[0 1.1]; % initial condition
XS = XS0;
loc0 = [0 0];
loc = loc0;
clear ha RD inc.i
ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
wsp = rsp; inp.fc = prm.fc;
rmg = 1; bx = 50;
gd = 5; % max sensory input per unit movement along gradient direction (x axis)
han = normrnd(0,aem,[1 N]); han = smooth(han,71);
% inpt = normrnd(0,3,[1,N]); inpm = smooth(inpt,31);
% note: 1) duration of dwelling set to 5 tps; 2) keep speed binary for
% simplicity

Xt=XS;
for ti=2:N
    % execute movement
    if RD(ti-1)
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*wsp;
        if XS(ti-1,1)>nth; rmg = rmg-1; end % count down from 10 if NSM has crossed thresh
    else
            loc(ti,:) = loc(ti-1,:)+(rand(1,2)-.5*[1 1])*1.5; 
    end
    
    % report and terminate if crossing 20 units along gradient direction
%     if loc(ti,1)>bx; break; end
    
    % calculate sensory input based on recent movement
    inp.i(ti) = max(0,gd*(loc(ti,1)-loc(ti-1,1)));
    inp.i(ti) = gd*(loc(ti,1)-loc(ti-1,1));
%     inp.i(ti) = inpm(ti);

    
    % update circuit state
    run_bnmod
    Xt=max(0,(Xt+(dX*prm.dt)));
    XS=[XS;Xt];
    % determine which state animal will be in
    if Xt(1)>nth
        wsp = 0; RD(ti) = 0; % enter dwelling if Xt(1)/NSM rises above nth
        rmg = 0;
    else
        wsp = rsp; RD(ti) = 1; 
    end
    % terminate dwelling if duration reaches 5 tps, leave 10 tps refractory
    % window for roaming to evolve
    if ti>dwd
        if sum(RD((ti-dwd):(ti-1)))==0 % if been in dwelling for over 5tp, then switch to roaming, reset dwelling counter to 10
            RD(ti) = 1; rmg = 10; wsp = rsp;
            XS(ti,1) = 0; Xt(1) = 0;
        end
    end
    
    if RD(ti-1)==0&&Xt(1)>.75*nth; RD(ti)=0; end
    % allow roaming to continue if dwelling recently happened
    if rmg
        RD(ti)=1; wsp = rsp;
    end
        
    % update locomotory state and calculate location
    if RD(ti) % movement only occurs during roaming
        % first determine direction of motion
        if RD(ti-1)==0 % if roaming onset, randomly choose direciton
           ha(ti) = 2*(rand-.5)*pi;
        else
            dha = hp1*(-abs(ha(ti-1)));
            ha(ti) = (abs(ha(ti-1))+dha*prm.dt)*sign(ha(ti-1))+han(ti)*prm.dt;
        end        
    else
        ha(ti) = nan;
    end

end

%% plot ctx behavior
figure(26);clf;hold all
xp = loc(:,1); yp = loc(:,2); cp = RD; 
colorline_fun(xp,yp,cp,1.2); caxis([0.035 .07])
hold all
plot(xp(1),yp(1),'r.','markersize',40)
% plot(loc(dwi,1),loc(dwi,2),'r^')
ylim([-60 30]); xlim([-20 120])
