function labels = agglomerative_clustering(data, k) 
 
N = size(data,2); 
 
% Initially, each point is in it's own cluster. 
clusters = cell(N,1); 
for cc = 1:length(clusters) 
    clusters{cc} = [cc]; 
end 
 
% the distance between each pair of points
point_dist = point_distance(data); % Computing Euclidean Distances 
 
% until the termination condition is met 
while length(clusters) > k 
   
    % compute the distances between all pairs of clusters 
    cluster_dist = inf*ones(length(clusters)); 
    for c1 = 1:length(clusters) 
        for c2 = (c1+1):length(clusters) 
            cluster_dist(c1,c2) = cluster_distance(clusters{c1},clusters{c2}, point_dist, linkage); 
        end 
    end 
   
    % merge the two nearest clusters 
    [mm ii] = min(cluster_dist(:)); 
    [ii(1) ii(2)] = ind2sub(size(cluster_dist), ii(1)); 
    clusters = merge_clusters(clusters, ii); 
    % assign labels to the points, based on their cluster membership 
labels = zeros(N,1); 
for cc = 1:length(clusters) 
    labels(clusters{cc}) = cc; 
end 
end