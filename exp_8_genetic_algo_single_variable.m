function y=fitness(x)
V=20; % Source Voltage
R=5; % Resistance is series
Power=[V*V*x(1)]/[x(1)+R]^2
% Gives the power of the assumed network
y= 1/Power
%fitness= 1/f % As GA provides minimization by default
