%BANDA NAVEEN-22104061(Assignment-1)
%problem1:Non-linear response from the linear model.
clc;
clear all;
close all;
w0=1;w1=-2;w2=0.5;
x = sort(-5+ (10).*rand(1,200));%generating the 200 samples in increasuing order of uniformly distributed between -5 and 5  
t=zeros(1,200);
for i=1:200
    n = normrnd(0,1);%normal ditribution of mean=0 and variance=1
    t(i)=w0+w1*x(i)+w2*x(i).^2+n;%output corresponding to input attribute x 
end
plot(x,t,'k.')%generated data 
hold on;
x=x';
t=t';
%% Linear Model
X=[ones(length(x),1) x ];%matrix w.r.t first order polynomial
What=(inv((X')*X))*(X')*t;%least squares estimate of first order polynomial
t1=X*What;%output w.r.t to estimate 
plot(x,t1,'b')
hold on;
%% Quadratic Model
X1=[ones(length(x),1) x x.^2 ];%matrix w.r.t secondd order polynomial
What1=(inv((X1')*X1))*(X1')*t;%least squares estimate of second order polynomial
t2=X1*What1;%output w.r.t to estimate 
plot(x,t2,'m')
hold on;
grid on;
xlabel('x')
ylabel('t')
legend('data','Linear model','Quadratic model')
title('Fiiting the data by using Least squares approach of linear and quadratic model')
