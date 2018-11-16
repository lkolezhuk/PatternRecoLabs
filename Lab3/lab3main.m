clear all;
close all;

DATA = load('pima-indians-diabetes.data');

[TRAIN_POS, TRAIN_NEG, PROB_POS] = GetTrainingSet(40, DATA);
TRAIN = [TRAIN_POS; TRAIN_NEG];

Sigma = cov(TRAIN(:,1:8));
Sigma_Pos = cov(TRAIN_POS(:,1:8));
Sigma_Neg = cov(TRAIN_NEG(:,1:8));

Mean_Pos = mean(TRAIN_POS(:,1:8));
Mean_Neg = mean(TRAIN_NEG(:,1:8));

g1 = discriminantFunction(DATA(:,1:8), Mean_Pos, Sigma, PROB_POS);
g2 = discriminantFunction(DATA(:,1:8), Mean_Neg, Sigma, 1 - PROB_POS);
g = g1 - g2;
figure;
stem(g);

accuracy_lin = AccuracyCheck(g, DATA(:,9));
disp('Accuracy for the linear classifier');
disp(accuracy_lin);

g1quadr = discriminantFunctionQuadratic(DATA(:,1:8),Mean_Pos,Sigma_Pos, PROB_POS, 2);
g2quadr = discriminantFunctionQuadratic(DATA(:,1:8),Mean_Neg,Sigma_Neg, 1-PROB_POS, 2);
gquadr = g1quadr - g2quadr;
figure;
stem(gquadr);

accuracy_quadr = AccuracyCheck(gquadr, DATA(:,9));
disp('Accuracy for the quadratic classifier');
disp(accuracy_quadr);


