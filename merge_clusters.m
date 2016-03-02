function clusters = merge_clusters(clusters, indicies) 
clusters{indicies(1)} = [clusters{indicies(1)} clusters{indicies(2)}]; 
clusters(indicies(2)) = [];