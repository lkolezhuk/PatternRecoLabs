clear all; 
close all;

DATA_RAW = load('hw1data.mat');
DATA = DATA_RAW.Bdata;

training_set_percentage = 75;
Num_iter = 1;
sum_lin_tpr = 0;
sum_quad_tpr = 0;
% knn_n = 100;
for knn_n = 25:3:75
    for i=1:Num_iter
        [training_set_pos, training_set_neg, test_set_pos, test_set_neg, prob_pos] = GetTrainingSet(training_set_percentage * length(DATA) /100, DATA);
        training_set = [training_set_pos; training_set_neg];
        test_set = [test_set_pos; test_set_neg];

         knn = ClassifyKNN(DATA, training_set, knn_n, 0);
         temp = knn(:,[11 13]);
         [R,a] = EvalRoc(temp, -1, 1);
         plot(R(:,2),R(:,1),'g');
         figure;
         plot(R(:,2),R(:,3),'b');
         class_heaven_idx = FindClassificationHeavenPoint(R, 0.1);
         knn_ch = ClassifyKNN(DATA, training_set, knn_n, R(class_heaven_idx,3));
         accuracy = CheckAccuracyByLabels(knn_ch(:,11), knn_ch(:,12));
         disp('For k that equals to ');
         disp(knn_n);
         disp('TPR is');
         disp(accuracy);
    end
end

