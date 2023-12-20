clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;
w_n = sqrt(k/m);
w = 2 * w_n;


figure(1); hold on;
[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50000],[0 1]);
plot(t,k*y(:,1), 'k', LineWidth=0.5);


[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50000],[2 3]);
plot(t,k*y(:,1), 'r', LineWidth=0.5);


[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50000],[17 19]);
plot(t,k*y(:,1), 'b', LineWidth=0.5);


[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50000],[-3, -1.3]);
plot(t,k*y(:,1), 'g', LineWidth=0.5);

[t,y]=ode45(@(t,x)numex2rhs(t,x,m,b,k,w,F),[0 50000],[-20, -14]);
plot(t,k*y(:,1), 'm', LineWidth=0.5);


xlim([0 3000])
title('Varying Initial Conditions')
legend({'Normal: x(0)=0, $\dot{x}$(0)=1', 'Small positive: x(0)=2, $\dot{x}$(0)=3', 'Big positive: x(0)=13, $\dot{x}$(0)=18', 'Small negative: x(0)=-3, $\dot{x}$(0)=-1.3', 'Big negative: x(0)=-20, $\dot{x}$(0)=-14'}, 'Location','southeast', 'Interpreter', 'latex')
xlabel('t');
ylabel('x')
set(gca, 'fontSize', 20, 'FontName', 'Times')


% STEADY STATE @ approx. t=1700s, this is where all of the graphs become
% completely overlapping i.e., intiial conditions no longer matter


function xdot = numex2rhs(t,x,m,b,k,w,F)
    xdot = [x(2); -b/m*x(2) - k/m*x(1) + (F*cos(w*t))/m];
end
 
