%BANDA NAVEEN-22104061(Assignment-1)
%problem3b: 3 fold cross valiladation using fourth order model 
clc;
clear all;
close all;
load('olympic_data.mat','data');%loading the olympic data from the text
x=data(1:end,1);%data of years 
t=data(1:end,2);%data of winning times to cooresponding years
X=[ones(length(x),1) x x.^2 x.^3 x.^4];%matrix w.r.t to first order model before estimate
w=zeros(5,3);
avgerror=zeros(1,3);
%% using first two folds to make model and last fold for validation
x1=x(1:18);
X1=[ones(length(x1),1) x1 x1.^2 x1.^3 x1.^4];
w(:,1)=(inv(X1'*X1+0.001*18*eye(5)))*(X1')*t(1:18);
t1=X*w(:,1);
e1=t1(19:27)-t(19:27);
avgerror(1)=mean(e1.^2);% average validation error of last fold data values
%% second and third fold used to fit the data and first one is for validation
x2=x(10:27);
X2=[ones(length(x2),1) x2 x2.^2 x2.^3 x2.^4];
w(1:end,2)=(inv((X2')*X2+0.001*18*eye(5)))*(X2')*t(10:27);
t2=X*w(1:end,2);
e2=t2(1:9)-t(1:9);
avgerror(2)=mean(e2.^2);% average validation error of first fold data values
%% first and third fold used to fit the data and second one is for validation
s1=data(1:9,1)';
s2=data(19:27,1)';
x3=[s1 s2]';
s3=data(1:9,2)';
s4=data(19:27,2)';
te=[s3 s4]';
X3=[ones(length(x3),1) x3 x3.^2 x3.^3 x3.^4];
w(1:end,3)=(inv((X3')*X3+0.00001*18*eye(5)))*(X3')*te;%regularization is used to avoid poor condtion of matrix
t3=X*w(1:end,3);
e3=t3(10:18)-t(10:18);;% average validation error of second fold data values
avgerror(3)=mean(e3.^2);
%% deciding of minimum error and fiiting the data coresponding least avaerage error
[C,I] = min(avgerror);
t_final=X*w(:,I);
plot(x,t,'k.')
hold on;
grid on
plot(x,t_final,'m')
xlabel('olympic year x')
ylabel('winning times t')
legend('data','fourth model')
title('Fiiting data by k fold cross valiladation using fourth order model ')

