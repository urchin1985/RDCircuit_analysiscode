function [nx,nnx,naf] = getxprof(xstat)

nx = sum(sum(~isnan(xstat.trxb),2)>0);
nnx = sum(sum(~isnan(xstat.sp2b),2)>0);
naf = sum(sum(~isnan(xstat.d2a),2)>0);