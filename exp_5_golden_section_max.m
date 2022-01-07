clc;
close all;
clear all;
f = @(x) -x*x + 2*x - 1;
a = 0.1; b = 1.95;
L = b-a; n = 7;
syms Lk;
gamma = 1.618;
count = 1;
epsilon = 0.05;
L0 = 1.85;
while count <= n
    L = b-a;
    if L < epsilon
        break
    end
    fprintf("a= %d b=%d ", a, b);
    L_star = (1/(gamma).^(1+count))*L0;
    left_bound = f(a+L_star);
    right_bound = f(b-L_star);
    fprintf("x1= %d x2= %d f(x1)= %d f(x2)= %d\n", a+L_star, b-L_star, left_bound, right_bound);
    if left_bound > right_bound
        b = b-L_star; 
    elseif left_bound < right_bound
        a = a+L_star;
    else
        a = a+L_star;
        b = b-L_star; 
    end

    count = count + 1;
end
syms value;
if abs(f(a) - 0) > abs (f(b) - 0)
    value = f(b);
else
    value = f(a);
end
fprintf("The final interval of uncertainity is between the points %d and %d\n", a, b);
fprintf("The maximum value of the function is nearly equal to %d\n", value);