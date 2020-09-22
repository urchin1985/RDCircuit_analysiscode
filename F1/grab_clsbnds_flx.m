function NTR = grab_clsbnds_flx(fidata, cdata, clx, foi)
%%
foi = (foi(:))';
NTR = struct('cldur',[],'clstrt',[],'clend',[],'cnbr',[]);
for dfi = foi
    fidx = find(fidata==dfi);
    ncls = clx(fidx);
    ndat = cdata(fidx,1);
    
    % gather cluster start end indices, loc/dset affiliation and other
    % attributes
    for cid = (unique(ncls))'
        cidx = (ncls==cid);

%                 cidx = imdilate(cidx,strel('square',6)); % dilate 3 time points (1.5 s) to capture initial rise and final drop
        cp = regionprops(cidx,'Area','PixelIdxList');
        
        cii = 1; prvstrt = 0;
        for cpi = 1:length(cp)
            segstrt = (cp(cpi).PixelIdxList(1));
            segend = (cp(cpi).PixelIdxList(end));
            segstrtn = segstrt;
            segendn = segend;
            
                        
            if segstrtn ~= prvstrt
            NTR(cid,dfi).cldur(cii) = segendn-segstrtn+1;
            NTR(cid,dfi).clstrt(cii,:) = [segstrtn fidx(segstrtn)];
            NTR(cid,dfi).clend(cii,:) = [segendn fidx(segendn)];
            NTR(cid,dfi).cmax(cii) = max(ndat(segstrtn:segendn));
            NTR(cid,dfi).cmed(cii) = median(ndat(segstrtn:segendn));
            NTR(cid,dfi).cmin(cii) = prctile(ndat(segstrtn:segendn),5);
            
            if NTR(cid,dfi).clstrt(cii,1)~=1&&NTR(cid,dfi).clend(cii,1)~=length(fidx)
                NTR(cid,dfi).cnbr(cii,:) = [(ncls(NTR(cid,dfi).clstrt(cii,1)-1)) (ncls(NTR(cid,dfi).clend(cii,1)+1))];
                % [1 1] if segment follows low state and is followed by high state
            elseif NTR(cid,dfi).clstrt(cii,1)==1
                NTR(cid,dfi).cnbr(cii,:) = [-1 (ncls(NTR(cid,dfi).clend(cii,1)+1))];
            elseif NTR(cid,dfi).clend(cii)==length(fidx)
                NTR(cid,dfi).cnbr(cii,:) = [(ncls(NTR(cid,dfi).clstrt(cii,1)-1)) -1];
            end
            end
            
            prvstrt = segstrtn;
            cii = cii+1;
        end
%         o
    end
    %     figure(10);clf;hold all
    %     imagesc([ncls ncls]'); colormap cool
    %     plot(ndat)
end
% o