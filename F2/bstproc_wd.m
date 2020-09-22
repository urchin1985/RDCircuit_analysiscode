bti = bdat==3; % transition state
        tp = regionprops(bti,'PixelIdxList');
        for tpi = 1:length(tp) % for each bout of transition period, check flanking states and absorb into flanking or assign to neighboring states
            ctp = [tp(tpi).PixelIdxList(1) tp(tpi).PixelIdxList(end)];
            cfk1 = min(length(bdat),max(1,ctp(1)+(-5:-1)));
            cfk2 = min(length(bdat),max(1,ctp(end)+(1:5)));        
            bfk1 = (bdat(cfk1)); bfk1(bfk1==3) = [];
            bfk1 = median(bfk1);
            bfk2 = (bdat(cfk2)); bfk2(bfk2==3) = [];
            bfk2 = median(bfk2);
            bfk = [bfk1 bfk2];
            if length(unique(bfk))==1
                bdat(ctp(1):ctp(2)) = bfk(1);
            elseif length(tp(tpi).PixelIdxList)>100&&bfk1==1
                ctmid = ctp(1)+30;
                bdat(ctp(1):ctmid) = bfk(1);
                bdat(ctmid:ctp(2)) = bfk(2);
            else% 50s
                ctmid = round(median(ctp));
                bdat(ctp(1):ctmid) = bfk(1);
                bdat(ctmid:ctp(2)) = bfk(2);
                
            end
        end
        
        % getting rid of spurious dwelling states
        bd2 = imclose(bdat>1,strel('disk',15));
        bd1 = imclose(bdat==1,strel('disk',155));
        bdat = bd2.*(1-bd1);
        bdat = double(bdat)+1;
       