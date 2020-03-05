function [outputArg1] = select_point(pop,fit)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
index = 1;
randNum = rand;
while randNum > 0 && index < length(fit)
    randNum = randNum - fit(index,:);
    index = index + 1;
end
index = index - 1;

outputArg1 = pop(index,:);
end

