function [ temp ] = GetDistancesKNN( vector, training_set )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    m = size(training_set, 1);
    rr = repmat(vector(1:10), [m 1]);
    distances = sqrt(sum(abs(training_set(:,1:10) - rr).^2, 2));
%     distances = sort(distances);
    temp = [training_set distances];
    temp = sortrows(temp,12);

end

