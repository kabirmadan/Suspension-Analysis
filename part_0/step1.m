clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;
w_n = sqrt(k/m);
w = 2 * w_n;

[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50],[0 1]);
plot(t,k*y(:,1), LineWidth=1); hold on;
plot(t,b*y(:,2), LineWidth=1);

title('Displacement and Damper Force as Functions of Time')
xlabel('t')
ylabel('x')
legend('Displacement', 'Damper force', 'Location','southeast')
set(gca, 'fontSize', 13, 'FontName', 'Times')


function xdot = numex2rhs(t,x,m,b,k,w,F)
    xdot = [x(2); -b/m*x(2) - k/m*x(1) + (F*cos(w*t))/m];
end