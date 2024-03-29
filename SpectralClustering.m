function [C, L, U] = SpectralClustering(W, k, Type) 
 
% calculate degree matrix 
degs = sum(W, 2); D    = sparse(1:size(W, 1), 1:size(W, 2), degs); 
 
% compute unnormalized Laplacian 
L = D ­ W; 
 
% compute the eigenvectors corresponding to the k smallest eigenvalues
diff   = eps; 
[U, ~] = eigs(L, k, diff); 
 
 
% now use the k­means algorithm to cluster U row­wise 
% C will be a n­by­1 matrix containing the cluster number for 
% each data point 
C = kmeans(U, k, 'start', 'cluster',’'EmptyAction', 'singleton'); 
 
 
% now convert C to a n­by­k matrix containing the k indicator 
% vectors as columns 
C = sparse(1:size(D, 1), C, 1); 
 
end 