clc;
close all;
clear;

N = size(X,1); 
Ke = zeros(N); 
gam = 1; 
 
% RBF kernel  
for n = 1:N 
    for n2 = 1:N 
        Ke(n,n2) = exp(­gam*sum((X(n,:)­X(n2,:)).^2)); 
    end 
end 
 
% Polynomial kernel 
% (b,d are some constants) 
b = 2;  
d = 3; 
for n = 1:N 
    for n2 = 1:N 
       ​
Ke(n,n2) ​= (X' * X + b).^d;
 end 
end 
 
converged = 0; 
% Assign all objects into one cluster except one 
K = 2; 
Z = repmat([1 0],N,1); 
s = sum(X.^2,2); 
pos = find(s==min(s)); 
Z(pos,:) = [0 1]; 
di = zeros(N,K); 
cols = {'r','b'}; 
while ~converged 
   Nk = sum(Z,1); 
    for k = 1:K 
        % Compute kernelized distance 
        di(:,k) = diag(Ke) ­ (2/(Nk(k)))*sum(repmat(Z(:,k)',N,1).*Ke,2) + Nk(k)^(­2)*sum(sum((Z(:,k)*Z(:,k)').*Ke)); 
    end 
    oldZ = Z; 
    Z = (di == repmat(min(di,[],2),1,K)); 
    Z = 1.0*Z; 
    if sum(sum(oldZ~=Z))==0 
        converged = 1; 
    end 
end 