clear all;
close all;

N = 1000;

mu1 = [-1 1];
Sigma1 = [2.5 1.6; 1.6 2.5];
mu2 = [2.5 2.5];

for i=10:90
    pos_prob = i/100;
    [knn, lin, quadr, accuracy_knn(i), accuracy_linear(i), accuracy_quadr(i)] = RunCompare(N, pos_prob, 10);
end
figure(1);
subplot(1,3,1);
axis([10 90 0 1])
plot(accuracy_knn);
title('KNN');

subplot(1,3,2);
plot(accuracy_linear);
title('Linear');

subplot(1,3,3);
plot(accuracy_quadr);
title('Quadratic');
% 
% 
% % % DATA set  
N = 1000;
N1 = 4/10 * N;
N2 = 6/10 * N;
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

% % check the performance depending on the n of knn 
for n = 2:1:35
    knn = ClassifyKNN(DATA, TRAIN, n);
    accuracyknn(n) = CheckAccuracy(DATA, knn(:,4));

%     disp('For n');
%     disp(n);
%     disp(accuracy(n));
end
 
     figure;
     plot(accuracyknn);
     title('Accuracy of KNN depending on the k');
     xlabel('k');
     ylabel('Accuracy');
%     
%     
%     
% g1 = linearClassifier(DATA(:,1:2), mu1, Sigma1, N1/N);
% g2 = linearClassifier(DATA(:,1:2), mu2, Sigma1, 1-N1/N);
% g = g1 - g2;
% figure;
% stem(g);
% 
% classification_results_linear = zeros(size(DATA,1),1);
% for i=1:size(DATA,1)
%     if(g(i) > 0) 
%         classification_results_linear(i) = 1;
%     else
%         classification_results_linear(i) = 0;
%     end
% end
% accuracy_linear = CheckAccuracy(DATA, classification_results_linear);
% disp('For linear classifier the accuracy is');
% disp(accuracy_linear);
% 
% g1quadr = quadraticClassifier(DATA(:,1:2), mu1, Sigma1, N1/N, 2);
% g2quadr = quadraticClassifier(DATA(:,1:2), mu2, Sigma1, N1/N, 2);
% gquadr = g1quadr - g2quadr;
% figure;
% stem(gquadr);
% 
% classification_results_quadr = zeros(size(DATA,1),1);
% for i=1:size(DATA,1)
%     if(gquadr(i) > 0) 
%         classification_results_quadr(i) = 1;
%     else
%         classification_results_quadr(i) = 0;
%     end
% end
% accuracy_quadr = CheckAccuracy(DATA, classification_results_quadr);
% disp('For quadratic classifier the accuracy is');
% disp(accuracy_quadr);
