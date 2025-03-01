clc;
clear all; 
close all ;


x = linspace(-10,10,1000);
mu = trimf(x,[-2 0 6]);
mu2 = (1-mu); % This is section is ~ Not of mu = trimf(x,[-2 0 6]);
figure (1) 
plot(x,mu);
hold on 
plot(x,mu2)
title('This Trimf Plot ');
xlabel('x');
ylabel('mu(x)');