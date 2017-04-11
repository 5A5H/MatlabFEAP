function [ K,R ] = ApplyNaturalBoundary( ndf,non,K,R,nforce )
%function to apply natural boundary conditions
%   K   -> global stiffness matrix
%   R   -> global right hand side
%   nforce -> vector of forces, applied to node numbers
%   nforce(i,:) = [nodenumber degreeoffreedom value]

% number of applied boundary conditions
numberoffoces = size(nforce,1);

% translate the first two entires of the nboun conditions
% into pointers, pointing on the corresponding global degree
% of freedom entry in the global fields
% example: @ndf=2: nboun(1,:) = [4 2 10] 
%               -> gdfboun(1,:) = [7 10]
 for forceentry = 1:numberoffoces;
     gdfpointer = nforce(forceentry,1)*ndf-(ndf-1)+(nforce(forceentry,2)-1);
     gdfforce(forceentry,:) = [gdfpointer nforce(forceentry,3)];
 end
 gdfforce=sortrows(gdfforce,-1); % sorts in descend order

% build essential equivalent load vector ELV
Loadvec = zeros(ndf*non,1);
for i = 1:size(gdfforce,1);
    Loadvec(gdfforce(i,1)) = Loadvec(gdfforce(i,1)) + gdfforce(i,2);
end


% apply essential load vector
R = R + Loadvec;


end

