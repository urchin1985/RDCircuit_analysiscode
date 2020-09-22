clear prm
prm.tau = 5*[1 1];
prm.ic = 1;
prm.a = [1.6 3.6];
prm.ki = [.4 1];
prm.ni = [4 5];
prm.b = [0 0];
prm.beta = [4 3.7];
prm.k = [4.25 3.75]; %prm.n(4)=2;
prm.n = [2 2];%[1.6 2];
prm.dt = .25;
prm.fc = 1;

tau1 = prm.tau(1); tau2 = prm.tau(2);
x1 = 0:.025:8;
x2 = x1;
I = -3:.15:3;

ki1 = prm.ki(1); ki2 = prm.ki(2); 
ni1 = prm.ni(1); ni2 = prm.ni(2);
k12 = prm.k(1); k21 = prm.k(2); 
n12 = prm.n(1); n21 = prm.n(2); %n22 = prm.n(2,2);
a1 = prm.a(1); b1 = prm.beta(1);
a2 = prm.a(2); b2 = prm.beta(2); %r2 = prm.r(2);
bs1 = prm.b(1); bs2 = prm.b(2); % basal prod rates
ic = prm.ic;
% parse inputs
fc = prm.fc; 
if ic==0
    ig = .15; 
else
    ig = 1;
end

sgi1 = fc*a1*sig(ki1,ni1,ic*I);
sgi2 = a2*sig(ki2,ni2,I);

sig1 = b1*sigflip(k12,n12,x2)+bs1;
sig2 = b2*sigflip(k21,n21,x1)+bs2;

figure(127);clf; hold all
subplot 231; hold all
yyaxis left;plot(I,sgi1)
yyaxis right;plot(I,sgi2)
subplot 232; hold all
plot(sig1,x2); plot(x1,sig2)

% probe different input levels
Ic = .1;
caldx
% low I
subplot 233; hold all; title(num2str(Ic))
plot(dx1,x2); plot(x1,dx2)

Ic = .5;
caldx
% low I
subplot 234; hold all; title(num2str(Ic))
plot(dx1,x2); plot(x1,dx2)

Ic = 1;
caldx
% low I
subplot 235; hold all; title(num2str(Ic))
plot(dx1,x2); plot(x1,dx2)

Ic = 2;
caldx
% low I
subplot 236; hold all; title(num2str(Ic))
plot(dx1,x2); plot(x1,dx2)