function [ res ] = discriminantFunction(x, mu, sigma, p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[xn, ~] = size(x);

for i = 1:xn
    t(i) = (-0.5 * (x(i, :) - mu) * inv(sigma) * (x(i, :) - mu)') + log (p);
end

res = t;

end

