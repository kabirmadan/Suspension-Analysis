clc; clear all; close all; more off;
theroad = makeroad;                 %% keep this line at the top of your program.
roadlength = 1000;                  %% do NOT change this. The road is only defined for 1km

m = 250;
k = 6000*9.81;
b = 5370;
lambda = 100;

% verify with sin function at speed v = 100
v = 100; % m/s
t = linspace(0,roadlength/v, length(theroad(:,1)));   
x = v*t;
h = 1/3;
sinroad = theroad;
sinroad(:,2) = h * sin(2*pi*theroad(:,1)/lambda);
sinroad(:,3) = (2*pi/lambda) * h * cos(2*pi*theroad(:,1)/lambda);
figure(1); hold on; grid on;
plot(x,y(sinroad,x), LineWidth=1.2);
plot(x,dydx(sinroad, x), '--', LineWidth=1.2);
[t z] = ode45(@(t,z)carrhs(t,z,v,m,b,k, y(sinroad,v*t), v*dydx(sinroad,v*t)),t, [0 0]);
plot(x,z(:,1), LineWidth=1.4)
zsin = booksol(t,x,m,b,k,h,v,lambda);
plot(x, zsin, LineWidth=1.2)
title("Vertification Using Sinusoidal Road Function at v=100 m/s")
legend('Road profile', 'Road Slope', 'Computed Car Height', 'Car Height According to Textbook (known correct)')
saveas(gcf,'sin_verif_1.png')


% verify with sin function at speed v = 10000
v = 10000; % m/s
t = linspace(0,roadlength/v, length(theroad(:,1)));   
x = v*t;
h = 1/3;
figure(2); hold on; grid on;
plot(x,y(sinroad,x), LineWidth=1.2);
plot(x,dydx(sinroad, x), '--', LineWidth=1.2);
[t z] = ode45(@(t,z)carrhs(t,z,v,m,b,k, y(sinroad,v*t), v*dydx(sinroad,v*t)),t, [0 0]);
plot(x,z(:,1), LineWidth=1.4)
zsin = booksol(t,x,m,b,k,h,v,lambda);
plot(x, zsin, LineWidth=1.2)
title("Vertification Using Sinusoidal Road Function at v=10000 m/s")
legend('Road profile', 'Road Slope', 'Computed Car Height', 'Car Height According to Textbook (known correct)')
saveas(gcf,'sin_verif_2.png')

% verify with sin function at speed v = 20
v = 20; % m/s
t = linspace(0,roadlength/v, length(theroad(:,1)));   
x = v*t;
h = 1/3;
lambda = 100;
figure(3); hold on; grid on;
plot(x,y(sinroad,x), LineWidth=1.2);
plot(x,dydx(sinroad, x), '--', LineWidth=1.2);
[t z] = ode45(@(t,z)carrhs(t,z,v,m,b,k, y(sinroad,v*t), v*dydx(sinroad,v*t)),t, [0 0]);
plot(x,z(:,1), LineWidth=1.4)
zsin = booksol(t,x,m,b,k,h,v,lambda);
plot(x, zsin, LineWidth=1.2)
title("Vertification Using Sinusoidal Road Function at v=20 m/s")
legend('Road profile', 'Road Slope', 'Computed Car Height', 'Car Height According to Textbook (known correct)')
saveas(gcf,'sin_verif_3.png')


%%% you must keep these two functions unmodified in your program
function ret = y(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,2),x);
end

function ret = dydx(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,3),x);
end

function xdot = carrhs(t, z, v, m, b, k, yt, dydxt)
    xdot = [z(2); (b/m)*(dydxt-z(2))+(k/m)*(yt-z(1))];
end

function xp = booksol(t,x,m,b,k,h,v, lambda)
    w = 2 * pi * v / lambda;
    wn = sqrt(k/m);
    zeta = b / (2 * sqrt(k*m));
    r = w/wn;
    psi = atan2(-2 * zeta * r, 1-r^2);
    phi = atan2(- lambda * k, 2*pi*v*b);
    xp = h * sqrt((1+ (2 * zeta * r).^2) / (((1-r^2).^2) + (2 * zeta * r).^2 )) * cos((w * t)+ psi + phi);
end
    



