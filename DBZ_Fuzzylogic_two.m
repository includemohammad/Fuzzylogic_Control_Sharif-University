clc ; 
clear all ; 
close all ; 

tic 
%% Gaussian Distribution with gaussmf function in Matlab 

x = linspace(-10,10,1000);
mu = zeros(10, length(x));
for i = 1:15
    n = randn(1,4);
    mu(i,:) = gaussmf(x, [abs(n(1)), n(2)]);
end

figure
plot(x, mu')
xlabel('x')
ylabel('Membership')
title('Random Gaussian Membership Functions')
%%
toc
