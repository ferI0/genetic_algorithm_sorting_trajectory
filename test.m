start = [1 1
        2 1
        1 2
        2 2];

target = [4 2
          5 2
          4 1
          5 1];
popSize = 4;      
pos = [1,2,3,4];
iter = 100;
pop = zeros(1,popSize);
lastEntry = 0;
for i = 1:popSize
    entry = pos(randi(length(pos)));
    while(entry == lastEntry)
        entry = pos(randi(length(pos)));
    end
    pop(i) = entry 
    lastEntry = entry
end
cost = 0;
cost = sqrt(start(pop(1),1)^2 + start(pop(1),2)^2)
for j = 1:(popSize - 1)
    cost = cost + sqrt((target(j,1) - start(pop(j),1))^2 + (target(j,2) - start(pop(j),2))^2);
    cost = cost + sqrt((start(pop(j+1)) - target(j,1))^2 + (start(pop(j+1)) - target(j,2))^2);
end
cost = cost + sqrt(target(4,1)^2 + target(4,2)^2)
%%init pop
