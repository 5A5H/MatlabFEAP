function [ p,s ] = elmt01( xl,ul,mat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
E = mat(1); nu = mat(2);
lam = (E*nu)/((1+nu)*(1-2*nu)); mue = E/(2+2*nu);
cmat = zeros(2,2,2,2);
cmat(1,1,1,1) = lam + 2 * mue;
cmat(1,1,2,2) = lam;
cmat(2,2,1,1) = cmat(1,1,2,2);
cmat(2,2,2,2) = cmat(1,1,1,1);
cmat(1,2,1,2) = mue;
cmat(1,2,2,1) = mue;
cmat(2,1,1,2) = mue;
cmat(2,1,2,1) = cmat(1,2,1,2);

% Gauss Points
wg = zeros(4); eg = zeros(2,4);
h = 1/sqrt(3); 
eg(1,1) = -h   ;  eg(2,1) = -h   ;
eg(1,2) =  h   ;  eg(2,2) = -h   ;
eg(1,3) =  h   ;  eg(2,3) =  h   ;
eg(1,4) = -h   ;  eg(2,4) =  h   ;
wg(1) = 1.0; wg(2) = 1.0; wg(3) = 1.0; wg(4) = 1.0;

p = zeros(4*2,1); s = zeros(4*2,4*2);
% Start Gauss Loop
for l = 1:4;

[ shp,detj ] = shape( eg(:,l),xl );
dvol = detj * wg(l);

% Strain
eps = zeros(2,2);
for k = 1:4;
    eps(1,1) = eps(1,1) + shp(1,k) * ul(1,k);
    eps(2,2) = eps(2,2) + shp(2,k) * ul(2,k);
    eps(1,2) = eps(1,2) + .5 * ( shp(1,k) * ul(2,k) + shp(2,k) * ul(1,k) );
    eps(2,1) = eps(1,2);
end

% Stress
sig = zeros(2,2);
for i = 1:2;
    for j = 1:2;
        for a = 1:2;
            for b = 1:2;
                sig(i,j) = sig(i,j) + cmat(i,j,a,b) * eps(a,b);
            end 
        end
    end
end

% RHS
ii = 1;
for i = 1:4;
    for a = 1:2;
        p(ii) = p(ii) - .5*dvol*(sig(1,a)*shp(a,i)+sig(a,1)*shp(a,i));
        p(ii+1) = p(ii+1) - .5*dvol*(sig(2,a)*shp(a,i)+sig(a,2)*shp(a,i));
    end
    ii = ii + 2;
end

% LHS
ii = 1;
for i = 1:4;
    jj = 1;
    for j = 1:4;
        for a = 1:2;
            for b = 1:2;
                
                s(ii,jj) = s(ii,jj) + .25*dvol*(...
                    cmat(1,a,1,b)*shp(a,i)*shp(b,j) + ...
                    cmat(a,1,1,b)*shp(a,i)*shp(b,j) + ...
                    cmat(1,a,b,1)*shp(a,i)*shp(b,j) + ...
                    cmat(a,1,b,1)*shp(a,i)*shp(b,j) );
                s(ii,jj+1) = s(ii,jj+1) + .25*dvol*(...
                    cmat(1,a,2,b)*shp(a,i)*shp(b,j) + ...
                    cmat(a,1,2,b)*shp(a,i)*shp(b,j) + ...
                    cmat(1,a,b,2)*shp(a,i)*shp(b,j) + ...
                    cmat(a,1,b,2)*shp(a,i)*shp(b,j) );
                s(ii+1,jj) = s(ii+1,jj) + .25*dvol*(...
                    cmat(2,a,1,b)*shp(a,i)*shp(b,j) + ...
                    cmat(a,2,1,b)*shp(a,i)*shp(b,j) + ...
                    cmat(2,a,b,1)*shp(a,i)*shp(b,j) + ...
                    cmat(a,2,b,1)*shp(a,i)*shp(b,j) );
                s(ii+1,jj+1) = s(ii+1,jj+1) + .25*dvol*(...
                    cmat(2,a,2,b)*shp(a,i)*shp(b,j) + ...
                    cmat(a,2,2,b)*shp(a,i)*shp(b,j) + ...
                    cmat(2,a,b,2)*shp(a,i)*shp(b,j) + ...
                    cmat(a,2,b,2)*shp(a,i)*shp(b,j) );
                
            end
        end
        jj = jj + 2;
    end
    ii = ii + 2;
end


end%gauss

end

