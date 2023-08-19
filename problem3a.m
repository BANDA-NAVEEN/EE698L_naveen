%BANDA NAVEEN-22104061(Assignment-1)
%problem3a: 3 fold cross valiladation using first order model 
clc;
clear all;
close all;
load('olympic_data.mat','data');%loading the olympic data from the text
x=data(1:end,1);%data of years 
t=data(1:end,2);%data of winning times to cooresponding years
X=[ones(length(x),1) x];%matrix w.r.t to first order model before estimate
w=zeros(2,3);
avgerror=zeros(1,3);
%% using first two folds to make model and last fold for validation
x1=x(1:18);
X1=[ones(length(x1),1) x1];
w(1:2,1)=(inv((X1')*X1))*(X1')*t(1:18);%esimate of first two folds
t1=X*w(1:2,1);
e1=t1(19:27)-t(19:27);%validation error of last fold data values
avgerror(1)=mean(e1.^2);%avaerage error of validation error
%% second and third fold used to fit the data and first one is for validation
x2=x(10:27);
X2=[ones(length(x2),1) x2];
w(1:2,2)=(inv((X2')*X2))*(X2')*t(10:27);
t2=X*w(1:2,2);
e2=t2(1:9)-t(1:9);%validation error of first fold
avgerror(2)=mean(e2.^2);%avaerage error of validation error
%% first and third fold used to fit the data and second one is for validation
s1=data(1:9,1)';
s2=data(19:27,1)';
x3=[s1 s2]';
s3=data(1:9,2)';
s4=data(19:27,2)';
te=[s3 s4]';
X3=[ones(length(x3),1) x3];
w(1:2,3)=(inv((X3')*X3))*(X3')*te;
t3=X*w(1:2,3);
e3=t3(10:19)-t(10:19);%validation error of second fold
avgerror(3)=mean(e3.^2);%avaerage error of validation error
%% deciding of minimum error and fiiting the data coresponding least avaerage error
[C,I] = min(avgerror);
t_final=X*w(:,I);
plot(x,t,'k.')
hold on;
plot(x,t_final,'b')
grid on;
xlabel('olympic year x')
ylabel('winning times t')
legend('data','linear model')
title('Fiiting data by k fold cross valiladation using first order model ')
