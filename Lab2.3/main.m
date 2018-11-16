clear all; close all;

DATA = load('pima-indians-diabetes.data');

[TRAIN_POS, TRAIN_NEG, PROB_POS] = GetTrainingSet(40, DATA);
TRAIN = [TRAIN_POS; TRAIN_NEG];

Sigma = cov(TRAIN(:,1:8));
Sigma_Pos = cov(TRAIN_POS(:,1:8));
Sigma_Neg = cov(TRAIN_NEG(:,1:8));

Mean_Pos = mean(TRAIN_POS(:,1:8));
Mean_Neg = mean(TRAIN_NEG(:,1:8));

g1 = linearClassifier(DATA(:,1:8), Mean_Pos, Sigma, PROB_POS);
g2 = linearClassifier(DATA(:,1:8), Mean_Neg, Sigma, 1 - PROB_POS);
g = g1 - g2;
figure;
stem(g);

temp = [DATA(:,9) g(:)];
[R,a] = EvalRoc(temp, 1, 0);


g1quadr = quadraticClassifier(DATA(:,1:8),Mean_Pos,Sigma_Pos, PROB_POS, 2);
g2quadr = quadraticClassifier(DATA(:,1:8),Mean_Neg,Sigma_Neg, 1-PROB_POS, 2);
gquadr = g1quadr - g2quadr;
figure;
stem(gquadr);

tempq = [DATA(:,9) gquadr(:)];
[Rq,aq] = EvalRoc(tempq, 1, 0);
figure;
plot(R(:,1),R(:,2),'g');

hold on;
plot(Rq(:,1),Rq(:,2),'b');


figure;
% 
for n = 1:2:4
    knn = ClassifyKNN(DATA, TRAIN, n);
    temp = [DATA(:,9) knn(:,10)];
    [R,a] = EvalRoc(temp, 0, 1);
    stem(R);
    hold on;
end
% 
% 
% 
