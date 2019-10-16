%Question 3

%Defining sigma squared
sigma2 = 1;
%Defining w
w = transpose([1,-0.15,-0.4825,0.144375]);
%Defining gamma squared
gamma2 = [10^-4,10^-3,10^-2,0.05,0.02,10^-1,0.95,0.9,0.85,0.8,0.75,0.7,0.6,0.5,0.4,0.3,0.2,0.15,10^0,2.5,5,7.5,10^1,25,50,75,10^2,500,10^3,10^4];
%Reserve space
errorsq = zeros(30,100);
for g = 1:30
    for i = 1:100
        %Generating the errors
        v = normrnd(0,1,10,1);
        %Generating x (between 1 and -1 from a uniform distribution)
        x = 2*rand(10,1)-1;
        %Finding the realizations of y's
        y = w(1)*x.^3+w(2)*x.^2+w(3)*x+w(4)+v;
        %Finding the predicted w (using the math above)
        wpred = inv(sigma2/gamma2(g)+transpose(x)*x)*transpose(x)*y;
        %Finding the ML estimates
        %wml = inv(transpose(x)*x)*transpose(x)*y;
        %Calculating error squared
        errorsq(g,i) = (transpose(w)*w-transpose(wpred)*wpred)^2;
        %Calculating ML error squared
        %errorsqml(g,i) = (transpose(w)*w-transpose(wml)*wml)^2;
        %Clearing x, y, v and wpred for the next loop
        clear v x y wpred;
    end
end
%Finding minimum, 25th percentile, median, 75th percentile and maximum
%squared errors
sorted = sort(errorsq,2);
errmin = sorted(:,1);
err25 = sorted(:,25);
errmed = sorted(:,50);
err75 = sorted(:,75);
errmax = sorted(:,100);
%{
sortedml = sort(errorsqml,2);
errminml = sortedml(:,1);
err25ml = sortedml(:,25);
errmedml = sortedml(:,50);
err75ml = sortedml(:,75);
errmaxml = sortedml(:,100);
%}
disp('The minimum errors are:')
disp(errmin)
disp('The 25th percentile errors are:')
disp(err25)
disp('The median errors are:')
disp(errmed)
disp('The 75th percentile errors are:')
disp(err75)
disp('The maximum errors are:')
disp(errmax)
%{
disp('The minimum ML errors are:')
disp(errminml)
disp('The 25th percentile ML errors are:')
disp(err25ml)
disp('The median ML errors are:')
disp(errmedml)
disp('The 75th percentile ML errors are:')
disp(err75ml)
disp('The maximum ML errors are:')
disp(errmaxml)
%}

scatter(gamma2,errmin,'ob'), hold on,
set(gca,'xscale','log')
scatter(gamma2,err25,'oc'), hold on,
set(gca,'xscale','log')
scatter(gamma2,errmed,'om'), hold on,
set(gca,'xscale','log')
scatter(gamma2,err75,'or'), hold on,
set(gca,'xscale','log')
scatter(gamma2,errmax,'ok'), hold on,
set(gca,'xscale','log')
legend('Minimum Errors','25th Percentile Errors','Median Errors','75th Percentile Errors','Maximum Errors'), 
title('MAP Estimator Squared Errors with Different Gammas'),
xlabel('gamma'), ylabel('Squared Errors')

%Save graph
saveas(gcf,'Q3.png')

