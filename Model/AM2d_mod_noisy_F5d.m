clear;    figure(13);clf;hold on;
tmax=100;N=1500;wnum=15;
t=linspace(0,tmax,N);dt=tmax/N;
% MODEL PARAMS:
gam=[1.5 1.5 1];km=10; kf=5; kr=5; g=1; Ath=1.5; Mth=0;fb=1; kt=-10; kv=.5;
bdur=0;
for wi=1:wnum
    Phist=2*pi*rand; Pcur=Phist;% randomly choose initial heading angle
    XS=[1 1 0 0]; % initial condition
    X=XS;
    for ti=2:N
        A=X(1); M=X(2); XC=X(3); YC=X(4);
        % calculate and update Is
        delti=round(.5*N/tmax); % N/tmax=1s delay
        lagi=max(1,(ti-delti));
        Is=((XC-XS(lagi,3))*kt)*(M>0);% /(1+exp(2*(-M+Mth)));
        
        % determine heading angle
% %         if size(XS,1)>=2
% %         Mhist=XS(end-1,2);
% %         else 
% %             Mhist=M;
% %         end
%         Mflg=(Mhist>=Mth)*10+(M>=Mth);

i1=max(1,(size(XS,1)-2));i2=max(1,(size(XS,1)-1));
Mhist=[XS(i1,2) XS(i2,2)];
        Mflg=(Mhist(1)>=(Mth))*10+(Mhist(2)>=(Mth-.0));
         fdur=0;rdur=0;
         
        switch Mflg
            case Mflg==11 % f->f
                Pcur=Phist(end);
                [L, NUM] = bwlabeln((XS(:,2)>Mth));
                
                % attemp to terminate long runs
            case Mflg==00 % r->r
                Pcur=Phist(end);
            case Mflg==10 % f->r
                Pcur=-Phist(end);
            case Mflg==01 % r->f
                Pcur=rand*2*pi;
        end
                     
        if Mflg==11
            [L, NUM] = bwlabeln((XS(:,2)>Mth));
        fdur=length(find(L==NUM))*dt;
        rdur=0;
        bdur=length(find(L==NUM))*dt;
%             dM=dM-1*(fdur*tmax/N)*(XS(end,2));
        elseif Mflg==00
            [L, NUM] = bwlabeln((XS(:,2)<Mth));
        rdur=length(find(L==NUM))*dt; 
        fdur=0;
        bdur=length(find(L==NUM))*dt;
%             dM=dM-1*(rdur*tmax/N)*(XS(end,2));
        end

        Mlag=XS(max(1,(size(XS,1)-1)),2);
        Ma=exp(-3*Mlag)-exp(1*Mlag);
        % calculate derivatives per unit step
        dA=gam(1)*(Is+.7+2*normrnd(0,1)+fb*1/(1+exp(-km*(M-Mth)))-A)*dt;
        dM=gam(2)*(1/(1+exp(-kf*(A-Ath)))-g/(1+exp(kr*(A-Ath)))+Ma-M)*dt;
        dXC=(kv*sin(Pcur))*dt; dYC=(kv*cos(Pcur))*dt;
        
        dX=[dA dM dXC dYC]; X=X+dX; XS(ti,:)=X;
        Phist(ti)=Pcur;
    end
    % identify forward runs and record their lengths and corresponding heading angles for the current
    % rendition/worm
    [L, NUM] = bwlabeln((XS(:,2)>Mth-.2));
     fl = regionprops(L,'area');
     flen{wi}=[];
     for fi=1:length(fl)
         flen{wi}(fi)=fl(fi).Area;
         bid=find(L==fi);
         psum{wi}(fi)=Phist(bid(1));
     end
    Xend(wi)=X(3);
    subplot(211);hold all;z = zeros(size(XS(:,1)'));col = t ;
    plot(XS(:,3)',XS(:,4)','b')
    plot(XS(end,3),XS(end,4),'m.','markersize',10)

%     subplot(212);plot(t,XS(:,1:2))
    drawnow
end
%%
subplot(212);
    h = histogram(trkmat.x(end,:),-1050:100:1050);