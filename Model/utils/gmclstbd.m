function [gmfit,dbi,xcl] = gmclstbd(X,fid)
cln = 2;
% segment into 2 gaussian "states", then calculate degree of separation
% between states

% fit GMM 
gmfit = fitgmplt(X,[],cln,fid); % set fid to <=0 if no plot wanted
clx = cluster(gmfit,X);

xcl{1} = X(clx==1,:);
xcl{2} = X(clx==2,:);

dbi = calc_DBcriterion(xcl{1},xcl{2});
