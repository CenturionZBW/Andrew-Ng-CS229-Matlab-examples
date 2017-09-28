close all;
clear all;
clc;

% ѵ��������
rng('default'); %Ĭ��ģʽ��ʹ��ÿ�����ɵ��������������ͬ
N = 200;
X = 10*rand(N, 2) - 5; % ��һ�к͵ڶ��зֱ��Ǻ������������
y = zeros(N, 1) - 1;
y((X(:, 1).^3 + X(:, 1).^2 + X(:, 1) + 1)/20 < X(:, 2)) = 1; % �������Ϸ������ڵı��Ϊ1

% ���ݿ��ӻ�
scatter(X(y == -1, 1), X(y == -1, 2), 'k.');
hold on;
scatter(X(y == 1, 1), X(y == 1, 2), 'g.');
t = -5: 0.01 :5;
plot(t, (t.^3 + t.^2 + t + 1)/20, 'r'); % �ֽ���

% ���ɲ�������
N2 = 200;
X2 = 10*rand(N2, 2) - 5;
y2 = zeros(N2, 1) - 1;
y2((X2(:, 1).^3 + X2(:, 1).^2 + X2(:, 1) + 1)/20 < X2(:, 2)) = 1;

% �����˹�˾���K
sigma = 5;
K = zeros(N, N);
for i = 1:N
    for j= i:N
        t = X(i, :) - X(j, :);
        K(i, j) = exp(-(t * t')/sigma^2);
        K(j, i) = K(i, j);
    end
end

% �����ӦQP�����Ĳ���
H = (y*y').* K;
f = -ones(N, 1);
A = -eye(N);
b = zeros(N, 1);
Aeq = y';
beq = 1;

% �������b*
alpha = quadprog(H, f, A, b, Aeq, beq);
idx = find(abs(alpha) > 1e-4) ; %����֧������
plot(X(idx, 1), X(idx, 2), 'bo');
b = y(idx(1)) - (alpha.*y)'*K(:, idx(1));

% Ԥ�����
K2 = zeros(N, N2);
for i = 1:N2
    t = sum((X - (X2(i, :)'*ones(1, N))').^2, 2);
    K2(:, i) = exp(-t/sigma^2);
end
y_pred = sign((alpha.*y)'*K2 + b)';
sum(y2 == y_pred)/N2 % ���㾫��
