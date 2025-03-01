clc;
clear all ;
close all ;


a1 = linspace(0,1,100);
W = [0.1 0.5 1 2 10];
Colors = hsv(numel(W));

figure (1) 
hold on;
for i = 1:numel(W)
    w = W(i);
    C1 = (1 - a1.^w).^(1/w);    
    plot(a1, C1, 'color', Colors(i,:));
end
xlabel('a1')
ylabel('C1')
title('Sogno Complement Function')
legend(arrayfun(@(x) sprintf('w = %.1f', x), W, 'UniformOutput', false), 'Location', 'best')
hold off;
