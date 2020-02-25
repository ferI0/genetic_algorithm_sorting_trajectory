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
vertices = [startEnd; seedlings(1,1:2); target1(1,:); startEnd]

for 
           