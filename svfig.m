function svfig(fid,savname,savpath)
figure(fid);
saveas(gcf,[savpath savname '.tif'])
saveas(gcf,[savpath savname '.fig'])
saveas(gcf,[savpath savname '.eps'],'epsc')