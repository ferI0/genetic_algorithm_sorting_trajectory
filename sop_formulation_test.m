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
%% Generate population an route vector depending on population       
population = randperm(n,n);
routeMatrix = zeros(vertices, 2);
posCount = 2;
targetCount1 = 1;
targetCount2 = 1;
for i = 1:length(population)
    routeMatrix(posCount,:) = seedlings(population(i),1:2);
    if seedlings(population(i),3) == 1
        routeMatrix(posCount+1,:) = target1(targetCount1,:);
        targetCount1 = targetCount1 + 1;
    end
    if seedlings(population(i),3) == 2
        routeMatrix(posCount+1,:) = target2(targetCount2,:);
        targetCount2 = targetCount2 + 1;
    end
    posCount = posCount + 2;
end

%% Calculation of route length
routeLength = 0;
for i = 2:vertices
    verticeLength = abs(sqrt(routeMatrix(i,1)^2+routeMatrix(i,2)^2)...
        - sqrt(routeMatrix(i-1,1)^2+routeMatrix(i-1,2)^2))
    routeLength = routeLength + verticeLength
end
           