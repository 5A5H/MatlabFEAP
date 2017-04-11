function [ nboun ] = eboun2nboun( x,non,eboun )
%select node numbers for given edge and stores their given essential
%boundary conditions
%   Usage Example
%     Eboundary
%      2  .5  1 10.0
%      |  |   |  value of essential boundary condition
%      |  |   number of degree of freedom (1-> ux , 2 -> uy ....)
%      |  value of coordinate
%      spacial dimension for edge
%
% the example above selects all nodes which y- coordinate is equal to .5
% and set here a x-displacement on the value 10.0
% the given boundary is applied to all node (nodenumber) that fit the
% pattern
% results is stored into the nboun field
% nboun(i,:) = [nodenumber degreeoffreedom value]
% can also be used for natural conditions

% figure out number of given eboun conditions
numberofebounconditions=size(eboun,1);

% loop over all entries of eboun
numberofnbouncondition=1;
for ebounentry = 1:numberofebounconditions;
    %loop over all nodes
    for currentnode = 1:non;
        dimension = eboun(ebounentry,1);
        if dimension > 0
        if x(dimension,currentnode)==eboun(ebounentry,2)
            nboun(numberofnbouncondition,1:3) = [currentnode eboun(ebounentry,3) eboun(ebounentry,4)];
            numberofnbouncondition=numberofnbouncondition+1;
        end
        end
    end
end

end

