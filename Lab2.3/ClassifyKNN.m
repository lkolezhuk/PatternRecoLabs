function [ class_results] = ClassifyKNN( data, training_set, n )
%Classifies data samples according to the training set with the n(knn)
%setting
%   Detailed explanation goes here
    class_results = zeros(size(data,1),1);
    for i = 1:size(data, 1)
        distances = GetDistancesKNN(data(i,:), training_set);
        class_1_label = distances(1,9);
        class_2_label = distances(1,9);
        class_1_count = 0;
        for j=1:n
            if(distances(j,9) == class_1_label)
                class_1_count = class_1_count + 1;
            else class_2_label = distances(j, 9);
            end

        end
        if(class_1_count > round(n / 2))
            class_results(i) = class_1_label;
        else
            class_results(i) = class_2_label;
        end
    end
    class_results = [data class_results];
end

