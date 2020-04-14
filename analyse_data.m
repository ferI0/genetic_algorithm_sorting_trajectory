clear all;
iter = 1;
MAX = 300;
pop = 50;
it = 1000;
mu = 0.1;
keep = 0.05;
seed = 96;
best = zeros(MAX,it);
standard = zeros(MAX,1);
groupLow = 1;
groupHigh = 4;

groups = zeros(seed,1);


%load('groups');

while iter <= MAX
    for i = 1:seed
        groups(i) = randi(4);
    end
    [best(iter,:), standard(iter,:)] = ga_function(pop, keep, mu, it, seed, groups);
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

save('longtest');