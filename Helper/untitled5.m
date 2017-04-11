% ebounmat = zeros(gdf,4);
% ebounmat(1,1:4)=[2 44.0 1 0];
% % maximum number of conditions = non*ndf
% numberofconditions=non*ndf;
% ebounc = zeros(numberofconditions,3);
% % loop over all entries of ebounds
% numberofcondition=1;
% for ebounentry = 1:gdf;
%     %loop over all nodes
%     for currentnode = 1:non;
%         dimension = ebounmat(ebounentry,1);
%         if dimension > 0
%         if x(dimension,currentnode)==ebounmat(ebounentry,2)
%             ebounc(numberofcondition,1:3) = [currentnode ebounmat(ebounentry,3) ebounmat(ebounentry,4)];
%             numberofcondition=numberofcondition+1;
%         end
%         end
%     end
% end
% ebounc

eboun = zeros(gdf,4);
eboun(1,1:4)=[2 10.0 1 0.0];
eboun(2,1:4)=[1  5.0 2 9.0];
[ nboun ] = eboun2nboun( x,non,eboun );
[ K,R ] = ApplyEssentialBoundary( ndf,non,zeros(gdf,gdf),zeros(gdf,1),nboun );
% % assemple routine
% tests=zeros(8,8);testp=[11; 12; 31; 32; 51; 52; 81; 82;]
% ii=1;for i =1:8;for j=1:8;tests(i,j) = ii;ii=ii+1;end;end;
% ixe=[1 3 5 8];
% K=zeros(18,18);
% [ s,p,K,R ] = assemble( 2,4,ixe,tests,testp,zeros(gdf,gdf),zeros(gdf,1) );
% K
% R
