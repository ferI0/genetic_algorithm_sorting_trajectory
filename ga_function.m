function [outputArg1,outputArg2] = ga_function(POPSIZE, KEEPRATE, MUTRATE, ITMAX, NUMSEED, GROUPS)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% Route generation and optimization with genetic algorithm
%% FE 2020
%clear all;
%% Mostly manually set start and end positions with random target groups for each seedling
n = NUMSEED;  %Number of seedlings
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
        seedlings(seedCount,:,:) = [j+2*boxWidth i GROUPS(seedCount)];
        target1(seedCount,:) = [j i];
        target2(seedCount,:) = [j+1*boxWidth i];
        target3(seedCount,:) = [j+3*boxWidth i];
        target4(seedCount,:) = [j+4*boxWidth i];
        
        seedCount = seedCount + 1;
    end
end



%% Parameters
popSize = POPSIZE;
keepRate = KEEPRATE;
mutationRate = MUTRATE;
maxIter = ITMAX;

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

while iterCount <= maxIter
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
        %% Update best populations
        if routeLength < recordDistance
            recordDistance = routeLength;
            bestEver = population(i,:);          
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
outputArg1 = recordDistance;
outputArg2 = avrgFitness;
end

