% ��ά��˹�ֲ����ڲ����ݶ��½���
close all;
clear all;
clc;

% ������˹�ֲ�
mu = [0, 0]; % ��ֵ����
sigma = [3.3, 0.2; -1, 1]; % �������
x = [-3: 0.1 :3];
y = [-3: 0.1 :3];
const = (2*pi*sqrt(det(sigma)))^(-1);
Z = zeros(length(x), length(y));
for ii = 1:length(x)
    for jj = 1:length(y)
        Z(ii, jj) = const * exp(-0.5*([x(ii); y(jj)] - mu')'*inv(sigma)*([x(ii); y(jj)] - mu'));
    end
end
figure; % ������άƽ��ͼ������ͼ
surf(x, y, Z);
figure;
contour(x, y, Z);
hold on;

% �ݶ��������½�����
syms tx ty tz;
tz = const * exp(-0.5*([tx; ty] - mu')'*inv(sigma)*([tx; ty] - mu'));
grad = [diff(tz, tx), diff(tz, ty)]; % ���ݶ�
xold = 1.2;
yold = 2.9; % ��ʼ��λ��
alpha = 10; % ѧϰ������
plot(xold, yold, 'r*');
hold on;
delt = 100; % ÿ���߶�֮���
for n = 1:20
    res = alpha * double(subs(grad, {tx,ty}, {xold, yold}));
    xnew = xold + res(1);
    ynew = xold + res(2);
    plot(xold:(xnew-xold)/100:xnew,yold:(ynew-yold)/100:ynew,'r');
    hold on;
    plot(xnew, ynew, 'r*');
    hold on;
    xold = xnew;
    yold = ynew;
end

