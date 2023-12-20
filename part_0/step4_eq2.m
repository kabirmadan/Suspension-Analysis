clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;
w_n = sqrt(k/m);
r = [0.5 1 1.01 2];
omega = r * w_n;

figure(1);
hold on;
for i=1:4
    [t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,F),[0 1800],[0 3]);
    plot(t,1/m*(y(:,1)), 'b', LineWidth=2.5);
end
tt = linspace(0,2000,20000);
xx = tt + 2*sin(tt);
plot(tt, xx, 'r', LineWidth = 1)


xlim([1700 1720])
title('Computed vs. Expected x(t) for x(t)= t+2sin(t)', 'Interpreter', 'latex')

legend('Computed', 'Expected', 'Location','southeast')
xlabel('t');
ylabel('x(t)')
set(gca, 'fontSize', 13, 'FontName', 'Times')


function xdot = numex2rhs(t,x,m,b,k,F)
    xdot = [x(2); -b/m*x(2) - k/m*x(1) - 8*sin(t) + 0.008 - 0.016*cos(t) + 5*t];
end