clc;
clear all;
close all;

DATA_RAW = load('hw1data.mat');
DATA = DATA_RAW.Bdata;


training_set_percentage = 75;
Num_iter = 100;
sum_lin_tpr = 0;
sum_quad_tpr = 0;
for i=1:Num_iter
    
    [training_set_pos, training_set_neg, test_set_pos, test_set_neg, prob_pos] = GetTrainingSet(training_set_percentage * length(DATA) /100, DATA);
    training_set = [training_set_pos; training_set_neg];
    test_set = [test_set_pos; test_set_neg];

    Sigma = cov(training_set(:, 1:10));
    Sigma_Pos = cov(training_set_pos(:, 1:10));
    Sigma_Neg = cov(training_set_neg(:, 1:10));

    Mean_Pos = mean(training_set_pos(:, 1:10));
    Mean_Neg = mean(training_set_neg(:, 1:10));

    g1 = linearClassifier(test_set(:,1:10), Mean_Pos, Sigma, prob_pos);
    g2 = linearClassifier(test_set(:,1:10), Mean_Neg, Sigma, 1 - prob_pos);
    g = g1 - g2;
    % figure;
    % stem(g);
    % title('Linear classifier');


    temp = [test_set(:,11) g(:)];
    [R,a] = EvalRoc(temp, 1, -1);

    g1quadr = quadraticClassifier(test_set(:,1:10),Mean_Pos, Sigma_Pos, prob_pos, 2);
    g2quadr = quadraticClassifier(test_set(:,1:10),Mean_Neg, Sigma_Neg, 1 - prob_pos, 2);
    gquadr = g1quadr - g2quadr;
    % figure;
    % stem(gquadr);
    % title('Quadratic classifier');

    tempq = [test_set(:,11) gquadr(:)];
    [Rq,aq] = EvalRoc(tempq, 1, -1);
    
    % figure;
    % plot(R(:,1),R(:,2),'g');

    % hold on;
    % plot(Rq(:,1),Rq(:,2),'b');


    x1 = 0.1;
    tollerance = 0.0001;
    x1_idx_lin = find(R(:, 1) < x1+tollerance & R(:, 1) > x1-tollerance); 
    x1_val_lin = mean(R(x1_idx_lin, 2));
    sum_lin_tpr = sum_lin_tpr + x1_val_lin;


    x1_idx_quad = find(Rq(:, 1) < x1+tollerance & Rq(:, 1) > x1-tollerance); 
    x1_val_quad = mean(Rq(x1_idx_quad, 2));
    sum_quad_tpr = sum_quad_tpr + x1_val_quad;


    % y1 = get(gca, 'ylim');
    % hold on;
    % plot([x1 x1], y1, 'r', 'Linewidth', 1)
    % title('ROC curve for green-linear and blue-quadratic classifier');


end

 disp('Linear classifier TPR at FPR 0.1');
 disp(sum_lin_tpr/Num_iter);
 
 disp('Quadratic classifier TPR at FPR 0.1');
 disp(sum_quad_tpr/Num_iter);
 