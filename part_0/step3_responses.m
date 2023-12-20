clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;
w_n = sqrt(k/m);
r = [0.5 1 1.01 2];
omega = r * w_n;

% All responses
figure(1);hold on;
for i=1:4
    w = omega(i);
    [t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 3020],[0 1]);
    plot(t,k*y(:,1), LineWidth=1);
end
xlim([1700 1720])
title('Response For Various \omega Values (unscaled)')
legend({'\omega_1 = 0.3727 (r=0.5)', '\omega_2 = 0.7454 (r=1)', '\omega_3 = 0.7528 (r=1.01)', '\omega_4 = 1.4907 (r=2)'}, 'Location','southeast')

% Plot for displacment AND force applied.
% Displacement is scaled down by the correct value of M
figure(2); grid on; hold on;
title('\omega_1 = 0.3727 (r=0.5)');
w = omega(1);
M = 1.33;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 3020],[0 1]);
plot(t, F*cos(w*t));
plot(t,1/M*k*y(:,1), LineWidth=1);
xlim([1700 1720]);
legend('Force applied', 'Displacement (scaled down by M @ \omega=0.3727)', 'Location','southeast')
xlabel('t');

% Plot for displacment AND force applied.
% Displacement is scaled down by the correct value of M
figure(3); grid on; hold on;
title('\omega_2 = 0.7454 (r=1)');
w = omega(2);
M = 83.85;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 3020],[0 1]);
plot(t, F*cos(w*t));
plot(t,1/M*k*y(:,1), LineWidth=1);
xlim([1700 1720])
legend('Force applied', 'Displacement (scaled down by M @ \omega=0.7454)', 'Location','southeast')
xlabel('t');

% Plot for displacment AND force applied.
% Displacement is scaled down by the correct value of M
figure(4); grid on; hold on;
title('\omega_3 = 0.7528 (r=1.01)');
w = omega(3);
M = 42.57;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 3020],[0 1]);
plot(t, F*cos(w*t));
plot(t,1/M*k*y(:,1), LineWidth=1);
xlim([1700 1720])
legend('Force applied', 'Displacement (scaled down by M @ \omega=0.7528)', 'Location','southeast')
xlabel('t');

% Plot for displacment AND force applied.
% Displacement is scaled down by the correct value of M
figure(5); grid on; hold on;
title('\omega_4 = 1.4907 (r=2)');
w = omega(4);
M = 0.33;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 3020],[0 1]);
plot(t, F*cos(w*t));
plot(t,1/M*k*y(:,1), LineWidth=1);
xlim([1700 1720])
legend('Force applied', 'Displacement (scaled down by M @ \omega=1.4907)', 'Location','southeast')
xlabel('t');
set(gca, 'fontSize', 13, 'FontName', 'Times')

function xdot = numex2rhs(t,x,m,b,k,w,F)
    xdot = [x(2); (-b/m*x(2) - k/m*x(1) + (F*cos(w*t))/m)];
end