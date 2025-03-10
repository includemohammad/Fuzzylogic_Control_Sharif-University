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
nData=size(Inputs,1);

pTrain=0.7;
nTrain=round(pTrain*nData);
TrainInputs=Inputs(1:nTrain,:);
TrainTargets=Targets(1:nTrain);

pTest=1-pTrain;
nTest=nData-nTrain;
TestInputs=Inputs(nTrain+1:end,:);
TestTargets=Targets(nTrain+1:end);


%% Create FIS

nmf=[3 3 3 3 3];

fis=CreateFisUsingLookupTable([TrainInputs TrainTargets],nmf);

%% Test FIS

Outputs=evalfis(Inputs,fis);
Outputs=(Outputs-min(Outputs))/(max(Outputs)-min(Outputs));
Outputs=min(Targets)+(max(Targets)-min(Targets))*Outputs;

Errors=Targets-Outputs;

TrainOutputs=Outputs(1:nTrain);
TrainErrors=Errors(1:nTrain);

TestOutputs=Outputs(nTrain+1:end);
TestErrors=Errors(nTrain+1:end);

figure;
PlotResults(TrainTargets,TrainOutputs,'Train Data');

figure;
PlotResults(TestTargets,TestOutputs,'Test Data');

figure;
PlotResults(Targets,Outputs,'All Data');

figure;
plotregression(TrainTargets,TrainOutputs,'Train Data',...
               TestTargets,TestOutputs,'Test Data',...
               Targets,Outputs,'All Data');
           
set(gcf,'Toolbar','figure');
