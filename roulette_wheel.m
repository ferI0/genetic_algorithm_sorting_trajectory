function [outputArg1] = roulette_wheel(pop,fit)
%Select point
%   Roulette Wheel Function to select a random pop based on
%   fitness values. Second clause with index length to keep output in
%   boundaries.
index = 1;
randNum = rand;
while randNum > 0 && index < length(fit)
    randNum = randNum - fit(index,:);
    index = index + 1;
end
index = index - 1;

outputArg1 = pop(index,:);
end

