function [ class_results] = ClassifyKNN( data, training_set, n , thresh)
%Classifies data samples according to the training set with the n(knn)
%setting
%   Detailed explanation goes here
    if(thresh == 0)
        thresh = round(n/2);
    end
    class_1_label= 1;
    class_2_label = -1;
    class_results = zeros(size(data,1),2);
    for i = 1:size(data, 1)
        distances = GetDistancesKNN(data(i,1:10), training_set);
        
        class_1_count = 0;
        for j=1:n
            if(distances(j,11) == class_1_label)
                class_1_count = class_1_count + 1;
            end
        end
        
        if(class_1_count > thresh)
            class_results(i,1) = class_1_label;
            class_results(i,2) = class_1_count;
        else
            class_results(i,1) = class_2_label;
            class_results(i,2) = -n + class_1_count;
        end
    end
    class_results = [data class_results(:,1:2)];
end

