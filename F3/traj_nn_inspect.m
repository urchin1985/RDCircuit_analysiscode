%%
pd = [3 8 9];
pset = [predat posdat];
tn = size(T_on(1).vals,1);
prng = 440:600; onp = prn(end)-prng(1)+1;

for ti = 1:tn
figure(foi); clf; hold all

        plot(pl(:,pd(1)),pl(:,pd(2)),cvc,'linewidth',2)
        % errorbar(prm(:,1),prm(:,2),prm(:,1)-prebl(),ypos,xneg,xpos)
        plot(prm(:,pd(1)),prm(:,pd(2)),'ko-','markersize',9)
        scatter(prm(:,pd(1)),prm(:,pd(2)),75,ncmap(min(100,max(1,round(prc*150))),:),'filled','o')
        
        plot(pom(:,pd(1)),pom(:,pd(2)),'k^-','markersize',9)
        scatter(pom(:,pd(1)),pom(:,pd(2)),75,ncmap(min(100,max(1,round(poc*150))),:),'filled','^')
        
        grid on
        xlabel(cnmvec{pd(1)});ylabel(cnmvec{pd(2)});

        % plot individual trajectories
        plot(T_on(pd(1)).vals(ti,prng),T_on(pd(2)).vals(ti,prng),'.-')
         scatter(T_on(pd(1)).vals(ti,prng(1)),T_on(pd(2)).vals(ti,prng(1)),22,'k','filled')
        scatter(T_on(pd(1)).vals(ti,prn(end)),T_on(pd(2)).vals(ti,prn(end)),22,'r','filled')
        [x,y] = ginput(1);
end

%% now compare raw traces with time averaged traces
dt = 10;
load([savpath gtype '_statetrans_3nn_' num2str(dt/2) 's.mat'],'T_on','tpre','tpost','TP','dt')

% figure