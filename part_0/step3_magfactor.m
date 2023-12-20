clc
clear all

m = 9;
b = 4/50;
k = 5;
F = 2;
w_n = sqrt(k/m);
r = linspace(0,5,30000);
omega = r * w_n;
steady_state = 1000;
z = b/ (2 * sqrt(k*m));

figure(1);grid on; hold on;

plot(r,sqrt(1./((1-r.^2).^2+(2*z*r).^2)), LineWidth=1.3);
legend('\zeta=0.06', 'Location','southeast')
title('Magnification Factor (M) v. Frequency Ratio')
xlabel('\omega / \omega_n');
ylabel('M');
set(gca, 'fontSize', 13, 'FontName', 'Times')