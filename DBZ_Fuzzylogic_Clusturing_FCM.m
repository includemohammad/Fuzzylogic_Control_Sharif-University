clc;
clear;
close all;

%% Create Data
n = 400; 
sigma = 1; 

CA = [1 1];
CB = [3 4];
CC = [5 2];

XA = mvnrnd(CA, sigma * eye(2), n);
XB = mvnrnd(CB, sigma * eye(2), n);
XC = mvnrnd(CC, sigma * eye(2), n);
X = [XA; XB; XC]; % This is my Data 



%% Apply K-Means
[IDX_kmeans, C_kmeans] = kmeans(X, 3);

%% Apply FCM
[centers_FCM, U] = fcm(X, 3);

%% Apply Subtractive Clustering (SUBCLUST)
radius = 0.5;  % ????? ???? ???? ?????????
C_subclust = subclust(X, radius);

distances = pdist2(X, C_subclust);
[minDist, ~] = min(distances, [], 2); 
colors = (minDist - min(minDist)) / (max(minDist) - min(minDist));

%% Plot Results
figure;

% (1) Original Data with True Centers
subplot(2,2,1);
hold on;
scatter(XA(:,1), XA(:,2), 40, 'r', 'filled'); 
scatter(XB(:,1), XB(:,2), 40, 'g', 'filled'); 
scatter(XC(:,1), XC(:,2), 40, 'b', 'filled'); 
scatter(CA(1), CA(2), 100, 'r', 'p', 'filled');
scatter(CB(1), CB(2), 100, 'g', 'p', 'filled');
scatter(CC(1), CC(2), 100, 'b', 'p', 'filled');
xlabel('X');
ylabel('Y');
title('Original Data & True Centers');
legend({'Cluster A', 'Cluster B', 'Cluster C', 'Center A', 'Center B', 'Center C'}, 'Location', 'best');
grid on;
hold off;

% (2) K-Means Clustering
subplot(2,2,2);
hold on;
scatter(X(IDX_kmeans==1,1), X(IDX_kmeans==1,2), 40, 'r', 'filled'); 
scatter(X(IDX_kmeans==2,1), X(IDX_kmeans==2,2), 40, 'g', 'filled'); 
scatter(X(IDX_kmeans==3,1), X(IDX_kmeans==3,2), 40, 'b', 'filled'); 
scatter(C_kmeans(:,1), C_kmeans(:,2), 100, 'k', 'x', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
title('K-Means Clustering');
legend({'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster Centers'}, 'Location', 'best');
grid on;
hold off;

% (3) Fuzzy C-Means Clustering
subplot(2,2,3);
hold on;
scatter(X(:,1), X(:,2), 40, max(U)', 'filled'); % ??? ???? ?? ???? ????? ?? ????
scatter(centers_FCM(:,1), centers_FCM(:,2), 100, 'k', 'x', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
title('Fuzzy C-Means Clustering');
legend({'Data Points', 'Cluster Centers'}, 'Location', 'best');
grid on;
hold off;

% (4) Subtractive Clustering (With Gradient Colors)
subplot(2,2,4);
hold on;
scatter(X(:,1), X(:,2), 40, [colors, zeros(size(colors)), 1 - colors], 'filled'); % ??????? ???
scatter(C_subclust(:,1), C_subclust(:,2), 100, 'm', 'p', 'filled');
xlabel('X');
ylabel('Y');
title('Subtractive Clustering (Gradient Color)');
legend({'Data Points', 'Subtractive Cluster Centers'}, 'Location', 'best');
grid on;
hold off;
