clc; clear all; close all; more off;
theroad = makeroad;                 %% keep this line at the top of your program.
roadlength = 1000;                  %% do NOT change this. The road is only defined for 1km

m = 250;
k = 6000*9.81;
b = 5370;
r = linspace(0,50,3000);
zeta = b/(2 * sqrt(k*m));
h = 1/3;
lambda = 100;

figure(1);grid on; hold on;
mag_exp = sqrt((1+ (2 * zeta .* r).^2) ./ (((1-r.^2).^2) + (2 * zeta * r).^2 ));
plot(r,mag_exp, LineWidth=1.3);
legend('\zeta=0.70', 'Location','northeast')
title('Magnification Factor (M) v. Frequency Ratio')
xlabel('\omega / \omega_n');
ylabel('M');
set(gca, 'fontSize', 13, 'FontName', 'Times')
saveas(gcf,'mag_verif.png');

%%% you must keep these two functions unmodified in your program
function ret = y(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,2),x);
end

function ret = dydx(theroad,x)
    ret = interp1(theroad(:,1),theroad(:,3),x);
end