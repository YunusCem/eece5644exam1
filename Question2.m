%Question 2

%Setting seed (to make my work replicable)
rng(3023)

%Defining the landmark locations (for 4,3,2,1 estimates)
xl = [1,-1,0,0,-1/2,-1/2];
yl = [0,0,1,-1,sqrt(3)/2,-sqrt(3)/2];
%Defining the random point (randomly)
xr = sqrt(2)*rand-1;
yr = sqrt(2)*rand-1;
%Defining measurement noise
n = normrnd(0,0.3,6,1);
%Defining measured distances
for i = 1:6
    r(i) = sqrt((xl(i)-xr)^2+(yl(i)-yr)^2)+n(i);
end
%Defining meshgrid
horizontalGrid = linspace(-2,2,101);
verticalGrid = linspace(-2,2,101);
[h,v] = meshgrid(horizontalGrid,verticalGrid);
MAPEstimate1 = h(:).^2/0.25+v(:).^2/0.25+((r(1)-sqrt((xl(1)-h(:)).^2+(yl(1)-v(:)).^2)).^2)/0.09;
MAPEstimate2 = h(:).^2/0.25+v(:).^2/0.25+((r(1)-sqrt((xl(1)-h(:)).^2+(yl(1)-v(:)).^2)).^2)/0.09+((r(2)-sqrt((xl(2)-h(:)).^2+(yl(2)-v(:)).^2)).^2)/0.09;
MAPEstimate3 = h(:).^2/0.25+v(:).^2/0.25+((r(1)-sqrt((xl(1)-h(:)).^2+(yl(1)-v(:)).^2)).^2)/0.09+((r(5)-sqrt((xl(5)-h(:)).^2+(yl(5)-v(:)).^2)).^2)/0.09+((r(6)-sqrt((xl(6)-h(:)).^2+(yl(6)-v(:)).^2)).^2)/0.09;
MAPEstimate4 = h(:).^2/0.25+v(:).^2/0.25+((r(1)-sqrt((xl(1)-h(:)).^2+(yl(1)-v(:)).^2)).^2)/0.09+((r(2)-sqrt((xl(2)-h(:)).^2+(yl(2)-v(:)).^2)).^2)/0.09+((r(3)-sqrt((xl(3)-h(:)).^2+(yl(3)-v(:)).^2)).^2)/0.09+((r(4)-sqrt((xl(4)-h(:)).^2+(yl(4)-v(:)).^2)).^2)/0.09;
minMAP(1) = min(MAPEstimate1);
minMAP(2) = min(MAPEstimate2);
minMAP(3) = min(MAPEstimate3);
minMAP(4) = min(MAPEstimate4);
maxMAP(1) = max(MAPEstimate1);
maxMAP(2) = max(MAPEstimate2);
maxMAP(3) = max(MAPEstimate3);
maxMAP(4) = max(MAPEstimate4);
MAPGrid1 = reshape(MAPEstimate1,101,101);
MAPGrid2 = reshape(MAPEstimate2,101,101);
MAPGrid3 = reshape(MAPEstimate3,101,101);
MAPGrid4 = reshape(MAPEstimate4,101,101);

%One point
scatter(xl(1),yl(1),'ob'), hold on,
scatter(xr,yr,'+r'), hold on
contour(horizontalGrid,verticalGrid,MAPGrid1,[minMAP(1)*[1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1],0,[0.3,0.6,0.9,1]*maxMAP(1)]); 
legend('Reference Points','Actual Point','MAP Grid'), 
title('MAP Estimator Contour Plots with One Reference Point'),
xlabel('x'), ylabel('y')
hold off

saveas(gcf,'Q21.png')

%Two points
scatter(xl(1:2),yl(1:2),'ob'), hold on,
scatter(xr,yr,'+r'), hold on
contour(horizontalGrid,verticalGrid,MAPGrid2,[minMAP(2)*[1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1],0,[0.3,0.6,0.9,1]*maxMAP(2)]);
legend('Reference Points','Actual Point','MAP Grid'), 
title('MAP Estimator Contour Plots with Two Reference Points'),
xlabel('x'), ylabel('y')
hold off

saveas(gcf,'Q22.png')

%Three points
scatter(xl(1),yl(1),'ob'), hold on,
scatter(xl(5:6),yl(5:6),'ob'), hold on,
scatter(xr,yr,'+r'), hold on
contour(horizontalGrid,verticalGrid,MAPGrid3,[minMAP(3)*[1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1],0,[0.3,0.6,0.9,1]*maxMAP(3)]);
legend('Reference Points','Reference Points','Actual Point','MAP Grid'), 
title('MAP Estimator Contour Plots with Three Reference Points'),
xlabel('x'), ylabel('y')
hold off

saveas(gcf,'Q23.png')

%Four points
scatter(xl(1:4),yl(1:4),'ob'), hold on,
scatter(xr,yr,'+r'), hold on,
contour(horizontalGrid,verticalGrid,MAPGrid4,[minMAP(4)*[1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1],0,[0.3,0.6,0.9,1]*maxMAP(4)]);
legend('Reference Points','Actual Point','MAP Grid'), 
title('MAP Estimator Contour Plots with Four Reference Points'),
xlabel('x'), ylabel('y')
hold off

saveas(gcf,'Q24.png')