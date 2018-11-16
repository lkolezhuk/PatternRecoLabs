function [g, class] = TwoClass_LDA(X, w, threshold, class_label)

g = w' * X';

if g > threshold
    class = class_label(1);
else
    class = class_label(2);
end

end