clc;
clear all;
close all;


N = 1000; %number of samples in the linspace

sigma1 = 0.3; % from the Normal distribution formulae, we can find that sigma is this
sigma2 = 0.1; % from the Normal distribution formulae, we can find that sigma is this
mu1 = 0; % from the given task the mean of the first distribution
mu2 = 1; % from the given task the mean of the second distribution
x = linspace(-mu1 - 4*max(sigma1,sigma2) , mu2 + 4*max(sigma1,sigma2), N); %generate a linear space to cover all necessary x-axis values to analyse the given distributions
pdf1 = GetGaussianPDF(sigma1, mu1, x); % generate the pdf1 based on given formulae for the presented line space
pdf2 = GetGaussianPDF(sigma2, mu2, x); % generate the pdf2 based on given formulae for the presented line space

% The known prior probablilities.
% In real life problems these can be estimated by the proportions of the
% number of elements in each class. The prior probablilities introduce a
% sort of weight of the pdfs of each class and thus move the decision
% boundary
P1 = 9999/10000; 
P2 = 1/10000;
lambda = [0 1000000
          2000 0];
g = DiscriminantCostFunction(pdf1,pdf2,lambda, P1, P2);

figure; 
% plot the two initial pdfs and the discriminant function generated above
plot(x, pdf1, 'g', x, pdf2, 'b');
title('Probability density functions');
figure;
plot(x, g,'r', x, 0, 'b');
title('Discriminant function');