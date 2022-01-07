%%RK -4
f=@(x,y) 1+(x/y);
h=1;
x=1;
y=1;
count=0;
while x<=2
    k1=h*(f(x,y));
    k2=h*(f((x+(h/2)),(y+(k1/2))));
    k3=h*(f((x+(h/2)),(y+(k2/2))));
    k4=h*(f((x+h),(y+k3)));
    k=(1/6)*(k1+(2*k2)+(2*k3)+k4);
    p(count+1)=[x];
    q(count+1)=[y];
    x=x+0.5;
    count=count+1;
    y=y+k;
end
plot(p,q,"--*")
title("f(x,y)=y-x^2+1")
xlabel("x")
ylabel("y")
legend('variation of y and x')
fprintf("The function that was given is y-(x^2)+1 \n")
[p]
[q]
fprintf("The value of y at x=2 is %d \n",y)
fprintf("The number of times loop is executed %d \n",count-1)