clear; figure(1);clf;hold all;
z=1;l=1;a=0;v=1;s=1; n=3; m=6;add=0;
ssol5=cell(1,41);ssol1=cell(1,41);ussol5=cell(1,41);ussol1=cell(1,41);
for i=1:41
    l=0.05*(i-1);
    clear l7 m1 m5 t w S R v2 f rr
    % 5D model
    syms l7 m1 m5 t w
    f1=.4*(32*((z*7.5*t.^n+1*w.^n)./(47^n+(z*7.5*t.^n+1*w^n)))-l7);
    f2=.35*((10+1*11*(0.5./(0.5+w)))-m1);
    f3=.5*(5.5*(53./(53+w))-m5);
    rr=s*0.36*l7+(a*m1)+v*0.16*m5;
    f4=1*(l*4*rr.*(58^m./(58^m+z*t.^m))-w);
    f5=5*(w-t);
    S=solve(f1,f2,f3,f4,f5);
    sind=find(S.w>=0&imag(S.w)==0); % find real non-negative solutions
    wval=S.w(sind);l7val=S.l7(sind);m1val=S.m1(sind);m5val=S.m5(sind);
    tval=S.t(sind);
    sval=eval([l7val m1val m5val wval tval]);
    f=[f1;f2;f3;f4;f5];
    v2=[l7,m1,m5,w,t];
    R=jacobian(f,v2);
    for gi=1:length(sind)
        stb=subs(R,v2,sval(gi,:));
        ev=eig(stb);
        if isempty(find(ev>=0)); % 1~all eigval negative, 0~some eigval non-neg
            ssol5{i}=[ssol5{i};sval(gi,end)];
        else
            ussol5{i}=[ussol5{i};sval(gi,end)];
        end
    end
    clear l7 m1 m5 t w S R v2 f rr
    % 1D model
    syms w
    rr=s*0.36*32*((z*7.5+1)*w.^n./(47^n+(z*7.5+1)*w.^n))+add+(a*(10+1*11*(0.5./(0.5+w)))+v*0.16*5.5*(53./(53+w)));
    f=l*4*(rr+add).*(58^m./(58^m+z*w.^m))-w;
    S=solve(f);
    sind=find(S>=0&imag(S)==0); % find real non-negative solutions
    sval=eval(S(sind));
%     length(sind)
    R=jacobian(f,w);
    for gi=1:length(sind)
        stb=subs(R,w,sval(gi));
        
        if stb<0
            ssol1{i}=[ssol1{i};sval(gi,end)];
        else
            ussol1{i}=[ussol1{i};sval(gi,end)];
        end
    end
end
%%
save('Bifresult92212.mat','ssol1','ssol5','ussol1','ussol5')
%%
clf;hold all;setframe
s1l=-1*ones(1,41);s5l=s1l;
s1u=-1*ones(1,41);s5u=s1u;
us5=s1l;us1=s1l;
for ti=1:41
    if ti<=33
        if ~isnan(ssol5{ti});s5l(ti)=min(ssol5{ti});else s5l(ti)=-1;end
if ~isnan(ssol1{ti});s1l(ti)=min(ssol1{ti});else s1l(ti)=-1;end
    end
    if ti>18
        if ~isnan(ssol5{ti});s5u(ti)=max(ssol5{ti});else s5u(ti)=-1;end
if ~isnan(ssol1{ti});s1u(ti)=max(ssol1{ti});else s1u(ti)=-1;end
    end
    if ti>18&&ti<=33
        if ~isnan(ussol5{ti});us5(ti)=max(ussol5{ti});else us5(ti)=-1;end
if ~isnan(ussol1{ti});us1(ti)=max(ussol1{ti});else us1(ti)=-1;end
    end
end

% plotting lower, mid and upper bif lines
pli=find(s5u~=-1);plot(pli,s5u(pli),'k','LineWidth',6);
pli=find(s5l~=-1);plot(pli,s5l(pli),'k','LineWidth',6);
pli=find(us5~=-1);plot(pli,us5(pli),'k:','LineWidth',4.5)
pli=find(s1u~=-1);plot(pli,s1u(pli),'r','LineWidth',2.5)
pli=find(s1l~=-1);plot(pli,s1l(pli),'r','LineWidth',2.5);
pli=find(us1~=-1);plot(pli,us1(pli),'r:','LineWidth',2.5)
ylim([0 90]);xlim([0 41]);
set(gca,'ytick',[0 25 50 75])