clear;
tmax=100;N=1500;wnum=1;
t=linspace(0,tmax,N);dt=tmax/N;
% MODEL PARAMS:
gam=[1.5 1.5 .2 .2];km=10; kf=5; kr=5; g=1; Ath=1.5; Mth=0;fb=1;
kt=-10; kv=3; kad1=.1; kad2=.1;
cpflg = 1;

figure(13);clf;hold on;
for wi=1:wnum
    Phist=2*pi*rand; Pcur=Phist;% randomly choose initial heading angle
    XS=[.2 .2 0 0 0 0]; % initial condition
    X=XS;
    for ti=2:N
        A=X(1); M=X(2); XC=X(3); YC=X(4); AD1=X(5); AD2=X(6);
        
        if cpflg % if coupling sensory stim to behavior output
            % calculate and update Is
            delti=round(.5*N/tmax); % N/tmax=1s delay
            lagi=max(1,(ti-delti));
            Is=((XC-XS(lagi,3))*kt)/(1+exp(2*(-M+Mth)));
            
            % determine heading angle
            if size(XS,1)>=2
                Mhist=XS(end-1,2);
            else
                Mhist=M;
            end
            Mflg=(Mhist>Mth)*10+(M>Mth);
            
            switch Mflg
                case Mflg==11 % f->f
                    Pcur=Phist(end);
                    % attemp to terminate long runs
                case Mflg==00 % r->r
                    Pcur=Phist(end);
                case Mflg==10 % f->r
                    Pcur=-Phist(end);
                case Mflg==01 % r->f
                    Pcur=rand*2*pi;
            end
        end
        
        lagi=max(1,size(XS,1)-2);
        fdur=0;rdur=0;
        if Mflg==11
            [L, NUM] = bwlabeln((XS(:,2)>Mth));
            fdur=length(find(L==NUM))*dt;
            %             dM=dM-1*(fdur*tmax/N)*(XS(end,2));
        elseif Mflg==00
            [L, NUM] = bwlabeln((XS(:,2)<Mth));
            rdur=length(find(L==NUM))*dt;
            %             dM=dM-1*(rdur*tmax/N)*(XS(end,2));
        end
 
        % update circuit state
        run_cmod
        
        Xt=Xt+dX;
        XS=[XS;Xt];
        Phist=[Phist Pcur];
    end
    Xend(wi)=X(3);
    subplot(311);hold all;z = zeros(size(XS(:,1)'));col =t ;
    % % plot(XS(:,3)',XS(:,4)','*')
    surface([XS(:,3)';XS(:,3)'],[XS(:,4)';XS(:,4)'],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
    subplot(312);plot(t,XS(:,2)) % smooth(XS(:,2),2)
    subplot(313);plot(t,XS(:,5:6))
    drawnow
end
% subplot(312);hist(Xend)