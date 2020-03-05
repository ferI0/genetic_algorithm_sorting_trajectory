%% Test of route generation for genetic algorithm
%% FE 2020

%% Mostly manually set start and end positions with random target groups for each seedling
n = 6;
vertices = 2*n+1;
startEnd = [0 0];
seedlings = [1 1 randi([1 2],1),
    1 2 randi([1 2],1),
    2 1 randi([1 2],1),
    2 2 randi([1 2],1),
    1 3 randi([1 2],1),
    2 3 randi([1 2],1)];
target1 = [3 3,
    3 2,
    3 1,
    4 3,
    4 2,
    4 1];

target2 = [5 3,
    5 2,
    5 1,
    6 3,
    6 2,
    6 1];

%% Squares
X1 = 0.5;
X2 = 2.5;
Y1 = 0.5;
Y2 = 3.5;

squareX1 = [X1, X2, X2, X1, X1];
squareY1 = [Y1, Y1, Y2, Y2, Y1];
squareX2 = [X1+2, X2+2, X2+2, X1+2, X1+2];
squareY2 = [Y1, Y1, Y2, Y2, Y1];
squareX3 = [X1+4, X2+4, X2+4, X1+4, X1+4];
squareY3 = [Y1, Y1, Y2, Y2, Y1];

%% Initialize stuff
currentRecord = 999999;
recordDistance = 999999;
maxIter = 10000;
iterCount = 0;
popSize = 10;
routeMatrix = zeros(popSize, vertices+1, 2);
population = zeros(popSize,n);
fitness = zeros(popSize,1);

for i = 1:popSize
    population(i,:) = randperm(n,n);
end

while iterCount < maxIter
    %% Calculate Fitness
    for i = 1:popSize
        %% Generate routeMatrix depending on populations
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
        
        %% Update best populations
        if routeLength < recordDistance
            recordDistance = routeLength;
            bestEver = population(i,:);
            
            %% Plot route
            figure(1);
            clf(figure(1));
            xlim([0 7]);
            ylim([0 4]);
            grid on;
            for l = 1:vertices
                hold on
                plot(routeMatrix(i,[l, l+1],1), routeMatrix(i,[l, l+1],2),'-o')
            end
            plot(squareX1, squareY1);
            plot(squareX2, squareY2);
            plot(squareX3, squareY3);
        end
        
        if routeLength < currentRecord
            currentRecord = routeLength;
            currentBest = population(i,:);                       
        end
        
        %% Calculate fitness
        fitness(i,1) = routeLength;%1 / (routeLength^8 + 1);
    end
    
    %% Normalize Fitness
    sumFitness = 0;
    for i = 1:popSize
        sumFitness = sumFitness + fitness(i,1);
    end
    
    for i = 1:popSize
        fitness(i,1) = fitness(i,1) / sumFitness;
    end
    
    %% Create next Generation
    
                
    %% Increment iter
    iterCount = iterCount+1;
end

