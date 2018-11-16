function [ res ] = FindClassificationHeavenPoint( R, FPR_MAX )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i=length(R):-1:1
        if(R(i,1) < FPR_MAX)
            res = i;
            break;
        end
    end
end

