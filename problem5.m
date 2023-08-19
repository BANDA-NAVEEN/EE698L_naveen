%BANDA NAVEEN-22104061(Assignment-1)
%problem5:predictive variance
clc;
clear all;
close all;
N=100;
a=-5;
b=5;
x = sort(a + (b-a).*rand(1,N));%generating the 100 samples in increasuing order of uniformly distributed between -5 and 5
xnew=-5:0.1:5;
t=zeros(1,N);
for i=1:N
    n = normrnd(0,sqrt(300));%normal ditribution of mean=0 and variance=3
    t(i)=1*x(i)-1*x(i).^2+5*x(i).^3+n;%output corresponding to input attribute x 
end
%% Preditive bars for linear model
plot(x,t,'k.')
x=x';
xnew=xnew';%new data samples to generate preditive bars
t=t';
X1=[ones(length(x),1) x];
Y1=[ones(length(xnew),1) xnew];
w1=(inv((X1')*X1))*(X1')*t;
t1=X1*w1;
m1=Y1*w1;%mean of each new oylmpic data or new 
m1=m1';
sigmanew1=zeros(1,length(xnew));
for i=1:length(xnew)
    sigmanew1(i)=Y1(i,:)*inv((X1')*X1)*Y1(i,:)';
end
var_new1= (1/N)*(t'*t - t'*X1*w1);%new variance estimate it is biased one
sigmanew1=var_new1*sigmanew1;% variance or spread of each output of each new data w.r.t mean 
subplot(1,3,1)
plot(x,t,'k.')
hold on;
plot(x,t1,'k')
errorbar(xnew,m1,sigmanew1,'b')%plotting the bars
grid on;
xlabel('x')
ylabel('t')
legend('data','linear model','preditive bars')
title('Preditive bars of linear model')
%% Preditive bars for cubic model
X2=[ones(length(x),1) x x.^2 x.^3];
Y2=[ones(length(xnew),1) xnew xnew.^2 xnew.^3];%new data samples to generate preditive bars
w2=(inv((X2')*X2))*(X2')*t;
t2=X2*w2;
m2=Y2*w2;
m2=m2';%mean of each new oylmpic data or new
sigmanew2=zeros(1,length(xnew));
for i=1:length(xnew)
    sigmanew2(i)=Y2(i,:)*inv((X2')*X2)*Y2(i,:)';
end
var_new2= (1/N)*(t'*t - t'*X2*w2);%new variance estimate it is biased one
sigmanew2=var_new2*sigmanew2;% variance or spread of each output of each new data w.r.t mean
subplot(1,3,2)
plot(x,t,'k.')
hold on;
grid on;
plot(x,t2,'k')
errorbar(xnew,m2,sigmanew2,'g')%plotting the error bars
xlabel('x')
ylabel('t')
legend('data','cubic model','preditive bars')
title('Preditive bars of cubic model')
%% Preditive bars for sixth order model
X3=[ones(length(x),1) x x.^2 x.^3 x.^4 x.^5 x.^6];
Y3=[ones(length(xnew),1) xnew xnew.^2 xnew.^3 xnew.^4 xnew.^5 xnew.^6];
w3=(inv((X3')*X3))*(X3')*t;
t3=X3*w3;
m3=Y3*w3;
m3=m3';%mean of each new oylmpic data or new
sigmanew3=zeros(1,length(xnew));
for i=1:length(xnew)
    sigmanew3(i)=Y3(i,:)*inv((X3')*X3)*Y3(i,:)';
end
var_new3= (1/N)*(t'*t - t'*X3*w3);%new variance estimate it is biased one
sigmanew3=var_new3*sigmanew3;% variance or spread of each output of each new data w.r.t mean
subplot(1,3,3)
plot(x,t,'k.')
hold on;
plot(x,t3,'k')
errorbar(xnew,m3,sigmanew3,'m')%plotting the error bars
grid on;
xlabel('x')
ylabel('t')
legend('data','sixth model','preditive bars')
title('Preditive bars of sixth model')





   


