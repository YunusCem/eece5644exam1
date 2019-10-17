%Question 2

%Setting seed (to make my work replicable)
rng(1881)

%Defining the landmark locations (for 4,3,2,1 estimates)
xl = [1,-1,0,0,-1/2,-1/2];
yl = [0,0,1,-1,sqrt(3)/2,sqrt(3)/2];
%Defining the random point (randomly)
xr = 2*rand-1;
yr = 2*rand-1;
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
for l = 1:4
    MAPEstimate = log(evalGaussian([h(:)';v(:)'],mu(:,2),Sigma(:,:,2)))-log(evalGaussian([h(:)';v(:)'],mu(:,1),Sigma(:,:,1))) - log(gamma);
    minMAP(l) = min(MAPEstimate(l));
    maxMAP(l) = max(MAPEstimate(l));
    MAPGrid(l) = reshape(MAPEstimate(l),101,101);
end
    
%Solving for MAP estimates using 1 point (errors)
%F(1) = ((1-x)(1.0967-sqrt((1-x)^2+(0-y)^2)))/((0.09)sqrt((1-x)^2+(0-y)^2))+x/(0.25); 
%F(2) = ((0-y)(1.0967-sqrt((1-x)^2+(0-y)^2)))/((0.09)sqrt((1-x)^2+(0-y)^2))+y/(0.25);


%One point
figure(1), contour(horizontalGrid,verticalGrid,MAPGrid(1),[minMAP(1)*[0.9,0.6,0.3],0,[0.3,0.6,0.9]*maxMAP(1)]) hold on; 
scatter(xl(1),yl(1),'ob'), hold on,
scatter(xr,yr,'+r'), hold off
%Two points
figure(2), contour(horizontalGrid,verticalGrid,MAPGrid(2),[minMAP(2)*[0.9,0.6,0.3],0,[0.3,0.6,0.9]*maxMAP(2)]) hold on;
scatter(xl(1:2),yl(1:2),'ob'), hold on,
scatter(xr,yr,'+r'), hold off
%Three points
figure(3), contour(horizontalGrid,verticalGrid,MAPGrid(3),[minMAP(3)*[0.9,0.6,0.3],0,[0.3,0.6,0.9]*maxMAP(3)]) hold on; 
scatter(xl(1),yl(1),'ob'), hold on,
scatter(xl(5:6),yl(5:6),'ob'), hold on,
scatter(xr,yr,'+r'), hold off
%Four points
figure(4), contour(horizontalGrid,verticalGrid,MAPGrid(4),[minMAP(4)*[0.9,0.6,0.3],0,[0.3,0.6,0.9]*maxMAP(4)]) hold on; 
scatter(xl(1:4),yl(1:4),'ob'), hold on,
scatter(xr,yr,'+r'), hold off
