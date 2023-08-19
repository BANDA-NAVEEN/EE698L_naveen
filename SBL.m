%BANDA NAVEEN-22104061(Assignment-1)
%problem:Applying sparse bayesian learing to estimate sparse vector
%using map esimate of posterior
clc;
clear all;
close all;
%% Dictionary generation
N=20;%rows of dictionary matrix
M=40;%columns of dictionary matrix
phi=normrnd(0,1,[N,M]);%generated dictionary matrix of each element N(0,1)
%% sparse vector generation
D0=7;%no of non zero elements of sparse vector
a=1:1:40;
i=sort(randsample(a,D0));%row position of non zero elements of sparse vector
j=ones(1,D0);%column position of non zero elements of sparse vector
v=normrnd(0,1,[1,D0]);%values of non zero elements of sparse vector in its coressponding row and column position
w = sparse(i,j,v,M,1);%sparse vector generation
%% noise variances
noise_db=[-20 -15 -10 -5 0];%in dbs
noise_values=10.^(noise_db/10);%in normal values
%% SBL alogorithm of estimation of sparse vector(MAP estimate)
for k=1:length(noise_values)%loop for all noise variances
    n=normrnd(0,sqrt(noise_values(1,k)),[N,1]);%AWGN noise added to data
    t=phi*w+n;%generated data using dictionary,sparse vector,noise
    % initial prior assuming
    pr_cov=eye(40);%starting prior covariance matrtix
    beta=1/noise_values(1,k);%staring beta values=corresponding noise variance
    beta_inv=1/beta;
    A=inv(pr_cov);% diagonal matrix of alphas and it is to be updated
    for h=1:100%loop for estimation map value,updating alphas,calucating log(L)-marginal likelihood
        post_cov=inv(beta*phi'*phi+A);%posterior covariance matrix
        post_mean(:,h)=beta*post_cov*phi'*t;%posterior mean vector
        gamma=A*diag(post_cov);%gamma(i)=alpha(i)*posterior covariance matrix(i,i)
        post_mean_square=post_mean(:,h).^2;%(post_mean(i)).^2
        for i=1:length(gamma)%updated values of alphas
            update_alpha(i,h)=(1-gamma(i,1))/post_mean_square(i,1);%updated_alpha=1-gamma(i)/(post_mean(i)).^2
        end
        new_beta_inv=sum((t-phi*post_mean(:,h)).^2)/sum(gamma);%updated_beta=norm(t-phi*map)^2/sum(gammas)
        new_A=diag(update_alpha(:,h));%diagonal matrix with updated alphas
        C=((new_beta_inv*eye(20))+phi*inv(new_A)*phi');%value of matrix C which is in marginal likelihood
        logL(1,h)=-0.5*(log(det(C))+t'*inv(C)*t);%calulation of log of marginal likelihood
        A=new_A;%assiging A with the updated A
        beta=1/new_beta_inv;%assiging beta with the updated beta
    end
    [M(k),I(k)] = max(logL);%taking maximum of log marginal likelihood and its index
    %map estimate approximately equal to sparse vector generated at starting
    wmap(:,k)=post_mean(:,I(k));%taking the map of posterior which maximizies the log(L) with updated hyperparmeters with corresponding index
    NMSE(1,k)=sum((wmap(:,k)-w).^2)/sum(w.^2);%calculating normalized mean square error of map estimate
end
%% plotting the noise-db vs NMSE 
plot(noise_db,NMSE,'r');
grid on;
xlabel('noise variance db');
ylabel('NMSE')
title('normalized mean square error for different noise variances')


