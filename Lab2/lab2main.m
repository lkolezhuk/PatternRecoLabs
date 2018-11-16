close all; 
clear all;

% test set distribution parameters
mu1 = [-1 1];
sigma = [2.5 1.6; 1.6 2.5];
mu2 = [1.5 1.5];

% cost matrix
lambda = [0 1; 2 0];

% generate a test set
N = 1000;
N1 = 5/10 * N;
N2 = 5/10 * N;
test1 = mvnrnd(mu1, sigma, N1);
test2 = mvnrnd(mu2, sigma, N2);

one_labels = ones(N1,1);
two_labels = zeros(N2,1);

% class 1 objects with labels
test1l = [test1 one_labels];
% class 1 objects with labels
test2l = [test2 two_labels];
% entire test set
test = [test1l; test2l];

% calculate the conditional probabilities for sample set
px1 = SampleProbability(test, mu1, sigma);
px2 = SampleProbability(test, mu2, sigma);

% discriminant cost function
g = DiscriminantCostFunction(px1, px2, lambda, N1/N, N2/N);

figure;
plot(g);

% calculate the rate of true classifications ( TPR + TNR )
% by comparing labels of the class
t_count = 0;
for i = 1:N
    if((g(i)>0) &&(test(i,3) == 1))
        t_count = t_count + 1;
    end
    if((g(i)<0) &&(test(i,3) == 0))
        t_count = t_count + 1;
    end
end
disp('True classifications percentage');
disp(t_count*100/N);
