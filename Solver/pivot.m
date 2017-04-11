function [ x ] = pivot( A,b )
% Partial Pivoting
%   A Solver based on LU-Decomposition with Partial Pivoting
%   VERSION NOCH MIT ERHEBLICHEN UMWEGEN !!! ZU VIEL SPEICHERPLATZ
%

if det(A)==0
    disp('Matrix is not singular')
else
n=size(A,1);
% Umschreiben von A(nxn) in a(1xnxn)
for i = 1:n
    for j = 1:n
      a(1,i,j) = A(i,j);
    end
end
% Start LU - Decomposition
% Master Loop over the columns - k -
 % 1. compute L(k,:,:) with basis of a(k,:,:)
 % 2. compute new a(k,:,:)
for k = 1:n-1       % columns
    
    for j = 1:n
        for z = 1:n
          l(k,j,z)=0;
        end
        l(k,j,j)=1;
    end  % eye value for L(k,:,:)
    
    if abs(a(k,k,k))<10^16
        %tausch
        %disp('swap')
        %array(a,k)
        %b
        co = 0;
        pi = 10^-16;
        for i = k:n
          if abs(a(k,i,k))>abs(a(k,k,k))%pi   
              pi = a(k,i,k);
              co = i;
                for i=k:n                % swap a
                ahelp(i)  = a(k,k,i);
                a(k,k,i)  = a(k,co,i);
                a(k,co,i) = ahelp(i);
                end

                for z=1:k-1
                for i=1:k-1                % swap l
                lhelp(k)  = l(z,k,i);
                l(z,k,i)  = l(z,co,i);
                l(z,co,i) = lhelp(k);
                end
                end

                ahelp(1) = b(k);
                b(k)     = b(co);
                b(co)    = ahelp(1);
                
        end 

        end
        %b
        %array(a,k)
    end
    
for i = k:n         % rows
    l(k,i,k)= (-a(k,i,k)/a(k,k,k));
    l(k,i,i)=1;
end
 for m = 1:n
  for o = 1:n
     a(k+1,m,o) = 0;
         for p = 1:n 
             a(k+1,m,o) = a(k+1,m,o) + l(k,m,p) * a(k,p,o);
         end
     end
 end % compute new a(k,:,:)
end
% array(a,k)
% Buildung L and U
L = zeros(n,n);
for k = 1:n
    for p = 1:n
        for z = 1:n
            for o = 1:n
            L(k,p) = L(k,p) + l(1,k,z) * l(2,z,o) * l(3,o,p);
            end
        end
    end
end
for k = 1:n-1
   for i = k+1:n
       L(i,k)=-L(i,k);
   end
end
for i = 1:n
     for j = 1:n
      U(i,j) = a(n,i,j);
     end
end
% L(n,n) U(n,n) Decomposition Complete
% Begin Backward Substitiution
% Lz=b 
z=zeros(1,n);
sl=zeros(1,n);
for i = 1:n
z(i) = b(i);
for j = 1:i-1
  sl(i) = sl(i) + L(i,j) * z(j);
end
z(i) = ( z(i) - sl(i) ) / L(i,i) ;
end
% Ux=z 
x=zeros(1,n);
su=zeros(1,n);
v = n;
for i = 1:n
x(v) = z(v);
a = n;
for j = 1:n-v
  su(v) = su(v) + U(v,a) * x(a);
  a = a - 1 ;
end
x(v) = ( x(v) - su(v) ) / U(v,v) ;
v = v - 1 ;
end
end

