clear all; close all;

data = load('pima-indians-diabetes.data');
training_data_percentage = 30;
validation_data_percentage = 30;

class_labels = [1,-1];

positive_data = data( find(data(:,end)==1), 1:end);
negative_data = data( find(data(:,end)==0), 1:end);
negative_data(:, end) = ones(size(negative_data, 1), 1) - 2;

training_positive_data = positive_data(1 : floor(length(positive_data) * training_data_percentage / 100 ), :);
training_negative_data = negative_data(1 : floor(length(negative_data) * training_data_percentage / 100 ), :);

validation_positive_data = positive_data(floor(length(positive_data) * training_data_percentage / 100) + 1  : floor(length(positive_data) * (validation_data_percentage + training_data_percentage) / 100 ), :);
validation_negative_data = negative_data(floor(length(negative_data) * training_data_percentage / 100) + 1 : floor(length(negative_data) * (validation_data_percentage + training_data_percentage) / 100 ), :);

test_positive_data = positive_data(floor(length(positive_data) * (validation_data_percentage + training_data_percentage) / 100 ) + 1 : length(positive_data), :);
test_negative_data = negative_data(floor(length(negative_data) * (validation_data_percentage + training_data_percentage) / 100 ) + 1 : length(negative_data), :);

training_set = [training_positive_data;training_negative_data];
test_set = [test_positive_data; test_negative_data];


% Get linear SVM model
SVM_Model = cell(100);
SVM_Classify = cell(100);
for i=1:1:100
    SVM_Model{i} = svmtrain(training_set(:,1:8), training_set(:,9), 'boxconstraint', i/100, 'kernel_function', 'linear');
    SVM_Classify{i} = svmclassify(SVM_Model{i}, test_set(:,1:8));
    conMat = confusionmat(test_set(:,9),SVM_Classify{i});
    acc(i) = (conMat(1,1) + conMat(2,2))/sum(sum(conMat));
%     disp(acc);
end
figure;
plot(acc);
title('Linear SVM accuracy');

% Get quadratic SVM model
SVM_Model = cell(100);
SVM_Classify = cell(100);
for i=1:1:100
    SVM_Model{i} = svmtrain(training_set(:,1:8), training_set(:,9), 'boxconstraint', i/100, 'kernel_function', 'polynomial');
    SVM_Classify{i} = svmclassify(SVM_Model{i}, test_set(:,1:8));
    conMat = confusionmat(test_set(:,9),SVM_Classify{i});
    acc(i) = (conMat(1,1) + conMat(2,2))/sum(sum(conMat));
%     disp(acc);
end
figure;
plot(acc);
title('Polynomial SVM accuracy');
