clc;
clear;
close all;

%% Generate Data

f=@(x) sin(x);

xmin=0;
xmax=2*pi;
P=40;

x=linspace(xmin,xmax,P)';

y=f(x);

data=[x y];

%% Create FIS

nmf=[30 20];

mftype={'gaussmf','gaussmf'};

fis=CreateFisUsingLookupTable(data,nmf,mftype);

%% Test FIS

% fuzzy(fis);

xx=linspace(xmin,xmax,1000)';

yy=f(xx);

yyhat=evalfis(xx,fis);

ee=yy-yyhat;

figure;

subplot(2,2,[1 2]);
plot(xx,yy,'b');
hold on;
plot(xx,yyhat,'r');
xlabel('x');
ylabel('y');
legend('Target Values','Output Values');

subplot(2,2,3);
plot(xx,ee);
xlabel('x');
ylabel('e');

subplot(2,2,4);
histfit(ee,100);
