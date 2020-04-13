%% Route generation and optimization with genetic algorithm
%% FE 2020
clear all;
%% Mostly manually set start and end positions with random target groups for each seedling
n = 96;  %Number of seedlings
vertices = 2*n+1;
seedlings = zeros(n,3);
target1 = zeros(n,2);
target2 = zeros(n,2);
target3 = zeros(n,2);
target4 = zeros(n,2);
seedCount = 1;
groupLow = 1;
groupHigh = 4;
boxWidth = 12;

%% Define positions of seedlings and target plates. Seedlings get a corresponding 
%   random group
for i = 8:-1:1
    for j = 1:12
        seedlings(seedCount,:,:) = [j+2*boxWidth i randi([groupLow groupHigh],1)];
        target1(seedCount,:) = [j i];
        target2(seedCount,:) = [j+1*boxWidth i];
        target3(seedCount,:) = [j+3*boxWidth i];
        target4(seedCount,:) = [j+4*boxWidth i];
        
        seedCount = seedCount + 1;
    end
end

%% Squares
X1 = 0.6;
X2 = 12.4;
Y1 = 0.5;
Y2 = 8.5;
squareX = zeros(5,5);
squareY = zeros(5,5);
for i = 1:5
    squareX(i,:) = [X1+(i-1)*boxWidth, X2+(i-1)*boxWidth, X2+(i-1)*boxWidth, ...
        X1+(i-1)*boxWidth, X1+(i-1)*boxWidth]; 
    squareY(i,:) = [Y1, Y1, Y2, Y2, Y1];
end

%% Parameters
popSize = 50;
keepRate = 0.1; 
mutationRate = 0.1;
maxIter = 1000;

%% Set starting point for each target plate to simulate pre filled state
targetFill_1 = 1;
targetFill_2 = 1;
targetFill_3 = 1;
targetFill_4 = 1;

%% Initial values
recordDistance = inf;
iterCount = 1;
keepSize = floor(keepRate*popSize);
routeMatrix = zeros(popSize, vertices+1, 2);
population = zeros(popSize,n);
fitness = zeros(popSize,1);
avrgFitness = zeros(maxIter,2);

% Initial population
for i = 1:popSize
    population(i,:) = randperm(n,n);
end

% Create one standard pop with standard route for comparison
popUnoptimized = 1:1:n;
population(1,:) = popUnoptimized;
popMark = false;
standardLength = 1;

while iterCount < maxIter
    %% Calculate Fitness
    for i = 1:popSize
        %% Generate routeMatrix depending on populations
        posCount = 2;
        %  Reset Counts to start with first empty position. Increase to
        %  simulate prefilled trays.
        targetCount1 = targetFill_1;
        targetCount2 = targetFill_2;
        targetCount3 = targetFill_3;
        targetCount4 = targetFill_4;
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
            if seedlings(population(i,j),3) == 3
                routeMatrix(i,posCount+1,:) = target3(targetCount3,:);
                targetCount3 = targetCount3 + 1;
            end
            if seedlings(population(i,j),3) == 4
                routeMatrix(i,posCount+1,:) = target4(targetCount4,:);
                targetCount4 = targetCount4 + 1;
            end
            posCount = posCount + 2;
        end
        %% Calculation of route length
        routeLength = 0;
        for k = 2:vertices+1
            verticeLength = sqrt((routeMatrix(i,k,1)-routeMatrix(i,k-1,1))^2 ...
                + (routeMatrix(i,k,2)-routeMatrix(i,k-1,2))^2);
            routeLength = routeLength + verticeLength;
        end
        % Plot standard order for comparison
        if popMark == false
            figure(1);
            subplot(2,1,1);
            title("Unoptimized distance: "+routeLength);
            xlim([0 61]);
            ylim([0 9]);
            xlabel('x');
            ylabel('y');
            grid on;
            for l = 1:vertices
                hold on
                plot(routeMatrix(i,[l, l+1],1), routeMatrix(i,[l, l+1],2),'-o');
            end
            for m = 1:5
                plot(squareX(m,:), squareY(m,:));
            end
            daspect([1 1 1])
            standardLength = routeLength;
            popMark = true;
        end
        %% Update best populations
        if routeLength < recordDistance
            recordDistance = routeLength;
            bestEver = population(i,:);
            
            %% Plot route
            figure(1);
            subplot(2,1,2);
            cla(subplot(2,1,2));
            title("Optimized distance: "+recordDistance);
            xlim([0 61]);
            ylim([0 9]);
            xlabel((recordDistance/standardLength-1)*100+"%");
            grid on;
            for l = 1:vertices
                hold on
                plot(routeMatrix(i,[l, l+1],1), routeMatrix(i,[l, l+1],2),'-o')
            end
            for m = 1:5
                plot(squareX(m,:), squareY(m,:));
            end
            daspect([1 1 1])
        end        
        fitness(i,1) = routeLength;
    end
    
    %% Normalize Fitness
    sumFitness = 0;
    for i = 1:popSize
        sumFitness = sumFitness + fitness(i,1);
    end    
    for i = 1:popSize
        fitness(i,1) = fitness(i,1) / sumFitness;
    end
    
    %% Average Fitness of the population
    avrgFitness(iterCount,1) = sumFitness / popSize;
    avrgFitness(iterCount,2) = std(fitness);
    %% Sort fitness values while keeping the index
    sortedFitness = zeros(popSize,2);
    sortedFitness(:,1) = fitness;
    sortedFitness(:,2) = 1:1:popSize;
    sortedFitness = sortrows(sortedFitness,1);
    
    %% Create next Generation with mutation
    newPopulation = zeros(popSize,n);
    %% Keep best populations
    for i = 1:keepSize
        newPopulation(i,:) = population(sortedFitness(i,2),:);
    end
    
    %% Fill all others with mated and mutated recombinations from last generation
    for i = keepSize:popSize
        % Crossover
        orderA = roulette_wheel(population(:,:), fitness(:,:));
        orderB = roulette_wheel(population(:,:), fitness(:,:));
        order = crossover(orderA, orderB);
        % Mutation
        for j = 1:n
            if rand < mutationRate
                pointA = randi(length(order));
                pointB = randi(length(order));
                temp = order(pointA);
                order(pointA) = order(pointB);
                order(pointB) = temp;
            end
        end
        newPopulation(i,:) = order;      
    end
    population = newPopulation;
    
    %% Increment iter
    iterCount = iterCount+1;
end

