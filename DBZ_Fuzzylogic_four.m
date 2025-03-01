clc; 
clear all ;
close all ; 

a = linspace(0,1,100);
landa = -10:0.5:10;
n = length(landa);
C = zeros(n, length(a));

figure
hold on
for i = 1:n
    C(i,:) = (1-a) ./ (1 + landa(i)*a);
    plot(a, C(i,:))
end
xlabel('a')
ylabel('C')
title('Plot of C for Different ?')
hold off
