function [ y ] = test( A )
    close all;
    max_fpr = 0.1;
    DATA_RAW = load('hw1data.mat');
    DATA = DATA_RAW.Bdata;
    if (isempty(A))
        A = DATA;
    end
    training_set_percentage = 100;
    knn_n = 50;
    [training_set_pos, training_set_neg, test_set_pos, test_set_neg, prob_pos] = GetTrainingSet(training_set_percentage * length(DATA) /100, DATA);
    training_set = [training_set_pos; training_set_neg];
    test_set = [test_set_pos; test_set_neg];

    knn = ClassifyKNN(A, training_set, knn_n, 0);
    temp = knn(:,[11 13]);
    [R,a] = EvalRoc(temp, -1, 1);
    plot(R(:,2),R(:,1),'g');
    figure;
    plot(R(:,2),R(:,3),'b');

    %We are setting the required top FPR for the classifier
    class_heaven_idx = FindClassificationHeavenPoint(R, max_fpr);
    knn_ch = LabelClasses(knn(:,13), R(class_heaven_idx, 3), 1, -1);
    y = knn_ch
%     accuracy = CheckAccuracyByLabels(DATA(:,11), knn_ch(:));
%     disp('For k that equals to ');
%     disp(knn_n);
%     disp('TPR is');
%     disp(accuracy);
end

