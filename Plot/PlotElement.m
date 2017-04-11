function [  ] = PlotElement( x,ix,elemnumber,figure1 )
%
%   
% nodes are expected to be aligned counter clock wise
% get corner points
pointer = ix(elemnumber,:);
cp = x(:,pointer);

figure(figure1);

hold on
line12 = line([cp(1,1) cp(1,2)],[cp(2,1) cp(2,2)]);
line23 = line([cp(1,2) cp(1,3)],[cp(2,2) cp(2,3)]);
line34 = line([cp(1,3) cp(1,4)],[cp(2,3) cp(2,4)]);
line41 = line([cp(1,4) cp(1,1)],[cp(2,4) cp(2,1)]);
daspect([1 1 1]);
hold off

end

