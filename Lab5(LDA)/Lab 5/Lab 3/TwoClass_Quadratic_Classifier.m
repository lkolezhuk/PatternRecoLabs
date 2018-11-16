function [difference_g, class] = TwoClass_Quadratic_Classifier(X, mu, sigma, p, threshold, class_label)

number_of_classes = size(mu, 1);
g = zeros(1, number_of_classes);

for i = 1 : number_of_classes
    g(i) = - 0.5 * ( X - mu(i,:) ) * pinv(sigma{i}) * ( X - mu(i,:) )' + log(p(i));
end

difference_g = g(1) - g(2);
if g > threshold
    class = class_label(1);
else
    class = class_label(2);
end

end