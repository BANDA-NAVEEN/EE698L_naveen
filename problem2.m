%BANDA NAVEEN-22104061(Assignment-1)
%problem2:Regularized least squares approach.
clc;
clear all;
close all;
w0=-3;w1=2;
a=0;b=1;N=6;
x = sort(a + (b-a).*rand(1,N));%generating the 6 samples in increasuing order of uniformly distributed between 0 and 6 
t=zeros(1,N);
for i=1:N
    n = normrnd(0,sqrt(3));%normal ditribution of mean=0 and variance=3
    t(i)=w0+w1*x(i)+n;%output corresponding to input attribute x 
end
t=t';
x = x';
%% Regularization using different lamda values
X=[ones(length(x),1) x x.^2 x.^3 x.^4 x.^5];%matrix w.r.t data of given
l =[0,1e-6,0.01,0.1];%different lamda values 
for i =1:4% running over for all lamda values
subplot(2,2,i)
plot(x,t,'k*');%data plot
hold on;
What= inv(X'*X+l(i)*N*eye(6))*X'*t;%regularized least squares estimate using each lamda
xnew = (0:0.01:1)';%used to get plot smoothen
Xnew=[ones(length(xnew),1) xnew xnew.^2 xnew.^3 xnew.^4 xnew.^5];
tnew = Xnew*What;%doing this one for not going the curve zig-zag rather than getting smooth
plot(xnew,tnew,'g');
legend('data',['\lambda = ',num2str(l(i))]);
xlabel('x');
ylabel('t');
grid;
end

