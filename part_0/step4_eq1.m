clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;

figure(1);
hold on;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,F),[0 5000],[2 -20]);
plot(t,1/m*(y(:,1)), 'b', LineWidth=2.5);

tt = linspace(0,2000,20000);
xx = 2*cos(3*tt) - 4*sin(5*tt);
plot(tt, xx, 'r', LineWidth=1)

xlim([1700 1720])
title('Computed vs. Expected x(t) for x(t)=2cos(3t)-4sin(5t)', 'Interpreter', 'latex')
legend('Computed', 'Expected', 'Location','southeast')
xlabel('t')
ylabel('x(t)');
set(gca, 'fontSize', 13, 'FontName', 'Times')


function xdot = numex2rhs(t,x,m,b,k,F)
    xdot = [x(2); -b/m*x(2) - k/m*x(1) - 152*cos(3*t) + 880*sin(5*t)-0.048*sin(3*t) - 0.16*cos(5*t)];
end