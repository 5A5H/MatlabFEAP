function [ u ] = DirectMatrixSolve( p,K )
% function directly solves the linear 
% equation system K u = p 
%   it does so by using the inverse of K
%   u = K^-1 p
  
  u = inv(K)*p;

end

