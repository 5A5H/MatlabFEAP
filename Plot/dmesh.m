function [  ] = dmesh( xl,figure1 )
%
%   
figure(figure1);
hold on
line12 = line([xl(1,1) xl(1,2)],[xl(2,1) xl(2,2)],'Color','red');
line23 = line([xl(1,2) xl(1,3)],[xl(2,2) xl(2,3)],'Color','red');
line34 = line([xl(1,3) xl(1,4)],[xl(2,3) xl(2,4)],'Color','red');
line41 = line([xl(1,4) xl(1,1)],[xl(2,4) xl(2,1)],'Color','red');
%drawnow
daspect([1 1 1])
end