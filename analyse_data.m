clear all;
iter = 1;
MAX = 20;
pop = 50;
it = 1000;
mu = 0.2; 
keep = 0.1;
seed = 96;
best = zeros(MAX,it);
% groupLow = 1;
% groupHigh = 4;

% groups = zeros(seed,1);
% 
% for i = 1:seed
%     groups(i) = randi(4);
% end
load('groups');

while iter <= MAX
    best(iter,:) = ga_function(pop, keep, mu, it, seed, groups);
    iter = iter+1
end

BestAvrg = zeros(1,it);
sumBest = zeros(1,it);

for i = 1:it
    for j = 1:MAX
        sumBest(i) = sumBest(i) + best(j,i); 
    end
end

for i = 1:it
    BestAvrg(i) = sumBest(i) / MAX; 
end

plot([1:1:it],BestAvrg);

save('doe8');