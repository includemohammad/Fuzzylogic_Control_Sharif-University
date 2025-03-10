clc;
clear;
close all;

%% Create Data

mgdata=load('mgdata.dat');

x=mgdata(:,2);

x0=x(25:end);
x6=x(19:end-6);
x12=x(13:end-12);
x18=x(7:end-18);
x24=x(1:end-24);

Inputs=[x24 x18 x12 x6];

Targets=x0;

%% Create FIS

nmf=[3 3 3 3 3];

fis=CreateFisUsingLookupTable([Inputs Targets],nmf);

%% Test FIS

Outputs=evalfis(Inputs,fis);

Outputs=(Outputs-min(Outputs))/(max(Outputs)-min(Outputs));

Outputs=min(Targets)+(max(Targets)-min(Targets))*Outputs;

Errors=Targets-Outputs;

figure;

subplot(2,2,[1 2]);
plot(Targets,'b');
hold on;
plot(Outputs,'r');
legend('Targets','Outputs');

subplot(2,2,3);
plot(Errors);

subplot(2,2,4);
histfit(Errors,50);

