clc;
close all;
clear all;
f = @(x) -x*x + 2*x - 1;
a = 0.1; b = 1.95;
L = b-a; n = 5;
fib(1) = 1;
fib(2)= 1;
for i=3:n+1
    fib(i) = fib(i-1) + fib(i-2);
end
count = 2;
syms Lk; 
L = b-a;
while count <= n
    Lk = (fib(n-count+1)*L)/fib(n+1);
    left_bound = f(a+Lk);
    right_bound = f(b-Lk);
    fprintf("a=%d b=%d x1=%d x2=%d f(x1)=%d f(x2)=%d\n", a, b, a+Lk, b-Lk, left_bound, right_bound);
    if left_bound > right_bound
        b = b-Lk;
    elseif left_bound < right_bound
        a = a+Lk;
    else
        a = a+Lk;
        b = b-Lk;
    end
    count = count + 1;
end
syms value;
if abs(f(a) - 0) > abs (f(b) - 0)
    value = f(b);
else
    value = f(a);
end
fprintf("The final point of uncertainity is between the points %d and %d\n", a, b);
fprintf("The maximum value of the function is nearly equal to %d\n", value);