function w = calculate_weight_LDA(training_data, positive_label, negative_label)

if nargin < 3
    positive_label=-1;
end
if nargin == 1
    negative_label=1;    
end

% Part the data set in subset P and subset N
training_positive = training_data(find(training_data(:,end)==positive_label),:);
training_negative = training_data(find(training_data(:,end)==negative_label),:);

% % Count P and N
% count_positive = size(training_positive,1);
% count_negative = size(training_negative,1);


% Extract the FVs of the samples in the Training set
training_positive_FV = training_positive(:,1:size(training_positive,2)-1);
training_negative_FV = training_negative(:,1:size(training_negative,2)-1);

% Calculate the mean vector for P and N
mean_positive = mean(training_positive_FV);
mean_negative = mean(training_negative_FV);


% Calculate the covariance matrix for P and N
sigma_positive = cov(training_positive_FV);
sigma_negative = cov(training_negative_FV);


% Calculate the total within class covariance matrix
Sigma_W = sigma_positive + sigma_negative;


% Calculate the vector of the weights
w = pinv(Sigma_W) * (mean_positive'-mean_negative');

end