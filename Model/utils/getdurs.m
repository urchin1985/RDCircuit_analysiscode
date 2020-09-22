function dvec = getdurs(ivec)
ip = regionprops(ivec,'area');
dvec = cat(1,ip.Area);