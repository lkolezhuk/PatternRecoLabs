clear all;
close all;
clc;
N = 1000; %number of samples in the linspace

sigma1 = sqrt(20/2); % from the Normal distribution formulae, we can find that sigma is this
sigma2 = sqrt(12/2); % from the Normal distribution formulae, we can find that sigma is this
mu1 = 0; % from the given task the mean of the first distribution
mu2 = 6; % from the given task the mean of the second distribution
x = linspace(-mu1 - 4*sigma1 , mu2 + 4*sigma2, N); %generate a linear space to cover all necessary x-axis values to analyse the given distributions
pdf1 = GetGaussianPDF(sigma1, mu1, x); % generate the pdf1 based on given formulae for the presented line space
pdf2 = GetGaussianPDF(sigma2, mu2, x); % generate the pdf2 based on given formulae for the presented line space

% The known prior probablilities.
% In real life problems these can be estimated by the proportions of the
% number of elements in each class. The prior probablilities introduce a
% sort of weight of the pdfs of each class and thus move the decision
% boundary
P1 = 0.2; 
P2 = 0.8;

% calculate the binary discriminant function ( 1 if el is class 1, -1
% otherwise. The transition from 1 to -1 is the decision boundary for the
% classification.
g = discriminantFunction(pdf1, pdf2, P1, P2, x);

figure; 
% plot the two initial pdfs with prior probablilty weights and the discriminant function generated above
plot(x, P1*pdf1, 'g', x, P2*pdf2, 'b', x, g, 'r');
title('Aposteriori probablilities and the decision boundary'); 