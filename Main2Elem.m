% Main File for Cook
clear all
clc
addpath(genpath('Plot'));
addpath(genpath('Solver'));
addpath(genpath('Helper'));
addpath(genpath('Elements'));

%% Computational Domain
E = 200; nu = 0.35;
x = [ 0  0; 5 0; 5 10; 0 10;10 0; 10 10]';
ix = [1 2 3 4 ; 2 5 6 3];
mat = [E nu];     % element domain parameter
eboun = [1 0.0 1 0.0;...
         2 0.0 2 0.0]; %eboun command storage
eforce = [1 10.0 1 -500.0]; %eboun command storage
nen = size(ix,2); % number of element nodes
non = size(x,2);  % number of nodes
ndf = 2;          % nodal degrees of freedom
gdf = non*ndf;    % global degrees of freedom
edf = nen*ndf;    % element degrees of freedom  
nel = size(ix,1); % number of elmements

%% Set Global Matrices
ul = zeros(ndf,non); % vector of global degrees of freedom (1:2 -> ux,uy) 
P  = zeros(gdf,1);   % global right hand side
K  = zeros(gdf,gdf); % global stiffness matrix

%% Loop over all elements
for currentelement = 1:nel;
    % elemental nodes/dofs
    localnodes = ix(currentelement,:);
    xl = x(:,localnodes);
    ule = ul(:,localnodes);
    % call element
    % pp -> element right hand side
    % ss -> element stiffness matrix
    [ pp,ss ] = elmt01( xl,ule,mat );
    % assembling
    [ ss,pp,K,P ] = assemble( ndf,nen,localnodes,ss,pp,K,P );
end
%% Apply BoundaryConditions
%natural
[ nforce ] = eboun2nboun( x,non,eforce );
[ K,P ] = ApplyNaturalBoundary( ndf,non,K,P,nforce );
%essential
% here in enties of stiffnessm
% for i = [10 7 4 2 1];
%  K(i,:)=0; K(:,i)=0;P(i,:)=0;
% end
% 
% for i = [10 7 4 2 1];
%  K(i,:)=[]; K(:,i)=[];P(i,:)=[];
% end
[ nboun ] = eboun2nboun( x,non,eboun );
[ K,P ] = ApplyEssentialBoundary( ndf,non,K,P,nboun );

%% Solve
[ duv ] = DirectMatrixSolve( P,K );
duv = [0 0 duv(1) 0 duv(2) duv(3) 0 duv(4) duv(5) 0 duv(6) duv(7)];

%rewrite result vector into xl - form
du = zeros(2,6);
ii = 1;
for j = 1:6
 for i = 1:2
   du(i,j) = duv(ii);
   ii = ii +1;
 end 
end

%% Postprocess
figure1 = figure('Name','Mesh');
%mesh( xl,figure1 );
%nodes( x,figure1 );
for i = 1:nel;
PlotElement( x,ix,i,figure1 );
end
for i = 1:nel;
PlotElement( x+du,ix,i,figure1 );
end

%% Notes
%find(xl==10)
% refsol: ux = 4.3875 uy = -2.3625