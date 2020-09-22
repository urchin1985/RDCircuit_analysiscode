load([savpath gtype '_optotrans_PCAboot_15s.mat'],'T_on','P_on','tpre','tpost','TB','dt')
    figure(foi); clf
%%
bn = size(T_on(1).vals,1);
bnm = size(TB.px,1);

    figure(foi); hold all

for bi = 1:bnm
    px = TB.px(bi,:); py = TB.py(bi,:);
    pu = TB.pu(bi,:); pv = TB.pv(bi,:);
    pclr = TB.pcl(:,:,bi);
    
   
            for qi = 1:length(pu)
                hold all
                ctmp = pclr(qi,:);
                cpc = ones(1,3)-(.3*(ones(1,3)-ctmp));
                plot(px([qi qi+1]),py([qi qi+1]),'color',cpc);
            end

end

%%
mpx = median(TB.px,1); mpy = median(TB.py,1); mplc = median(TB.pcl,3);
mpu = diff(mpx); mpv = diff(mpy);
% pclr = ncmap(round(mplc*150),:);
psz = sqrt(mpu.^2+mpv.^2);
for qi = 1:length(mpu)
    hold all
    q=quiver(mpx(qi),mpy(qi),mpu(qi),mpv(qi));
%     ctmp = pclr(qi,:);
    q.Color = mplc(qi,:);
    q.MaxHeadSize = .5*1.2/psz(qi);
    q.AlignVertexCenters = 'on';
    q.LineWidth = 1.5;
end

grid on
xlabel('PC1');ylabel('PC2');
xlim([-1.3 1.2]); ylim([-.5 2]);
axis square
%% save data for direct plotting
saveas(gcf,[savpath2 gtype '_optotranspca.tif'])
saveas(gcf,[savpath2 gtype '_optotranspca.fig'])
saveas(gcf,[savpath2 gtype '_optotranspca.eps'],'epsc')
% %
