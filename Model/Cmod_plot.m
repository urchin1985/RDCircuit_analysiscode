setsavpath

load([savpath 'modprset.mat'])
%% generate scatter plot with paired transition latencies
sizeOfCircle = 4;
opacity = .35;
color = [0 0 .7];
xl = 340;

figure(39);clf;
transparentScatter(mpset.lat(:,1),mpset.lat(:,2),...
    sizeOfCircle,opacity,color)
xlim([0 xl]);ylim([0 xl])
axis square
plotstandard