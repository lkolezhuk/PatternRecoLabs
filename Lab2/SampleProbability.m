function [ pxi ] = SampleProbability( x, mu, sigma )
%Calculates conditional probability for a sample

[xn, ~] = size(x);
pxi = zeros(1,xn);
for i = 1:xn
    temp = exp(-0.5 * (x(i,1:2)- mu) * inv(sigma) * ( x(i,1:2) - mu)');
    pxi(i) = (0.5*pi*(det(sigma))^0.5)*temp;
end

