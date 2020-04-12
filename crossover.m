function [newOrder] = crossover(ordA,ordB)
%Maximal Preservation Crossover 
%   Selects a sequence from first argument to be kept. Population will be
%   filled with non used elements from second argument.
first = randi([1 length(ordA)-1],1);
last = randi([first+1 length(ordA)],1);
subtourLength = 48;
if last-first > subtourLength
    last = first + subtourLength;
end
tempOrder = ordA(first:last);
for i = 1:length(ordB)
    dest = ordB(i);
    if ismember(dest,tempOrder) == false
        tempOrder = [tempOrder,dest];
    end
end
newOrder = tempOrder;
end

