%BANDA NAVEEN-22104061(Assignment-1)
%problem4: plotting multivirate gaussian and its contour
clc;
clear all;
close all;
%% uncorrelaed gaussian vector
mean_vector1=[2 1];%mean
covarince_matrix1=[1 0;0 1];%covariance
x1=-2:0.1:4;%first axix of pdf
y1=-2:0.1:4;%second axis of pdf
X1= repmat(x1,length(x1),1);%creating meshgrid of taking all labels of x and y
Y1=X1';
Z1=reshape(X1,[],1);%first coordinate of x vector
Z2=reshape(Y1,[],1);%second coordinate of x vector
Z=[Z1 Z2];
fx1=mvnpdf(Z,mean_vector1,covarince_matrix1);%pdf values of multivariate gaussian
fx1=reshape(fx1,length(x1),length(y1));
subplot(2,3,1)
surf(x1,y1,fx1)%3d of multivirate gauusian
xlabel('x1')
ylabel('x2')
zlabel('pdf Fx')
title('3D oF Multivirate gauusain')
subplot(2,3,2)
contour(x1,y1,fx1)%contour of multivirate gauusian
xlabel('x1')
ylabel('x2')
title('contour oF Multivirate gauusain')
subplot(2,3,2)
subplot(2,3,3)
pcolor(x1,y1,fx1)
%% correlaed gaussian vector
mean_vector2=[2 1];
covarince_matrix2=[1 0.8;0.8 1];
x2=-2:0.1:4;
y2=-2:0.1:4;
X2= repmat(x2,length(x2),1);
Y2=X2';
W1=reshape(X2,[],1);
W2=reshape(Y2,[],1);
W=[W1 W2];
fx2=mvnpdf(W,mean_vector2,covarince_matrix2);
fx2=reshape(fx2,length(x2),length(y2));
subplot(2,3,4)
surf(x2,y2,fx2)
xlabel('x1')
ylabel('x2')
zlabel('pdf Fx')
title('3D oF Multivirate gauusain')
subplot(2,3,5)
contour(x2,y2,fx2)
xlabel('x1')
ylabel('x2')
title('contour oF Multivirate gauusain')
subplot(2,3,6)
pcolor(x2,y2,fx2)

