function [ROC, thresholds, AUC] = Evaluate_Classifier_ROC(difference_g, initial_label, labels)

final_label = zeros(length(initial_label),1) - 1;
thresholds = zeros(size(difference_g));
ROC = zeros(length(thresholds),2);

for i = 1:length(difference_g)
    
    thresholds(i,1) = difference_g(i);
    for j = 1:length(difference_g)
        if difference_g(j) >= thresholds(i)
            final_label(j) = labels(1);
        else
            final_label(j) = labels(2);
        end
    end
    
    for k = 1 : size(initial_label,1)
        %FPR
        if(initial_label(k)==labels(2) & final_label(k)==labels(1))
            ROC(i,1) = ROC(i,1) + 1;
        %TPR    
        elseif (initial_label(k)==labels(1) & final_label(k)==labels(1))
            ROC(i,2) = ROC(i,2) + 1;
        end
    end
    ROC(i,1) = ROC(i,1) / size(find(initial_label==labels(2)),1) * 100;
    ROC(i,2) = ROC(i,2) / size(find(initial_label==labels(1)),1) * 100;
    
end

AUC = 1;
end