clc ;
clear all ;
close all ;

mgdata = load ('mgdata.dat');
x = mgdata(:,2);
x0 = x(25:end);
x6 = x(19:end-6);
x12 = x(13:end-12);
x18 = x(7:end-18);
x24 = x(1:end-24);
input= [x24 x18 x12 x6 x0];
target = x0;
%% Creat FIS system 
nmf = [4 4 4 4 4]; 
fis=CreateFisUsingLookupTable([input target],nmf);

outputs = evalfis(input,fis);
outputs = ((outputs -min(outputs))/(max(outputs)-min(outputs)));
outputs = (min(target)+max(target)-min(target))*outputs;
Error = target - outputs; 

figure 
subplot (2,2,[1 2]);
plot(target,'b');
hold on ;
plot (outputs,'r');
legend ('Targets','Outputs');
subplot(2,2,3)
plot(Error);
subplot(2,2,4)
histfit (Error,50);
