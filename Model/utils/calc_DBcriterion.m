function DB = calc_DBcriterion(D1,D2)
% calculate Davies-Bouldin index for two clusters
% Variable definitions:
% d1bar = average distance between each point in the 1st cluster and the
% centroid of this cluster
% d2bar = average distance between each point in the 2nd cluster and the
% centroid of this cluster
% d12 = euclidean distance between the centroids of the two clusters
% DB = (d1bar+d2bar)/d12
D1cent = mean(D1,1); D2cent = mean(D2,1);
d12 = norm(D1cent-D2cent);
% compute within cluster mean distance to centroid
% cluster 1
Ddistmat = [];
for dd = 1:size(D1,2)
   Ddistmat = [Ddistmat D1(:,dd)-D1cent(dd)]; 
end
Ddist = (sum((Ddistmat.^2),2)).^(1/2);
d1bar = mean(Ddist);
% cluster 2
Ddistmat = [];
for dd = 1:size(D2,2)
   Ddistmat = [Ddistmat D2(:,dd)-D2cent(dd)]; 
end
Ddist = (sum((Ddistmat.^2),2)).^(1/2);
d2bar = mean(Ddist);

% calculate DB index
DB = (d1bar+d2bar)/d12;

