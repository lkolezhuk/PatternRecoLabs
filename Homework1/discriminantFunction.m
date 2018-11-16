function [ res ] = discriminantFunction(pdf1, pdf2, p1, p2, x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tollerance_null = 0.0001;
t = zeros(length(x), 1);
for i = 1:length(x)
    g(i) = log(pdf1(i)) + log(p1) - log(pdf2(i)) - log(p2);
    if(g(i) < tollerance_null) 
      t(i) = 1;
    else t(i) = -1;
    end
end

res = t;

end

