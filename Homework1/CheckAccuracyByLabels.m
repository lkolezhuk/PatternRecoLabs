function [ res ] = CheckAccuracyByLabels( ground_truth, acquired )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    true_class_count = 0;
    for i=1:(min(length(ground_truth),length(acquired)))
        if(ground_truth(i) == acquired(i))
            true_class_count  = true_class_count + 1;
        end
        
    end
    res = true_class_count/(min(length(ground_truth),length(acquired)));
end

