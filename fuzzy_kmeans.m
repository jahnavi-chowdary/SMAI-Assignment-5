function [U, centroid, dist, b, obj] = fuzzy_kmeans(nclass,data,y,U,phi,maxiter,toldif) 
 
   
ndata = size(data, 1);         % number of data  
ndim = size(data, 2);         % number of dimension 
centroid=zeros(nclass,ndim); 
dist=zeros(ndata,nclass); 
 
W=inv(cov(data)); 
 
obj=0; 
%x=[ones(ndata,1), data]; 
%nd = ndim+1;       % number of dimension 
x=[data]; 
nd=ndim; 
 
b=zeros(nd,nclass); 
yp=zeros(ndata,nclass); 
for i = 1:maxiter, 
 
    %   save previous iterations 
    U_old=U; 
    obj_old=obj; 
 
 
    for k=1:nclass 
    % weighted LS 
        wei(:,1)=U(:,k);  
        A=wei(:,ones(nd,1)).*x; 
        y1=wei.*y; 
        b(:,k)=A\y1; 
        yp(:,k)=x*b(:,k); 
        dist(:,k)=(yp(:,k)­y).^2; 
    end 
   
    % calculate new membership matrix 
    tmp = dist.^(­1/(phi­1));   
    t1=sum(tmp')'; 
    t2=t1(:,ones(nclass,1)); 
    U = tmp./t2; 
 
   
    % calculate objective function 
    uphi = U.^phi; 
    o1=(dist.^2).*uphi; 
    obj = sum(sum(o1'));  
   
    % check for convergence 
    dif=(obj_old­obj); 
    difU=sqrt((U ­ U_old).*(U ­ U_old)); 
    Udif=sum(sum(difU)); 
 
 
    if and(dif<toldif,Udif < toldif), break; end, 
   
end 
 % calculate centroid 
    uphi = U.^phi;   
    c1=uphi'*data; 
    t1=sum(uphi)'; 
    t1=t1(:,ones(ndim,1)); 
    centroid=c1./t1; 