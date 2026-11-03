clc; clear; close all;

area = @(x) pi*x(1)^2 + 2*pi*x(1)*x(2);

x0 = [1; 1];
lb = [0.1; 0.1];
ub = [3; 3];

options = optimoptions('fmincon', 'Display', 'off');
[x, fval] = fmincon(area, x0, [], [], [], [], lb, ub, @volcon, options);

fprintf('Radius: %.4f m\n', x(1));
fprintf('Height: %.4f m\n', x(2));
fprintf('Minimum sheet area: %.4f m^2\n', fval);

r = linspace(0.3, 2, 200);
h = 2 ./ (pi * r.^2);
[R, H] = meshgrid(linspace(0.3, 2, 100), linspace(0.3, 3, 100));
Aarea = pi*R.^2 + 2*pi*R.*H;

subplot(1, 2, 1);
contour(R, H, Aarea, 20);
hold on;
plot(r, h, 'r-', 'LineWidth', 2);
plot(x(1), x(2), 'k*', 'MarkerSize', 12, 'LineWidth', 2);
ylim([0.3 3]);
xlabel('Radius r (m)'); ylabel('Height h (m)');
title('Area contours and volume constraint');
legend('Area contours', 'Volume = 2 m^3', 'Optimum');
grid on;

subplot(1, 2, 2);
Aline = pi*r.^2 + 2*pi*r.*h;
plot(r, Aline, 'b-', 'LineWidth', 2);
hold on;
plot(x(1), fval, 'k*', 'MarkerSize', 12, 'LineWidth', 2);
xlabel('Radius r (m)'); ylabel('Sheet area (m^2)');
title('Area along the constraint');
grid on;

function [c, ceq] = volcon(x)
    c = [];
    ceq = pi*x(1)^2*x(2) - 2;
end