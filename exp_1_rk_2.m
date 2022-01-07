clear all;
clc;
f=@(t,x)1+(x/t); 
x0=input('\n Enter initial value of x i.e. t0: '); 
y0=input('\n Enter initial value of y i.e. x0: '); 
xn=input('\n Enter the final value of t: ');
h=input('\n Enter the step length h: '); 
fprintf('\n x        y ');
count=0;
while x0<=xn
    fprintf('\n%4.3f  %4.3f ',x0,y0); %values of x and y
    k1=h*f(x0,y0); 
    x1=x0+h; 
    k2=h*f(x1,y0+k1);
    y1=y0+(k1+k2)/2;  
    p(count+1)=[x1];
    q(count+1)=[y1];
    count = count + 1;
    x0=x1;
    y0=y1;  
end
plot(p,q,"--*");
title("f(x,y)=y-x^2+1");
xlabel("x");
ylabel("y");

