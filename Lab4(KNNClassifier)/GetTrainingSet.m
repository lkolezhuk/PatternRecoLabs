function [train_pos, train_neg, prob_pos] = GetTrainingSet(set_size, data)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        
    data_pos = data(find(data(:,3) == 1),:);
    data_neg = data(find(data(:,3) == 0),:);
    
    coef = 0.5;
    
    indexes_pos = randperm(size(data_pos, 1), round(set_size * coef));
    train_pos = data_pos(indexes_pos,:);
    
    indexes_neg = randperm(size(data_neg, 1), set_size - round(set_size * coef));
    train_neg = data_neg(indexes_neg,:);
    
    prob_pos = coef;
    
end

