function [ temp ] = GetDistancesKNN( vector, training_set )
%Determines the distances from the vector in the dataset to the training
%set
    m = size(training_set, 1);
    rr = repmat(vector(1:2), [m 1]);
    distances = sqrt(sum(abs(training_set(:,1:2) - rr).^2, 2));
    temp = [training_set distances];
    temp = sortrows(temp,4);

end

