% % prm.tau = 1*[1 1];
% % prm.ki = [.5 .5]; % vary between .25-2.5
% % prm.ni = [1 3]; % vary between 1-4
% % prm.k = [0 1;.3 .5]; % vary between .2-5
% % prm.n = [0 4;3 2]; % vary between 1.7-5
% % prm.b = [.5 .2]+1; % baseline activity % vary between .5-2
% % prm.a = [1.3 1.8]; % gain on chemosensory input % vary between .5-5
% % prm.beta = [3.25 2]; % gain on mutual inhibition % vary between 1-5
% % prm.r = [0 0];
% % prm.dt = .25;
% % % specify sensory inputs
% % prm.fc = 1.2; % vary between .5-2
% % prm.i = 1.1; 
% % prm.ic = 1;

setsavpath
load([savpath 'modprset.mat'])

ml = length(moi.pm);
prm = moi.pm(randperm(ml,1));
prm.tau = prm.tau/5;