n = 4;
vertices = zeros(1,2*n+1);
startEnd = [0 0];
seedlings = [1 1 1,
             1 2 2,
             2 1 1,
             2 2 2];
target1 = [3 2,
           3 1,
           4 2,
           4 1];
       
target2 = [5 2,
           5 1,
           6 2,
           6 1];
       
%% Manual route selection
vertices = [startEnd; seedlings(1,1:2); target1(1,:); seedlings(2,1:2); target2(1,:); startEnd]
routeLength = 0;
for i = 2:length(vertices)
    verticeLength = abs(sqrt(vertices(i,1)^2+vertices(i,2)^2) - sqrt(vertices(i-1,1)^2+vertices(i-1,2)^2))
    routeLength = routeLength + verticeLength
end
           