% Main File 
clear all
clc
addpath(genpath('Plot'));
addpath(genpath('Solver'));
addpath(genpath('Helper'));
addpath(genpath('Elements'));
%% Computational Domain
inputfile='canti_input.txt';
E = 200; nu = 0.35;
mat = [E nu];
[xlraw,Boundaries,ixraw,Forces] = inout(inputfile);
xl = xlraw(:,3:4)'; %get xl field from recorded data
ix = ixraw(:,4:7); % get ix data from raw
%% Loop over all elements
%% collect element computations
%    [ p,s ] = elmt01( xl,ul,mat );
%% end loop
%% Assembling
%% Apply BoundaryConditions
%natural
% p(3,:)=500;
% p(5,:)=500;
% 
% %essential
% for i = [7 4 2 1];
%  s(i,:)=0; s(:,i)=0;p(i,:)=0;
% end
% 
% for i = [7 4 2 1];
%  s(i,:)=[]; s(:,i)=[];p(i,:)=[];
% end

%% Solve
% [ duv ] = DirectMatrixSolve( p,s );
% duv = [0 0 duv(1) 0 duv(2) duv(3) 0 duv(4)];
% 
% % rewrite result vector into xl - form
% du = zeros(2,4);
% ii = 1;
% for j = 1:4
%   for i = 1:2
%     du(i,j) = duv(ii);
%     ii = ii +1;
%   end 
% end

%% Postprocess
figure1 = figure('Name','Mesh');
for i = 1:1;
PlotElement( xl,ix,i,figure1 );
end
nodes( xl,figure1 );
%dmesh( xl+du,figure1 );

%% Notes
%find(xl==10)