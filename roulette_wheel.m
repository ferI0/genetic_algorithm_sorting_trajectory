function [outputArg1] = roulette_wheel(pop,fit)
%   Roulette Wheel Function to select a random chromosom based on
%   fitness values. Second clause with index length to keep output in
%   boundaries.
index = 1;
randNum = 1/rand;
while randNum > 0 && index < length(fit)
    randNum = randNum - 1/fit(index,:);
    index = index + 1;
end
index = index - 1;

outputArg1 = pop(index,:);
end

