function [ g ] = DiscriminantCostFunction( P1X, P2X, COST_MATRIX, P1, P2)
%Calculates the discriminant function taking into consideration the cost
%matrix of the classification
[xn,~]= size(P1X);
    g = zeros(1,xn);
    for i = 1:xn
        g(i) = log(P1X(i)/P2X(i)) + log((COST_MATRIX(2,1) - COST_MATRIX(1,1))/(COST_MATRIX(1,2)-COST_MATRIX(2,2)))+ log(P1/P2);
    end
end

