function d = point_distance(X) 
N = size(X,2); 
d = sum(X.^2,1); 
d = ones(N,1)*d + d'*ones(1,N) ­ 2*X'*X; 
end