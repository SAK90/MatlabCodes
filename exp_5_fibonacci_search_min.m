clc;
close all;
clear all;
f = @(x) 2*pi*x*x + 8/x;
a = 0.5; %initial brackted value
b = 3.5;
L = b-a; % initial length of interval
n = 7; % number of experiments
fib(1) = 1; % we cannot take fib(0)as maltab does not allow zero indexed arrays
fib(2)= 1;
fprintf("%d %d", fib(1), fib(2));
for i=3:n+1
    fib(i) = fib(i-1) + fib(i-2);
    fprintf(" %d", fib(i));
end
fprintf("\n")
count = 2;
syms Lk; 
L = b-a; %initial length of uncertainity
while count <= n
    Lk = (fib(n-count+1)*L)/fib(n+1); % length of search interval
    left_bound = f(a+Lk); % x1 = a+Lk value of function at x1 left_bound
    right_bound = f(b-Lk); % x2 = b-Lk value of function at x2 right_bound
    if left_bound > right_bound % function values compare
        a = a+Lk; % finding the new initial value from a side
    elseif left_bound < right_bound % function values compare
        b = b-Lk; % region on the right of x2 is useless
    else
        a = a+Lk; % finding the new initial value from a side
        b = b-Lk; % finding the new initial value from b side
    end
    count = count + 1; % increment the count i.e. number of experiments
end
fprintf("n = %d\n", n);
fprintf("f(x1) = %d, f(x2) = %d\n", f(a), f(b)); %revised value of the function at the points of new intervals
fprintf("The final point of uncertainity is between the points %d and %d\n", a, b); % final interval