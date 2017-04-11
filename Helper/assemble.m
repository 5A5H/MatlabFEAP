function [ s,p,K,R ] = assemble( ndf,nen,ixe,s,p,K,R )
%function to assemble a local element stiffness matrix s and element right hand
%side p into the global stiffness matix K and right hand side R
%   ndf -> nodal degrees of freedom
%   nen -> number of element nodes
%   ixe -> element node numbers
%   s   -> local element stiffness matrix
%   p   -> local element right hand side vector
%   K   -> global element stiffness matrix
%   R   -> global element right hand side vector

% devlare subvector and matrix
subv = zeros(ndf,1);
subm = zeros(ndf,ndf);

% loop over all element nodes
for localvariationnode = 1:nen;
for localdeltanode = 1:nen;
    % get local submatrix & vector
    lvpointer = localvariationnode*ndf - (ndf-1);
    ldpointer = localdeltanode*ndf - (ndf-1);
    subv(1:ndf) = p(lvpointer:lvpointer+ndf-1);
    subm(1:ndf,1:ndf) = s(lvpointer:lvpointer+ndf-1,ldpointer:ldpointer+ndf-1);
    % get global dependency
    globalvariationnode = ixe(localvariationnode);
    globaldeltanode = ixe(localdeltanode);
    % add local submatrix on global matrix
    gvpointer = globalvariationnode*ndf - (ndf-1);
    gdpointer = globaldeltanode*ndf - (ndf-1);
    K(gvpointer:gvpointer+ndf-1,gdpointer:gdpointer+ndf-1) = ...
        K(gvpointer:gvpointer+ndf-1,gdpointer:gdpointer+ndf-1) + subm;
end;
    % add local subvector on global vector
    R(gvpointer:gvpointer+ndf-1) = R(gvpointer:gvpointer+ndf-1)...
        + subv;
end;

