clc
clear
format long
% Function Definition (Enter your Function here):
syms x;
%Objective function for constraint optimization problem````
func = (x-1)^2;
%Constrains :
g1(1) = 2-x;
g1(2) = x-4;
%tolerances
eps1 = 0.001;
conv = 1; %initialize the convergance criteria
% Initial Guess (Choose Initial Guesses):
i = 1;
rk(1) = 0.001;
q = 2;
k = 1;
%Convert the constrained problem into unconstrained problem
f = func + rk(1)*(g1(1)^q+g1(2)^q);
x_1(k,i) = -2; x_2(k,i) = 2; %lb = lower bound and ub = upper bound
accuracy = 1/100;
N = 6; %maximum number of experiment
gamma = 1.618;
while conv > eps1
    % function for Golden section method
    %loop
    for i = 1:N
        L0 = x_2(k,i)-x_1(k,i);
        L_star = L0/gamma^2;
        x1 = x_1(k,i)+L_star;
        x2 = x_2(k,i)-L_star;
        x_1(k,i) = min(x_1(k,i),x_2(k,i));
        x_2(k,i) = max(x_1(k,i),x_2(k,i));
        if subs(f,[x],[x1])< subs(f,[x],[x2])
            x_2(k,i+1) = x2;
            x_1(k,i+1) =x_1(k,i);
        elseif subs(f,[x],[x2])<subs(f,[x],[x1])
            x_1(k,i+1) =x1;
            x_2(k,i+1) = x_2(k,i);
        else
            break;
        end
    end
    for j=1:i
        Iter(j) = j;
        lower_limit(j) =x_1(k,j);
        upper_limit(j) =x_2(k,j);
        Optimum(j) = (x_1(k,j)+x_2(k,j))/2;
        Optimum_value(j) = vpa((subs(func,[x],[Optimum(j)])),4);
    end
    Iterations = Iter';
    Lower_limit = lower_limit';
    Upper_limit = upper_limit';
    OPtimum = Optimum';
    OPtimum_value = Optimum_value';
    T = table(Iterations,Lower_limit,Upper_limit,OPtimum,OPtimum_value);  
    Phi1 = subs(func,[x],[x_1(end,end-1)]);
    Phi2 = subs(func,[x],[x_2(end,end)]);
    conv = abs(abs(Phi2)-abs(Phi1))/abs(Phi1);
    rk(k+1) = 10*rk(k); %Penalty parameter update for new iteration
    k= k+1;
    x_1(k,i) = x_1(k-1,end);
    x_2(k,i) = x_2(k-1,end);
    disp(T)
end
Lower_limit = vpa(lower_limit,4)
upper_limit = vpa(upper_limit,4) 
Optima = vpa((lower_limit+upper_limit)/2,4)
Objective_value = vpa((subs(f,[x],[Optima])),4)
hold on
x = [-5:0.01:5];
y = [-5:0.001:5];
ylim = [-5:5];
f = @(x) (x-1).^2;
y1 = @(x) (2-x);
y2 = @(x) (x-4);
plot(x,f(x),'color','b');
hold on
plot(x,y1(x),'color','m');
hold on
plot(x,y2(x),'color','g')
hold on
caption = sprintf('y = (x-1)^%d',2);
text('FontWeight','bold','FontSize',12,'String','y = (x-1)^2','Position',[2.85 57.14 1.42],...
    'Color','b');
plot(Optima(end), f(Optima(end)),'r*','MarkerSize',10)
title("Exterior penalty with Golden section method f = (x-1)^2");
annotation('textarrow',[0.58 0.60],[0.35 0.28],'Color','r', 'String', "Optimum Point");
annotation('textarrow',[0.39 0.51],[0.23 0.21],'Color','g', 'String', "2-x <= 0");
annotation('textarrow',[0.37 0.24],[0.57 0.36],'Color','m', 'String', "x-4 <= 0");
annotation('textarrow',[0.35 0.22],[0.64 0.66],'Color','b', 'String', "f = (x-1)^2");
xlim = [-5:5];
ylim = [-5:5];
xlabel('x')
ylabel('Objective Function(x)')
hold off