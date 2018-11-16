function [ res ] = GetGaussianPDF( sigma, mu, x )
    %UNTITLED4 Summary of this function goes here
    %   Detailed explanation goes here
    res = zeros(length(x),1);
    for i = 1:length(x)
        res(i) = (1/sqrt(2*pi*(sigma^2)))*exp(-(x(i)-mu)^2/(2*sigma^2));
    end


end

