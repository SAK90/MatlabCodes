function y1=ha_ga2(x)
V=1000; % Voltage
PF=0.8; % Power Factor
R=5; %Resistance7
I=x(1); %Load current
CONST_LOSS=x(2); % Core losses
efficiency = (V*I*PF)/[V*I*PF + I*I*R + CONST_LOSS]
 % Formula of Transformer Efficiency
y1=1/efficiency % Optimising the fitness (Efficiency)