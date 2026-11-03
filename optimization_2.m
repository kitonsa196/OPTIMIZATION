clc; clear; close all;

c = [3000; 5000];
f = @(x) c' * x;

A = [-40 -70];
b = -5500;
Aeq = [1 1];
beq = 100;
lb = [0; 0];
x0 = [50; 50];

options = optimoptions('fmincon', 'Display', 'off');
[x, fval] = fmincon(f, x0, A, b, Aeq, beq, lb, [], [], options);

fprintf('Polymer A: %.2f kg\n', x(1));
fprintf('Polymer B: %.2f kg\n', x(2));
fprintf('Minimum cost: %.0f\n', fval);

x1 = linspace(0, 100, 200);
blend = 100 - x1;
strength = (5500 - 40*x1) / 70;
xf = linspace(0, 50, 50);

plot(x1, blend, 'b-', 'LineWidth', 2);
hold on;
plot(x1, strength, 'r-', 'LineWidth', 2);
plot(xf, 100 - xf, 'g-', 'LineWidth', 5);
plot(x(1), x(2), 'k*', 'MarkerSize', 12, 'LineWidth', 2);
xlim([0 100]); ylim([0 100]);
xlabel('Polymer A (kg)'); ylabel('Polymer B (kg)');
title('Polymer blend cost minimization');
legend('Total = 100 kg', 'Strength limit', 'Feasible blends', 'Optimum');
grid on;