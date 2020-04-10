function [newOrder] = crossover(ordA,ordB)
%Crossover 
%   Selects a sequence from first argument to be kept. Population will be
%   filled with non used elements from second argument.
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

