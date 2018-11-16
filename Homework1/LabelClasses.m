function [ labels ] = LabelClasses( g, thresh, cl1, cl2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
labels = zeros(length(g),1);
    for i = 1:length(g)
        if(g(i) > thresh)
            labels(i) = cl1;
        else labels(i) = cl2;
        end
    end

end

