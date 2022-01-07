clc;
close all;
clear all;
syms x;
f=x-2+log(x); %Enter the Function here
g=diff(f); %The Derivative of the Function
epsilon = 0.0001;
x0 = input('Enter the intial approximation:');
for i=1:100
     f0=eval(subs(f,x,x0)); %Calculating the value of function at x0
     f0_der=eval(subs(g,x,x0)); %Calculating the value of function derivative at x0
     y=x0-f0/f0_der; % The Formula
     fprintf("Number of iteration = %d\tx0 = %d\tf(x0) = %d\n", i, x0, f0);
     err(i)=abs(y-x0);
     if err(i)<epsilon %checking the amount of error at each iteration
        break
     end
     x0=y;
end
fprintf('The Root is : %f \n',y);
fprintf('No. of Iterations : %d\n',i);
plot(err)
title('Plot of error')
xlabel('Number of iterations')
ylabel('Error')
grid on;
