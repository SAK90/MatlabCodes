clc;
clear all;
f=@(t, i) 10000-10000*i;
h = 0.0001;
t0 = 0;
i = 0;
count = 0;
tn = 0.001;
while t0 <= tn
    k1=h*(f(t0, i))
    k2=h*(f((t0+(h/2)),(i+(k1/2))))
    k3=h*(f((t0+(h/2)),(i+(k2/2))))
    k4=h*(f((t0+h),(i+k3)))
    k=(1/6)*(k1+(2*k2)+(2*k3)+k4)
    p(count+1)=[t0];
    q(count+1)=[i];
    t0 = t0 + h;
    count = count + 1;
    i = i + k;
end
[p]
[q]
plot(p,q, "--*")
xlabel("time")
ylabel("current")
legend('variation of i and t')