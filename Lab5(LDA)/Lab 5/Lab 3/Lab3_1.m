clc;
clear;
close all;

data = load('pima-indians-diabetes.data');
training_data_percentage = 50;
class_labels = [1,-1];

positive_data = data( find(data(:,end)==1), 1:end);
negative_data = data( find(data(:,end)==0), 1:end);
negative_data(:, end) = ones(size(negative_data, 1), 1) - 2;

training_positive_data = positive_data(1 : floor(length(positive_data) * training_data_percentage / 100 ), :);
training_negative_data = negative_data(1 : floor(length(negative_data) * training_data_percentage / 100 ), :);

mu_positive = mean(training_positive_data(:, 1:end - 1));
mu_negative = mean(training_negative_data(:, 1:end - 1));
mu = [mu_positive; mu_negative];

sigma_positive = cov(training_positive_data(:, 1:end-1));
sigma_negative = cov(training_negative_data(:, 1:end-1));
sigma{1} = sigma_positive;
sigma{2} = sigma_negative;

prior_prob_positive = size(training_positive_data,1) / (size(training_positive_data,1) + size(training_negative_data,1));
prior_prob_negative = size(training_negative_data,1) / (size(training_positive_data,1) + size(training_negative_data,1));
prior_prob = [prior_prob_positive; prior_prob_negative];

test_positive_data = positive_data(floor(length(positive_data) * training_data_percentage / 100 )+1 : end, :);
test_negative_data = negative_data(floor(length(negative_data) * training_data_percentage / 100 )+1 : end, :);

training_data = [training_positive_data ; training_negative_data];
test_data     = [test_positive_data     ; test_negative_data    ];
test_data     = [test_data zeros(size(test_data,1), 1)];

% 8 rows, 1 column
weight_vector_LDA = calculate_weight_LDA(training_data, 1, -1);

g_Quadratic = size(size(test_data, 1),1);
g_LDA = size(size(test_data, 1),1);
for i = 1 : size(test_data, 1)
    [g_Quadratic(i), ~] = TwoClass_Quadratic_Classifier(test_data(i, 1:end-2), mu, sigma, prior_prob, 0, class_labels);
    [g_LDA(i), ~] = TwoClass_LDA(test_data(i, 1:end-2), weight_vector_LDA, 0, class_labels);
end

[ROC_Quadratic, thresholds_Quadratic, AUC_Quadratic] = Evaluate_Classifier_ROC(g_Quadratic, test_data(:,end-1), class_labels);
[ROC_LDA, thresholds_LDA, AUC_LDA] = Evaluate_Classifier_ROC(g_LDA, test_data(:,end-1), class_labels);
figure
hold on
plot(ROC_Quadratic(:,1), ROC_Quadratic(:,2), '.');
plot(ROC_LDA(:,1), ROC_LDA(:,2), '.');
hold off
title('CLASSIFIER COMPARISON');
legend('Quadratic Classifier', 'LDA Classifier');
xlabel('False Positive Rate (FPR)');
ylabel('True Positive Rate (TPR)');

