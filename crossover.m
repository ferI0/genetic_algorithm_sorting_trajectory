function [newOrder] = crossover(ordA,ordB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
first = randi([1 length(ordA)-1],1);
last = randi([first+1 length(ordA)],1);
tempOrder = ordA(first:last);
for i = 1:length(ordB)
    dest = ordB(i);
    if ismember(dest,tempOrder) == false
        tempOrder = [tempOrder,dest];
    end
end
newOrder = tempOrder;
end

