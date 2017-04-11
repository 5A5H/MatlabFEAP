function [ shp,detj ] = shape( eg,xl )
% the eg in this is like eg = [xi eta]
% xl(2,nen)
nen = 4;

shp = zeros(3,4); sh0 = zeros(2,4);

shp(3,1) = 0.25*(1-eg(1))*(1-eg(2));
shp(3,2) = 0.25*(1+eg(1))*(1-eg(2));
shp(3,3) = 0.25*(1+eg(1))*(1+eg(2));
shp(3,4) = 0.25*(1-eg(1))*(1+eg(2));

sh0(1,1) = - 0.25*(1-eg(2));
sh0(1,2) =   0.25*(1-eg(2));
sh0(1,3) =   0.25*(1+eg(2));
sh0(1,4) = - 0.25*(1+eg(2));

sh0(2,1) = - 0.25*(1-eg(1));
sh0(2,2) = - 0.25*(1+eg(1));
sh0(2,3) =   0.25*(1+eg(1));
sh0(2,4) =   0.25*(1-eg(1));

% Jacobi Matrix
xj = sh0*xl';

% Determinante der Jacobi Matrix

detj = xj(1,1) * xj(2,2) - xj(1,2) * xj(2,1);

% Inverse der Jacobi Matrix

%xjinv = inv(xj);
xjinv = zeros(2,2);
xjinv(1,1) =   xj(2,2)/detj;
xjinv(1,2) = - xj(1,2)/detj;
xjinv(2,1) = - xj(2,1)/detj;
xjinv(2,2) =   xj(1,1)/detj;

% Derivatives w.r.t. X,Y

for i = 1:2;
    for j = 1:nen;
        for k = 1:2;
            shp(i,j) = shp(i,j) + xjinv(k,i) * sh0(k,j);
        end
    end
end


end

