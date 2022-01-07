clc
clear
format long      
% Define the variables
syms x1 x2;
%Objective function for constraint optimization problem````
func = 170-14*x1-22*x2;
%Constrains :
g1(1) = 26-((x1-5)*(x1-5))-(x2*x2);
g1(2) = 20-4*x1-x2;
%tolerances
eps1 = 0.001;
conv = 1; %initiali ze the convergance criteria
% Initial Guess (Choose Initial Guesses):
i = 1;
x_1(i) = 0.5;
x_2(i) = 3;
rk(1) = 120;
%Convert the constrained problem into unconstrained problem
f = func - rk(1)*(1/g1(1)+1/g1(2));
k = 1;
while conv > eps1
    Grad_f = gradient(f);
    S = -subs(Grad_f,[x1,x2],[x_1(i),x_2(i)]);
    %loop
    while norm(S)> eps1
        %calculate the step length
        syms lambda
        func_lambda = subs(f, [x1,x2], [x_1(i)+S(1)*lambda,x_2(i)+lambda*S(2)]);
        dfunc_lambda = (diff(func_lambda,lambda));
        lambda = vpa(solve(dfunc_lambda==0,lambda),6);
        lambda = lambda(imag(lambda)==0);
        for k = 1:size(lambda)
            fun_lambda_value(k) = subs(f,[x1,x2],[x_1(i)+lambda(k,1)*S(1),x_2(i)+lambda(k,1)*S(2)]);
        end
        [value, index] = min(fun_lambda_value);
        %compute the step length
        lambda = lambda(index);
        %replace the old value with new value for unconstrained
        x_1(i+1) = x_1(i)+lambda*S(1);
        x_2(i+1) = x_2(i)+lambda*S(2);
        Grad_old = subs(Grad_f,[x1,x2],[x_1(i),x_2(i)]);
        i = i+1;
        Grad_new = subs(Grad_f,[x1,x2],[x_1(i),x_2(i)]);
        %update the search direction
        S = -(Grad_new)+((norm(Grad_new))^2/(norm(Grad_old))^2)*S; 
    end
    Phi1 = subs(func,[x1,x2],[x_1(i-1),x_2(i-1)]);
    Phi2 = subs(func,[x1,x2],[x_1(i),x_2(i)]);
    conv = abs(abs(Phi2)-abs(Phi1))/abs(Phi1);
    rk(k+1) = 0.01*rk(k);       %reduce the value of Rk by 0.01 times to reach the near by optimum point
    k= k+1;
end
Iter = 1:i;
K = 1:k;
X_coordinate = x_1';
Y_coordinate = x_2';
Iterations = Iter';
Rk = rk';
for i=1:length(X_coordinate)
    Objective_value(i) = double(subs(f,[x1,x2], [x_1(i),x_2(i)]));
end
Objective_value = Objective_value';
T = table(Iterations,X_coordinate,Y_coordinate, Objective_value);
fprintf('Initial Objective Function Value: %d\n\n',double(subs(f,[x1,x2], [x_1(1),x_2(1)])));
fprintf('Number of Iterations for Convergence: %d\n\n', i);
fprintf('Point of Minima: [%d,%d]\n\n', x_1(i), x_2(i));
fprintf('Objective Function Minimum Value: %d\n\n', double(subs(f,[x1,x2], [x_1(i),x_2(i)])));
%Contour and plotting:
h = figure;
    filename = 'Interior Penalty Method';
    hold on;
    fcontour(func,[-8,8,-8,8],'MeshDensity',100);
    colormap 'jet'
    [x1,x2] = meshgrid(-8:0.05:8);
    Z1 = (2*x1-x2 == 0) ; %first constraint
    Z2= (x1 <= 5);          %2nd constraint
    contour(x1,x2,Z1,'-b','LineWidth',0.5)
    contour(x1,x2,Z2,'-g','LineWidth',0.5)
    for j = 1:i-1
        %update the points on plot from initiial guess to final optimum point
        plot(x_1(j),x_2(j),'Og','LineWidth',2);
        plot(x_1(j+1),x_2(j+1),'Or','LineWidth',2);
        plot(x_1(j:j+1),x_2(j:j+1),'*-k')
        plot(x_1(j+1),x_2(j+1),'*r','LineWidth',2);
        xlabel('x1')
        ylabel('x2')
        title("Interior Penalty method f = (x1-1)^2 + (x2-2)^2");
        annotation('textarrow',[0.683 0.753],[0.254 0.430],'Color','g','String', "x1 <= 5");
        annotation('textarrow',[0.523 0.478],[0.228 0.418],'Color','b', 'String', "2*x1-x2 == 0");
        annotation('textarrow',[0.394 0.395],[0.547 0.65],'Color','r','String', "Optimum Point (x1,x2)  ");
        annotation('textarrow',[0.530 0.533],[0.838 0.690],'Color','g','String', "Initial Point (x1,x2)  ");
    end
disp(T)