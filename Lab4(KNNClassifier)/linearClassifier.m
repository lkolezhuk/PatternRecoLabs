function [ res ] = linearClassifier(x, mu, sigma, p)
% Returns the discriminant function for the linear classifier
[xn, ~] = size(x);

for i = 1:xn
    t(i) = (-0.5 * (x(i, :) - mu) * inv(sigma) * (x(i, :) - mu)') + log (p);
end

res = t;

end

