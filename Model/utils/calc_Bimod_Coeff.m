function BC = calc_Bimod_Coeff(X)
% calculate the BC index for a given univariate distribution X, correcting
% for sample size bias
m3 = skewness(X,0);
m4 = kurtosis(X,0) - 3;
n = length(X);

sn = 3*(n-1)^2/((n-2)*(n-3));
BC = (m3^2+1)/(m4+sn);