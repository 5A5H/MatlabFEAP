function [ K,R ] = ApplyEssentialBoundary( ndf,non,K,R,nboun )
%function to apply essential boundary conditions on a assembled global
%stiffness matrix. means buidling of "essential equivalent load vector" to
%condence the nonzero boundary conditions on the right hand side, and
%delete the corresponding columns and rows, also for the zero essential
%conditions. Each is also applied to the element right hand side.
%   K   -> global stiffness matrix
%   R   -> global right hand side
%   nboun -> vector of boundaries, applied to node numbers
%   nboun(i,:) = [nodenumber degreeoffreedom value]

% number of applied boundary conditions
numberofboun = size(nboun,1);

% translate the first two entires of the nboun conditions
% into pointers, pointing on the corresponding global degree
% of freedom entry in the global fields
% example: @ndf=2: nboun(1,:) = [4 2 10] 
%               -> gdfboun(1,:) = [7 10]
 for bounentry = 1:numberofboun;
     gdfpointer = nboun(bounentry,1)*ndf-(ndf-1)+(nboun(bounentry,2)-1);
     gdfboun(bounentry,:) = [gdfpointer nboun(bounentry,3)];
 end
 gdfboun=sortrows(gdfboun,-1); % sorts in descend order

% build essential equivalent load vector ELV
ELV = zeros(ndf*non,1);
for i = 1:size(gdfboun,1);
    ELV(gdfboun(i,1)) = ELV(gdfboun(i,1)) + gdfboun(i,2);
end
ELV = K*ELV;

% apply essential load vector
R = R + ELV;

% reduction of global matrices
for i = gdfboun(:,1);
 K(i,:)=0; K(:,i)=0;R(i,:)=0;
end

for i = gdfboun(:,1);
 K(i,:)=[]; K(:,i)=[];R(i,:)=[];
end

end

