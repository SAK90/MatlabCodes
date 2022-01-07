syms x
f = @(x) x^3-2*x-5;
a=2;
b=3;
n = input("Enter number of iternations: ");
fprintf("\n");
for i =1:n
            c = [a*f(b)-b*f(a)]/[f(b)-f(a)];
            fprintf("X%d = %d\n", i, c);
            if f(c)>0
                b=c;
            else
                a=c;
            end
end
a=2;
b=3;
p=c;
for i=1:n
            c=[a*f(b)-b*f(a)]/[f(b)-f(a)];
            er(i) = f(c)-f(p);
            if f(c)>0
                b=c;
            else
                a=c;
            end
end
fprintf('Root of the given equation is %f', c)
plot(er)
title('Plot of error')
xlabel('Number of iterations')
ylabel('Error')
grid on;