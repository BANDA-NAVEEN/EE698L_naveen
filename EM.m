%BANDA NAVEEN-22104061(Assignment-3)
%problem:Implementing EM-Algorithm for classifying two classes
clc;
clear all;
close all;
%% Generating data for cluster 1
N = 500; % Total number of samples
p_1 = 0.8; % 80% of samples are in cluster 1
mu_1 = [3,3]; % Mean vector for cluster 1
sigma1 = [1,0; 0,2];% Covariance matrix for cluster 1
Cluster_1 = mvnrnd(mu_1,sigma1,p_1*N);% Samples of cluster 1
%% Generating data for cluster 2
p2 = 0.2;  % 20% of samples are in cluster 1
mu_2 = [1,-3]; % Mean vector for cluster 2
sigma2 = [2,0; 0,1];% Covariance matrix for cluster 2
Cluster_2 = mvnrnd(mu_2,sigma2,p2*N);% Samples of cluster 2
Data = [Cluster_1;Cluster_2]; % Total data
%% Initializing & Updating pi_k,u_k,sigma_k,& qn_k
u1 = [0,0];
u2 = [1,1];
pi1 = 0.4;
pi2 = 0.6;
sigma1 = diag([1,2]);% Diagonal covariance matrix for cluster 1
sigma2 = diag([1,1]);% Diagonal covariance matrix for cluster 1
qn1 =0.25*ones(N,1); 
qn2 =0.75*ones(N,1); % since qn1+qn2 = 1
iteration = 20; % Total number of iterations
for j =1:iteration
   
pi1_update = mean(qn1);% New pi1
u1_update = sum(qn1.*Data)/sum(qn1); % New u1
sigma1_update = (qn1.*(Data-u1))'*(Data-u1)/sum(qn1); % New sigma1
pi2_update = mean(qn2);% New pi2
u2_update = sum(qn2.*Data)/sum(qn2); % New u2
sigma2_update = (qn2.*(Data-u2))'*(Data-u2)/sum(qn2); % New sigma2
p_xn_1 = zeros(N,1);
p_xn_2 = zeros(N,1);
    for i =1:N
        p_xn_1(i) = pi1_update/(2*pi*sqrt(det(sigma1_update)))*exp(-0.5*(Data(i,:)-u1_update)*inv(sigma1_update)*(Data(i,:)-u1_update)'); % pi_k*p(xn/u1_k,sigma1_k)
        p_xn_2(i) = pi2_update/(2*pi*sqrt(det(sigma2_update)))*exp(-0.5*(Data(i,:)-u2_update)*inv(sigma2_update)*(Data(i,:)-u2_update)'); % pi_k*p(xn/u2_k,sigma2_k) 
    end
qn1 = p_xn_1./(p_xn_1+p_xn_2); % New qn1
qn2 = p_xn_2./(p_xn_1+p_xn_2); % New qn2
pi1 = pi1_update; % Updating pi1
u1 = u1_update; % Updating u1
sigma1 = sigma1_update; % Updating sigma1
pi2 = pi2_update; % Updating pi2
u2 = u2_update; % Updating u1
sigma2 = sigma2_update; % Updating sigma2
Bound(j) = sum(qn1*log(pi1)+qn2*log(pi2))+sum(qn1.*(log(p_xn_1/pi1))+ qn2.*(log(p_xn_2/pi2)))-sum(qn1.*log(qn1)+ qn2.*log(qn2)); % Lower bound of lokelihood
Likelihood(j) = sum(log(p_xn_1+p_xn_2)); % Likelihood
end
%% Plotting Bound and Likelihood
figure;
plot(Bound);% plot the Lower Bound
hold on;
plot(Likelihood,'--'); % Plot the Likelihood
xlabel('Iteration');
ylabel('Lower Bound');
title('Lower Bound & Likelihood');
legend('Lower Bound','Likelihood');
grid;
%% Contour plot of Multivariate Gaussian with estimated mean and covariance
y = -10:0.1:10; % y axis
x = -4:0.1:10; %  x axis
[X1,X2] = meshgrid(x,y);% 2D grid
X = [X1(:) X2(:)];
P = mvnpdf(X,u1,sigma1);% Multivariate Gaussian pdf with u1 and sigma1
P = reshape(P,length(y),length(x));
figure;
contour(x,y,P); % Contour plot
hold on;
xlabel('x1');
ylabel('x2');
Z = mvnpdf(X,u2,sigma2);% Multivariate Gaussian pdf with u2 and sigma2
Z = reshape(Z,length(y),length(x));
contour(x,y,Z); % Contour plot
title('Modeling 2 clusters with Gaussian pdf');
plot(Cluster_1(:,1),Cluster_1(:,2),'.');% Plotting the data points in cluster 1
hold on;
plot(Cluster_2(:,1),Cluster_2(:,2),'.');% Plotting the data points in cluster 2
grid;
