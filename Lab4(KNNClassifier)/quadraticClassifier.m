function PDF = quadraticClassifier (x, Mu, Sigma, P, d)

N = size(x, 1);

for i1 = 1 : N
     PDF(i1) = (-0.5 * ( x(i1, :) - Mu) * inv(Sigma) * ( x(i1, :) - Mu)') - (0.5 * log(det(Sigma))) - ((d/2) * log(2 * pi)) + log(P);
end