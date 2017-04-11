function [ ] = mesh( xl,figure1 )
%
%  
figure(figure1);

hold on
line12 = line([xl(1,1) xl(1,2)],[xl(2,1) xl(2,2)]);
line23 = line([xl(1,2) xl(1,3)],[xl(2,2) xl(2,3)]);
line34 = line([xl(1,3) xl(1,4)],[xl(2,3) xl(2,4)]);
line41 = line([xl(1,4) xl(1,1)],[xl(2,4) xl(2,1)]);
daspect([1 1 1]);
hold off
end

