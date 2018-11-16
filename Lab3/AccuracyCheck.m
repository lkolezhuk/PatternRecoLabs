function [ accuracy ] = AccuracyCheck( discriminantFunction, data_labels )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
accurate_count = 0;
for i = 1:size(data_labels,1)
    if(discriminantFunction(i) > 0 && data_labels(i) == 1)
        accurate_count = accurate_count + 1;
    elseif( discriminantFunction(i) < 0 && data_labels(i) == 0)
        accurate_count =  accurate_count + 1;
    end
end

accuracy = accurate_count / size(data_labels,1);
end

