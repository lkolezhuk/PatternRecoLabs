clear all;
close all;
mu1 = [-1 1];
Sigma1 = [2.5 1.6; 1.6 2.5];

mu2 = [5 5.5];

q1 = mvnrnd(mu1, Sigma1, 500);
q2 = mvnrnd(mu2, Sigma1, 500);
q = [q1;q2];

plot(q1(:,1), q1(:,2),'+');
hold;
plot(q2(:,1), q2(:,2),'o');


p1 = 5/10;
p2 = 5/10;

rr1 = discriminantFunction(q, mu1, Sigma1, p1);
rr2 = discriminantFunction(q, mu2, Sigma1, p2);

rr = rr1 - rr2;
disp(rr(1));
figure;
plot(rr);

ShowDF()