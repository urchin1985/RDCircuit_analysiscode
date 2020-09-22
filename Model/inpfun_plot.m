% parse params
tau1 = prm.tau(1); tau2 = prm.tau(2);
ki1 = prm.ki(1); ki2 = prm.ki(2); 
ni1 = prm.ni(1); ni2 = prm.ni(2);
k12 = prm.k(1); k21 = prm.k(2); 
n12 = prm.n(1); n21 = prm.n(2); %n22 = prm.n(2,2);
a1 = prm.a(1); b1 = prm.beta(1);
a2 = prm.a(2); b2 = prm.beta(2); %r2 = prm.r(2);
bs1 = prm.b(1); bs2 = prm.b(2); % basal prod rates
ic = prm.ic;
% parse inputs
fc = 1; I = prm.i(1);
%%
ivc = 0:.1:2.5;
nip1 = fc*a1*sig(ki1,ni1,ic*ivc);
nip2 = a2*sig(ki2,ni2,ivc);

if ~exist('ifd','var')
    ifd = 15;
end
figure(ifd);clf;hold all
plot(ivc,nip1);plot(ivc,nip2)
set(gcf,'outerposition',[0 380 235 270])