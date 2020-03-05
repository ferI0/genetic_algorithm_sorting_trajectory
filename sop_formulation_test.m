%% Test of route generation for genetic algorithm
%% FE 2020

%% Mostly manually set start and end positions with random target groups for each seedling
n = 4;
vertices = 2*n+1;
startEnd = [0 0];
seedlings = [1 1 randi([1 2],1),
    1 2 randi([1 2],1),
    2 1 randi([1 2],1),
    2 2 randi([1 2],1)];
target1 = [3 2,
    3 1,
    4 2,
    4 1];

target2 = [5 2,
    5 1,
    6 2,
    6 1];

%% Initialize stuff
currentRecord = 999999;
recordDistance = 999999;
maxIter = 1000;
iterCount = 0;
popSize = 10;
routeMatrix = zeros(popSize, vertices+1, 2);
population = zeros(popSize,n);
for i = 1:popSize
    population(i,:) = randperm(n,n);
end

while iterCount < maxIter
    %% Calculate Fitness
    for i = 1:popSize
        posCount = 2;
        targetCount1 = 1;
        targetCount2 = 1;
        for j = 1:length(population(i,:))
            routeMatrix(i,posCount,:) = seedlings(population(i,j),1:2);
            if seedlings(population(i,j),3) == 1
                routeMatrix(i,posCount+1,:) = target1(targetCount1,:);
                targetCount1 = targetCount1 + 1;
            end
            if seedlings(population(i,j),3) == 2
                routeMatrix(i,posCount+1,:) = target2(targetCount2,:);
                targetCount2 = targetCount2 + 1;
            end
            posCount = posCount + 2;
        end
        %% Calculation of route length
        routeLength = 0;
        for k = 2:vertices
            verticeLength = abs(sqrt(routeMatrix(i,k,1)^2+routeMatrix(i,k,2)^2)...
                - sqrt(routeMatrix(i,k-1,1)^2+routeMatrix(i,k-1,2)^2));
            routeLength = routeLength + verticeLength;
        end
        
        if routeLength < recordDistance
            recordDistance = routeLength;
            bestEver = population(i,:);
        end
        
        if routeLength < currentRecord
            currentRecord = routeLength;
            currentBest = population(i,:);
        end
    end
    
    if routeLength < currentRecord
        currentRecord = routeLength;
        %% Plot route
        figure(1);
        clf(figure(1));
        xlim([0 6]);
        ylim([0 3]);
        grid on;
        for i = 1:vertices
            hold on
            plot(routeMatrix(1,[i, i+1],1), routeMatrix(1,[i, i+1],2))
            hold off
        end
    end
    
    
    %% Increment iter
    iterCount = iterCount+1;
end

