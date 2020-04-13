clear all;
iter = 1;
MAX = 3;
pop = 50;
it = 100;
mu = 0.1; 
keep = 0.1;
seed = 96;
best = zeros(MAX,1);
avrg = zeros(MAX,it,2);
% groupLow = 1;
% groupHigh = 4;

% groups = zeros(seed,1);
% 
% for i = 1:seed
%     groups(i) = randi(4);
% end
load('groups');

while iter <= MAX
    [best(iter), avrg(iter,:,:)] = ga_function(pop, keep, mu, it, seed, groups);
    iter = iter+1;
end
