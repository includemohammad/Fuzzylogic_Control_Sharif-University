clc;
clear all;
close all;

xmin = 0;
xmax = 15;

% Define membership functions
muA = @(x) double(x >= 1 & x <= 3);
muB = @(x) double(x >= 4 & x <= 7);

X = linspace(xmin, xmax, 100);

C.X = X;
C.mu = zeros(size(C.X));

% Compute convolution
for i = 1:length(C.X)
    x = C.X(i);
    C.mu(i) = 0;
    for j = 1:length(X)
        x1 = X(j);
        x2 = x - x1; 
        if x2 >= xmin && x2 <= xmax  
            C.mu(i) = C.mu(i) + muA(x1) * muB(x2);
        end
    end
end

% Normalize C.mu for proper visualization
C.mu = C.mu / max(C.mu); 

% Plot membership functions
figure(1);

subplot(3,1,1);
bar(X, arrayfun(muA, X), 'r');
title('A');
xlabel('x');
ylabel('\mu_A(x)');
xlim([0 12]);
ylim([0 1.2]); 
grid on;

subplot(3,1,2);
bar(X, arrayfun(muB, X), 'b');
title('B');
xlabel('x');
ylabel('\mu_B(x)');
xlim([0 12]);
ylim([0 1.2]); 
grid on;

subplot(3,1,3);
bar(C.X, C.mu, 'g');
title('C = A * B');
xlabel('x');
ylabel('\mu_C(x)');
xlim([0 12]);
grid on;
