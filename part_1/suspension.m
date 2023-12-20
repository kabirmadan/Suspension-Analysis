clc; clear all; close all; more off;
theroad = makeroad;                 %% keep this line at the top of your program.
roadlength = 1000;                  %% do NOT change this. The road is only defined for 1km

m = 250;
k = 6000*9.81;
b = 5370;
v = 100; % m/s
timetodrive1km =  (roadlength/1000) / (v/3600); % seconds
icz = 0;
iczdot = 0;
t = linspace(0,roadlength/v, length(theroad(:,1)));   
x = v*t;

% response plot
figure(1); hold on;
plot(x,y(theroad,x), LineWidth=1.2); hold on; plot(x,dydx(theroad,x), LineWidth=1.2); grid on;
[t z] = ode45(@(t,z)carrhs(t,z,v,m,b,k, y(theroad,v*t), v*dydx(theroad,v*t)),t, [icz iczdot]);
plot(x,z(:,1), LineWidth=1.2)
xlabel('Distance along road, x'); ylabel('Height'); title('Suspension Response')
legend('Road profile', 'Slope', 'Suspension Height')

% calculate max extension and compression
spring_length = z(:,1)-theroad(:,2);
ext = max(spring_length);
comp = min(spring_length);
fprintf('Max spring extenison: %d\n', ext);
fprintf('Max spring compression: %d\n', comp);

% calculate accleration
xd = diff(z(:,1)) / (roadlength / length(theroad(:,1)));
xdd = diff(xd) / (roadlength / length(theroad(:,1)));
max_acc = max(xdd);
fprintf('Max accelration of car body: %d\n', max_acc);

% acceleration plot
figure(2); hold on; grid on;
plot(x, z(:,1), LineWidth=1.2);
plot(x(1:length(xd)), xd, LineWidth=1.2);
plot(x(1:length(xdd)), xdd, LineWidth=1.2);
xlabel('x'); ylabel('y'); title('Height, Velocity, Acceleration')
legend('Road profile', 'Car Height', 'Car Acceleration')

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