% alter threshold nonlinearity, plot tradeoff between variance at high state and
% transition time (fixed input levels for both conditions), then do this
% for full and ctrl crcts

idns = [20000 500]; XS0=[1 7];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0; nfi = 31;
rl = ceil(length(ilst)/2);
XS0 = [1 7];
mbi = [];

prm = mpset.pm(end);
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];
prm.ic = 1;

ng = .15;
nlst = -.5:.3:2.6;
iplst = [.6 1.1;.6 .85];
vx2 = nan(1,length(nlst));
tst = vx2;

for ni = 1:length(nlst)
    nf = nlst(ni);
    prm.n = [2 2]+nf;

    % bistability regime, compute variance of high state
    inp.i = iplst(1,2)*ones(1,idns(1)); %  .3*ones(1,idn) 0.1*ones(1,200)
    prm.i = iplst(1,2);
    
    XS = runnmod_nsy(XS0,prm,inp,ng);
    gmfit = fitgmplt(XS,[],2,-1); % set fid to <=0 if no plot wanted
    [~,cid] = max(gmfit.mu(:,2));
    clx = cluster(gmfit,XS);
    icx = find(clx==cid); % x2 high state
    vx2(ni) = var(XS(icx,2));
    
    % r->d transition regime, compute transition time
    inp.i = iplst(1,1)*ones(1,idns(2)); %  .3*ones(1,idn) 0.1*ones(1,200)
    prm.i = iplst(1,1);
    
    tid = [];
    for ti = 1:100
        XS = runnmod_nsy(XS0,prm,inp,ng);
        ttmp = find(XS(:,1)>3);
        tid = [tid ttmp(1)];
    end
    tst(ni) = mean(tid);
end
%
figure(73);clf;hold all
yyaxis left; plot(vx2,'o-','markersize',5)
yyaxis right; plot(tst,'o-','markersize',5)

figure(74);clf;hold all
plot(vx2,tst,'o-','markersize',5)

%% now repeat with ctrl circuit
prm.ic = 0;
for ni = 1:length(nlst)
    nf = nlst(ni);
    prm.n = [2 2]+nf;
    
    % bistability regime, compute variance of high state
    inp.i = iplst(2,2)*ones(1,idns(1)); %  .3*ones(1,idn) 0.1*ones(1,200)
    prm.i = iplst(2,2);
    
    XS = runnmod_nsy(XS0,prm,inp,ng);
    gmfit = fitgmplt(XS,[],2,-1); % set fid to <=0 if no plot wanted
    [~,cid] = max(gmfit.mu(:,2));
    clx = cluster(gmfit,XS);
    icx = find(clx==cid); % x2 high state
    vx2(ni) = var(XS(icx,2));
    
    % r->d transition regime, compute transition time
    inp.i = iplst(2,1)*ones(1,idns(2)*2); %  .3*ones(1,idn) 0.1*ones(1,200)
    prm.i = iplst(2,1);
    
    tid = [];
    for ti = 1:100
        XS = runnmod_nsy(XS0,prm,inp,ng);
        ttmp = find(XS(:,1)>3);
        tid = [tid ttmp(1)];
    end
    tst(ni) = mean(tid);
end
%
figure(73);hold all
yyaxis left; plot(vx2,'^--','markersize',5)
yyaxis right; plot(tst,'^--','markersize',5)

figure(74);hold all
plot(vx2,tst,'^--','markersize',5)

%%
figure(73); xlabel('Degree of nonlinearity')
yyaxis left; ylabel('Steady state variance')
yyaxis right; ylabel('R >> D transiton time')

figure(74); xlabel('Steady state variance'); ylabel('R >> D transiton time')