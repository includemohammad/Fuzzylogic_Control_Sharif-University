clc; 
clear all;
close all;

%% fuzzy system 
fisName = ('My first project');
fistype = ('mamdani');
andMethod = ('min');
orMethod = ('max');
impMethod = ('min');
aggMethod = ('max');
defuzzMethod = ('centroid');
fis = newfis(fisName, fistype, andMethod, orMethod, impMethod, aggMethod, defuzzMethod);

%% add variable and function (mf2mf)
fis = addvar(fis, 'input', 'Velocity', [0 150]);
fis = addmf(fis, 'input', 1, 'LS',...
            'gaussmf',mf2mf([0 0 30 50],'trapmf','gaussmf'));
fis = addmf(fis, 'input', 1, 'MS', 'gaussmf', [30 100]);
fis = addmf(fis, 'input', 1, 'HS', 'gaussmf'...
    ,mf2mf([100 130 200 200],'trapmf','gaussmf'));

fis = addvar(fis, 'input', 'Distance', [0 50]);
fis = addmf(fis, 'input', 2, 'SD', 'trapmf', [-inf -inf 0 10]);
fis = addmf(fis, 'input', 2, 'MD', 'gaussmf', [10 25]);
fis = addmf(fis, 'input', 2, 'HD', 'trapmf', [25 30 45 inf inf]);

fis = addvar(fis, 'output', 'Acceleration', [-1 1]);
fis = addmf(fis, 'output', 1, 'NB', 'trapmf', [-inf -inf -0.6 -0.2]);
fis = addmf(fis, 'output', 1, 'N', 'trimf', [-0.6 -0.2 0]);
fis = addmf(fis, 'output', 1, 'ZR', 'gaussmf', [-0.5  0.5]);
fis = addmf(fis, 'output', 1, 'P', 'trimf', [0.5 0.75 1]);
fis = addmf(fis, 'output', 1, 'BP', 'trapmf', [0.95 1 inf inf]);

%% add Rule 
Rule = [1 1 3 1 1;
        1 2 4 1 1;
        1 3 5 1 1;
        2 1 2 1 1;
        2 2 3 1 1;
        2 3 4 1 1;
        3 1 1 1 1;
        3 2 2 1 1;
        3 3 3 1 1];
fis = addrule(fis, Rule);


figure;
subplot(3,1,1); plotmf(fis, 'input', 1); title('Velocity Membership Functions');
subplot(3,1,2); plotmf(fis, 'input', 2); title('Distance Membership Functions');
subplot(3,1,3); plotmf(fis, 'output', 1); title('Acceleration Membership Functions');

figure;
plotfis(fis); title('Fuzzy Inference System Structure');

figure;
gensurf(fis); title('Surface Viewer');

%% plots for Acceleration 
Distance = 10; 
Velocity = linspace(0, 140, 1000); 
Acceleration = zeros(size(Velocity)); 
for i = 1:numel(Velocity)
    Acceleration(i) = evalfis([Velocity(i), Distance], fis); 
end
%% below figure but differnt method for ploting 
Distance = 20;
Velocity = linspace(0, 140, 1000)';
inputs = [Velocity Distance*ones(size(Velocity))];
figure (5)
Acceleration2 = evalfis(inputs,fis);
plot(Velocity,Acceleration2)


%% plots 
figure;
plot(Velocity, Acceleration, 'b', 'LineWidth', 2);
xlabel('Velocity');
ylabel('Acceleration');
title('Fuzzy System Response');
grid on;
