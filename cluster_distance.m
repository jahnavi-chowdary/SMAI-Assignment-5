function d = cluster_distance(c1,c2,point_dist,linkage) 
 
d = point_dist(c1,c2); 
 
switch linkage 
    case 0 
        % ­­ Simple Linkage ­­ 
        % distance between two nearest points 
        d = min(d(:)); 
   
 case 1 
        % ­­ Complete Linkage ­­ 
        % distance between two furthest points 
        d = max(d(:)); 
  
    case 2 
        % ­­ Average Linkage ­­ 
        % average distance between points in the two clusters 
        d = mean(d(:)); 
        case 3 
        % ­­ Mean Linkage ­­ 
        % average distance between points in the two clusters 
        d = norm(mean(c1) ­ mean(c2)); 
 
end 