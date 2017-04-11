function [ ] = nodes( xl,figure1 )
%
% get number of nodes
temp1 = size(xl);
non = temp1(2);

figure(figure1);

hold on

% draw points
for i = 1:non
     plot(xl(1,i),xl(2,i),'r.','MarkerSize',20)
end

daspect([1 1 1]);
hold off
end

