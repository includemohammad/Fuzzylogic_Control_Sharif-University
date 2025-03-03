
clc;
clear all;
close all;

xmin = 0;
xmax = 15;


muA = @(x) max(0, min((x - 0) / (2 - 0), min(1, (4 - x) / (4 - 2))));
muB = @(x) max(0, min((x - 3) / (5 - 3), min(1, (8 - x) / (8 - 5))));

X = linspace(xmin, xmax, 100);

C.X = X;
C.mu = zeros(size(C.X));

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


figure(1);

subplot(3,1,1);
bar(X, arrayfun(muA, X), 'r');
title('A');
xlabel('x');
ylabel('\mu_A(x)');

subplot(3,1,2);
bar(X, arrayfun(muB, X), 'b');
title('B');
xlabel('x');
ylabel('\mu_B(x)');

subplot(3,1,3);
bar(C.X, C.mu, 'g');
title('C = A * B');
xlabel('x');
ylabel('\mu_C(x)');
