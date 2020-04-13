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
tempMark = 0;
tempOrder = ordA(first:last);
for i = 1:length(ordB)
    dest = ordB(i);
    for j = 1:length(tempOrder)
        if dest == tempOrder(j)
            tempMark = 1;
            break
        end
    end
    if tempMark == 0
        tempOrder = [tempOrder,dest];
    end
    tempMark = 0;
end
newOrder = tempOrder;
end

