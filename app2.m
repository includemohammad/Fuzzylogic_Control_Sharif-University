clc;
clear;
close all;

nData=100;
x1=rand(nData,1);
x2=rand(nData,1);
y=x1+x2;

data=[x1 x2 y];

nmf=[4 3 2];

mftype={'trimf','gaussmf','trimf'};

fis=CreateFisUsingLookupTable(data,nmf,mftype);


