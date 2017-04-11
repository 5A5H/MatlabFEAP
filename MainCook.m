% Main File for Cook
clear all
clc
addpath(genpath('Plot'));
addpath(genpath('Solver'));
addpath(genpath('Helper'));
addpath(genpath('Elements'));

%% Computational Domain
E = 200; nu = 0.35;
x = [ 0  0; 48 44; 48 60; 0 44;24 22; 48 52; 24 52; 0 22 ; 24 37]';
ix = [1 5 9 8 ; 9 5 2 6  ; 9 6 3 7 ; 8 9 7 4 ];
mat = [E nu];
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
    localnodes = ix(currentelement,:)
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
%p(3,:)=500;
%p(5,:)=500;

%essential
%for i = [7 4 2 1];
% s(i,:)=0; s(:,i)=0;p(i,:)=0;
%end

%for i = [7 4 2 1];
% s(i,:)=[]; s(:,i)=[];p(i,:)=[];
%end

%% Solve
%[ duv ] = DirectMatrixSolve( p,s );
%duv = [0 0 duv(1) 0 duv(2) duv(3) 0 duv(4)];

%rewrite result vector into xl - form
%du = zeros(2,4);
%ii = 1;
%for j = 1:4
%  for i = 1:2
%    du(i,j) = duv(ii);
%    ii = ii +1;
%  end 
%end

%% Postprocess
figure1 = figure('Name','Mesh');
mesh( xl,figure1 );
nodes( x,figure1 );
for i = 1:4;
PlotElement( x,ix,i,figure1 );
end
dmesh( xl+du,figure1 );

%% Notes
%find(xl==10)