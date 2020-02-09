% cost function for traveling salesperson problem
% Haupt & Haupt
% 2003
function dist=tspfun(pop)
global iga x y
[Npop,Ncity]=size(pop);
tour=[pop pop(:,1)];
%distance between cities
for ic=1:Ncity
for id=1:Ncity
dcity(ic,id)=sqrt((x(ic)-x(id))^2+(y(ic)-y(id))^2);
end % id
end %ic
% cost of each chromosome
for ic=1:Npop
dist(ic,1)=0;
for id=1:Ncity
dist(ic,1)=dist(ic)+dcity(tour(ic,id),tour(ic,id+1));
end % id
end % ic