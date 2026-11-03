clc; clear; close all;

c = [5000; 8000];
f = @(x) -(c' * x);

A = [2 3; 1 2];
b = [120; 70];
lb = [0; 0];
x0 = [1; 1];

options = optimoptions('fmincon', 'Display', 'off');
[x, fval] = fmincon(f, x0, A, b, [], [], lb, [], [], options);
profit = -fval;

fprintf('Shirts: %.2f\n', x(1));
fprintf('Trousers: %.2f\n', x(2));
fprintf('Max profit: %.0f\n', profit);

x1 = linspace(0, 70, 200);
cloth = (120 - 2*x1) / 3;
labour = (70 - x1) / 2;

xr = linspace(0, 60, 200);
upper = min((120 - 2*xr)/3, (70 - xr)/2);
fill([xr fliplr(xr)], [upper zeros(size(xr))], [0.8 0.9 1]);
hold on;
plot(x1, cloth, 'b-', 'LineWidth', 2);
plot(x1, labour, 'r-', 'LineWidth', 2);
plot(x(1), x(2), 'g*', 'MarkerSize', 12, 'LineWidth', 2);
xlim([0 70]); ylim([0 45]);
xlabel('Shirts (x1)'); ylabel('Trousers (x2)');
title('Production mix optimization');
legend('Feasible region', 'Cloth limit', 'Labour limit', 'Optimum');
grid on;