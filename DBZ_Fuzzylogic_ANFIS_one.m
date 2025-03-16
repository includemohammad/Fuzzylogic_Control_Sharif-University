clc ; 
clear ;
close all ;


%% Creat Data 
f  = @(x) sin(x) ;
xmin = 0;
xmax = 2*pi;
x = linspace(xmin,xmax,100)';
y = f(x) ;
TrainInput = x;
TrainTarget = y;
TrainData = [TrainInput,TrainTarget];
%% Creat ANFIS 
numMFs = 10;
inmftype = 'gaussmf';
outmftype = 'linear';
fismat = genfis1(TrainData,numMFs,inmftype,outmftype) ;

MaxEpoch =50;
ErrorGoal = 0.001;
Initialstepsize =0.01;
StepsizeDecreaseRate = 0.9; 
StepsizeInecreaseRate = 1.1;
TrainOptions =[MaxEpoch...
               ErrorGoal...
               Initialstepsize ...
               StepsizeDecreaseRate... 
               StepsizeInecreaseRate];
           DisplyInfo = true;
DisplyError = true ;
DisplyStepsize = true;
DisplyResult = true;
DisplyOpstion= [DisplyInfo...
                DisplyError...
                DisplyStepsize...
                DisplyResult];
 OptimizationMethod = 0;
 %0 : back 
 %1 : Hybrid 
fis = anfis(TrainData,fismat,TrainOptions,DisplyOpstion,[],OptimizationMethod) ; 


%% Test ANFIS 

Trainoutput = evalfis(TrainInput,fis); %This is out Data
TrainError = TrainTarget -Trainoutput; %This is Error of Traning in Fuzzy sysytem

TrainMSE = mean(TrainError(:).^2);
TrainRMSE = sqrt(TrainMSE);
figure;

subplot(2,2,[1 2]);
plot(TrainInput,TrainTarget,'b*');
hold on 
plot(TrainInput,Trainoutput,'ro-');
legend('Target','Output');
title ('Train Data');

subplot(2,2,3);
plot(TrainInput,TrainError);
legend('Error');

subplot(2,2,4);
histfit(TrainError);


