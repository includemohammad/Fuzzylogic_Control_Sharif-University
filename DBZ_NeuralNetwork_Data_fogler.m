clc;
clear all;
close all;
%% Creat Data from fogler Chapter7  Problem D-28 (Third Edition)


X = (1:14)';  


Y1 = [1.33e-7 5.27e-7 0.30e-7 3.78e-7 7.56e-7 10.3e-7 17e-7 38.4e-7 ...
      70.8e-7 194e-7 283e-7 279e-7 306e-7 289e-7]';

Y2 = [2e-7 6.71e-7 1.11e-7 5.72e-7 3.71e-7 8.32e-7 21.1e-7 ...
      37.6e-7 74.2e-7 180e-7 269e-7 237e-7  256e-7 149e-7]';

Y3 = [2e-7 3.78e-7 5.79e-7 0 9.36e-7 6.68e-7 17.6e-7 35.5e-7 66.1e-7 ...
      143e-7 160e-7 170e-7 165e-7 163e-7]';

Y4 = [3e-7 4.16e-7 5.34e-7 7.35e-7 6.01e-7 8.61e-7 10.1e-7 18.8e-7 ...
      28.9e-7 36.2e-7 42.2e-7 44.2e-7 46.9e-7 46.9e-7]';

%% ANFIS 
numMFs = 10;
mfType = 'gaussmf'; 


trainOpt = [100 0 0.01 0.9 1.1];


Y_all = {Y1, Y2, Y3, Y4}; 
anfisModels = cell(1,4);  
Y_pred_all = zeros(14, 4); 

for i = 1:4
    disp(['Training ANFIS model for Y', num2str(i), '...']);
    
    
    data = [X Y_all{i}];

    
    fismat = genfis1(data, numMFs, mfType);
    
    
    anfisModels{i} = anfis(data, fismat, trainOpt);
    
    
    Y_pred_all(:, i) = evalfis(X, anfisModels{i});
    
    disp(['Training complete for Y', num2str(i)]);
end

%% plotting 
figure;
for i = 1:4
    subplot(2,2,i);
    plot(X, Y_all{i}, 'bo-', X, Y_pred_all(:, i), 'r*-');
    title(['ANFIS Prediction for Y', num2str(i)]);
    legend('Real Data', 'ANFIS Prediction');
end
