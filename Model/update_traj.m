
% 1. execute movement
if RD(ti-1)
    loc(ti,:) = loc(ti-1,:)+[cos(ha(ti-1)) sin(ha(ti-1))]*wsp;
    rmg = rmg-1;% count down from 10 if NSM has crossed thresh
else
    loc(ti,:) = loc(ti-1,:);
end

% 2. calculate sensory input based on recent movement
inp.i(ti) = max(0,gd*(loc(ti,1)-loc(ti-1,1)))+.65;
% inp.i(ti) = gd*(loc(ti,1)-loc(ti-1,1))+.65;
%     inp.i(ti) = .65;

% 3. update circuit state
if ~exist('gtp','var')
    gtp = 1;
end
run_bnmod_nsy_icf
Xt=max(0,(Xt+(dX*prm.dt)));
XS=[XS;Xt];
% determine which state animal will be in
if Xt(1)>nth&&rmg<=0
    wsp = 0; RD(ti) = 0; % enter dwelling if Xt(1)/NSM rises above nth
    rmg = 0;
else
    wsp = rsp; RD(ti) = 1;
end
if Xt(1)>3.7&&rmg<0; whp; end
% 4. terminate dwelling if duration reaches dwd tpts (better to let nsm decay naturally), the ensuing roamng
% period will last a min of 10 tpts
if ti>dwd
    if RD(ti-1)==0
        if sum(RD((ti-dwd):(ti-1)))==0 % if been in dwelling for over x tp, then switch to roaming, reset dwelling counter to 10
            RD(ti) = 1; rmg = rmx; wsp = rsp;
            Xt = [0 5]; XS(ti,:) = Xt;
        end
    end
    if ti>rmd
        if mean(RD((ti-rmd):(ti-1)))==1 % if been in roaming for over y tp, then switch to roaming, reset dwelling counter to 10
            RD(ti) = 0; rmg = 0; wsp = 0;
            Xt = [nth+.05 0]; XS(ti,:) = Xt;
        end 
    end
end
if RD(ti-1)==0&&Xt(1)>.75*nth; RD(ti)=0; end % prevent oscillations
% allow roaming to continue if dwelling recently happened
if rmg
    RD(ti)=1; wsp = rsp;
end

% 5. update locomotory state and calculate location
if RD(ti) % movement only occurs during roaming
    % first determine direction of motion
    if RD(ti-1)==0 % if roaming onset, randomly choose direciton
        ha(ti) = 2*(rand-.5)*pi;
    else
        dha = (prm.ic>0)*hp1*(-abs(ha(ti-1)));
        ha(ti) = (abs(ha(ti-1))+dha*prm.dt)*sign(ha(ti-1))+han(ti)*prm.dt;
    end
else
    ha(ti) = nan;
end
