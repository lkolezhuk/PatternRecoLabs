function [ knn,classification_results_linear, classification_results_quadr, accuracy, accuracy_linear, accuracy_quadr ] = RunCompare(N,P1,knn_k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

mu1 = [-1 1];
Sigma1 = [2.5 1.6; 1.6 2.5];
mu2 = [2.5 2.5];

% % DATA set  

N1 = round(P1 * N);
N2 = N - N1;
DATA1 = mvnrnd(mu1, Sigma1, N1);
DATA2 = mvnrnd(mu2, Sigma1, N2);
one_labels = ones(N1,1);
two_labels = zeros(N2,1);

DATA1l = [DATA1 one_labels];
DATA2l = [DATA2 two_labels];

% complete DATA set
DATA = [DATA1l; DATA2l];

% train sets
[TRAIN_POS, TRAIN_NEG, PROB_POS] = GetTrainingSet(100, DATA);
TRAIN = [TRAIN_POS; TRAIN_NEG];

% disp('Accuracy of the KNN classifier');

% check the performance depending on the n of knn 

    knn = ClassifyKNN(DATA, TRAIN, knn_k);
    accuracy = CheckAccuracy(DATA, knn(:,4));

%     disp('For n');
%     disp(n);
%     disp(accuracy(n));


%     figure;
%     plot(accuracy);
    
    
    
g1 = linearClassifier(DATA(:,1:2), mu1, Sigma1, N1/N);
g2 = linearClassifier(DATA(:,1:2), mu2, Sigma1, 1-N1/N);
g = g1 - g2;


classification_results_linear = zeros(size(DATA,1),1);
for i=1:size(DATA,1)
    if(g(i) > 0) 
        classification_results_linear(i) = 1;
    else
        classification_results_linear(i) = 0;
    end
end
accuracy_linear = CheckAccuracy(DATA, classification_results_linear);
% disp('For linear classifier the accuracy is');
% disp(accuracy_linear);

g1quadr = quadraticClassifier(DATA(:,1:2), mu1, Sigma1, N1/N, 2);
g2quadr = quadraticClassifier(DATA(:,1:2), mu2, Sigma1, N1/N, 2);
gquadr = g1quadr - g2quadr;
% figure;
% stem(gquadr);

classification_results_quadr = zeros(size(DATA,1),1);
for i=1:size(DATA,1)
    if(gquadr(i) > 0) 
        classification_results_quadr(i) = 1;
    else
        classification_results_quadr(i) = 0;
    end
end
accuracy_quadr = CheckAccuracy(DATA, classification_results_quadr);
% disp('For quadratic classifier the accuracy is');
% disp(accuracy_quadr);


end

