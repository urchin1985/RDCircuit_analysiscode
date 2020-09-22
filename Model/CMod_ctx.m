% clear;
prm = mpset.pm(mbi(1));
% simulate chemotaxis to dense food
clc
prm.a(1) = 1.3; %prm.a(2)=2.1;
% prm.r(2) = .3;
prm.k(4)=1.35; %prm.n(4)=2;

N = 300;
XS0=[0 1.1]; % initial condition
XS = XS0;
loc0 = [0 0];
loc = loc0;
clear ha RD inc.i
ha(1) = 2*(rand-.5)*pi; RD(1) = 1; inp.i = 0;
aem = 5.2; hp1 = .1; rsp = .5; % roaming speed
wsp = rsp; inp.fc = prm.fc;
rmg = 1; bx = 50;
nth = 1.2;gd = 2.5; % max sensory input per unit movement along gradient direction (x axis)
han = normrnd(0,aem,[1 N]); han = smooth(han,51);
% note: 1) duration of dwelling set to 5 tps; 2) keep speed binary for
% simplicity

Xt=XS;
for ti=2:N
    % execute movement
    if RD(ti-1)
        loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*wsp;
        if XS(ti-1,1)>nth; rmg = rmg-1; end
    else
            loc(ti,:) = loc(ti-1,:); 
    end
    
    % report and terminate if crossing 20 units along gradient direction
    if loc(ti,1)>bx; break; end
    
    % calculate sensory input based on recent movement
    inp.i(ti) = max(0,gd*(loc(ti,1)-loc(ti-1,1)));
    
    % update circuit state
    run_cmod2
    Xt=max(0,(Xt+(dX*prm.dt)));
    XS=[XS;Xt];
    % determine which state animal will be in
    if Xt(1)>nth
        wsp = 0; RD(ti) = 0; 
    else
        wsp = rsp; RD(ti) = 1; 
    end
    % terminate dwelling if duration reaches 5 tps, leave 10 tps refractory
    % window for roaming to evolve
    if ti>5
        if sum(RD(ti-5):RD(ti-1))==0
            RD(ti) = 1; rmg = 10; wsp = rsp;
            XS(ti,1) = 0; Xt(1) = 0;
        end
    end
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

% plot ctx behavior
figure(29);clf;hold all
subplot(5,1,1:3); hold all
plot(loc(:,1),loc(:,2),'.-')
plot(loc(1,1),loc(1,2),'ro')
dwi = RD==0;
plot(loc(dwi,1),loc(dwi,2),'r^')
subplot 514; hold all
plot(XS(:,1));plot(XS(:,2))
subplot 515; hold all
yyaxis left;plot(inp.i)
yyaxis right; plot(RD)


