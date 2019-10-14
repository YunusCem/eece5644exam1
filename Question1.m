%Question 1

%Setting seed (to make my work replicable)
rng(1881)

%Mean and covariance of data pdf conditioned on label 1
m(:,1) = [-1;0]; Sigma(:,:,1) = 0.1*[10 -4;-4,5];
%Mean and covariance of data pdf conditioned on label 2
m(:,2) = [1;0]; Sigma(:,:,2) = 0.1*[5 0;0,2]; 
%Mean and covariance of data pdf conditioned on label 3
m(:,3) = [0;1]; Sigma(:,:,3) = 0.1*[1 0;0 1]; 
%Total number of samples
N = 10000;
%Class priors for labels 1, 2 and 3 respectively
p = [0.15,0.35,0.5];
%Generating labels with class priors matrix at the end
label = randsrc(1,N,[1,2,3;0.15,0.35,0.5]);
%Number of samples from each class
Nc = [length(find(label==1)),length(find(label==2)),length(find(label==3))]; 
disp('Number of samples drawn from each label (1, 2, and 3 in that order):')
disp(Nc(1))
disp(Nc(2))
disp(Nc(3))
%Reserve space
x = zeros(2,N); 
%Draw samples from each class pdf
for l = 1:3
    x(:,label==l) = mvnrnd(m(:,l),Sigma(:,:,l),Nc(l))';
end
figure(1), clf,
plot(x(1,label==1),x(2,label==1),'ob'), hold on,
plot(x(1,label==2),x(2,label==2),'+r'), hold on,
plot(x(1,label==3),x(2,label==3),'xg'),axis equal,
legend('Class 1','Class 2','Class 3'), 
title('Data with Real Population/Class Labels'),
xlabel('x_1'), ylabel('x_2'), 

%Save graph
saveas(gcf,'Q1distribution.png')

%Loss values (0-1 for this error minimization)
lambda = [0 1 1;1 0 1;1 1 0]; 
%Threshold/decision determination
g1 = lambda(1,1)*evalGaussian(x,m(:,1),Sigma(:,:,1))*p(1) + lambda(1,2)*evalGaussian(x,m(:,2),Sigma(:,:,2))*p(2) + lambda(1,3)*evalGaussian(x,m(:,3),Sigma(:,:,3))*p(3);
g2 = lambda(2,1)*evalGaussian(x,m(:,1),Sigma(:,:,1))*p(1) + lambda(2,2)*evalGaussian(x,m(:,2),Sigma(:,:,2))*p(2) + lambda(2,3)*evalGaussian(x,m(:,3),Sigma(:,:,3))*p(3);
g3 = lambda(3,1)*evalGaussian(x,m(:,1),Sigma(:,:,1))*p(1) + lambda(3,2)*evalGaussian(x,m(:,2),Sigma(:,:,2))*p(2) + lambda(3,3)*evalGaussian(x,m(:,3),Sigma(:,:,3))*p(3);
decision = zeros(1,N); 
for i = 1:N
    if g1(i)<g2(i) & g1(i)<g3(i)
        decision(i) = 1;
    elseif g2(i)<g1(i) & g2(i)<g3(i)
        decision(i) = 2;
    elseif g3(i)<g1(i) & g3(i)<g2(i)
        decision(i) = 3;
end
end

%Error probabilities
ind11 = find(decision==1 & label==1); n11 = length(ind11); p11 = length(ind11)/Nc(1); 
ind12 = find(decision==1 & label==2); n12 = length(ind12); p12 = length(ind12)/Nc(1);
ind13 = find(decision==1 & label==3); n13 = length(ind13); p13 = length(ind13)/Nc(1);
ind21 = find(decision==2 & label==1); n21 = length(ind21); p21 = length(ind21)/Nc(2); 
ind22 = find(decision==2 & label==2); n22 = length(ind22); p22 = length(ind22)/Nc(2);
ind23 = find(decision==2 & label==3); n23 = length(ind23); p23 = length(ind23)/Nc(2);
ind31 = find(decision==3 & label==1); n31 = length(ind31); p31 = length(ind31)/Nc(3); 
ind32 = find(decision==3 & label==2); n32 = length(ind32); p32 = length(ind32)/Nc(3);
ind33 = find(decision==3 & label==3); n33 = length(ind33); p33 = length(ind33)/Nc(3);

%Confusion matrix
errmat = [n11 n12 n13; n21 n22 n23; n31 n32 n33];
disp('The confusion matrix is:')
disp(errmat)

%Total number of errors and probability of errors
disp('The total number of errors is:')
disp(n12+n13+n21+n23+n31+n32)
disp('The rate of error is:')
disp((n12+n13+n21+n23+n31+n32)/N)

%Class 1 gets a 'o', class 2 gets a  '+' and class 3 gets a 'x'
%Blue for predictions of class 1, red for predictions of class 2, green for
%predictions of class 3
figure(2), 
plot(x(1,ind11),x(2,ind11),'ob'); hold on,
plot(x(1,ind12),x(2,ind12),'+b'); hold on,
plot(x(1,ind13),x(2,ind13),'xb'); hold on,
plot(x(1,ind21),x(2,ind21),'or'); hold on,
plot(x(1,ind22),x(2,ind22),'+r'); hold on,
plot(x(1,ind23),x(2,ind23),'xr'); hold on,
plot(x(1,ind31),x(2,ind31),'og'); hold on,
plot(x(1,ind32),x(2,ind32),'+g'); hold on,
plot(x(1,ind33),x(2,ind33),'xg'); hold on,
axis equal,

lgd = legend({'True Label 1 & Decision 1 (Correct)','True Label 2 & Decision 1 (Incorrect)','True Label 3 & Decision 1 (Incorrect)', 'True Label 1 & Decision 2 (Incorrect)', 'True Label 2 & Decision 2 (Correct)', 'True Label 3 & Decision 2 (Incorrect)', 'True Label 1 & Decision 3 (Incorrect)', 'True Label 2 & Decision 3 (Incorrect)', 'True Label 3 & Decision 3 (Correct)'}, 'Location', 'southwest'), 
lgd.FontSize = 5
title('Data with Real Population/Class Labels and Decisions'),
xlabel('x_1'), ylabel('x_2'), 

%Save graph
saveas(gcf,'Q1boundary.png')

%Defining evalGaussian used in script
function g = evalGaussian(x,mu,Sigma)
%Evaluates the Gaussian pdf N(mu,Sigma) at each column of X
[n,N] = size(x);
C = ((2*pi)^n * det(Sigma))^(-1/2);
E = -0.5*sum((x-repmat(mu,1,N)).*(inv(Sigma)*(x-repmat(mu,1,N))),1);
g = C*exp(E);
end