clear all;

load('doe1');
best1 = BestAvrg;
load('doe2');
best2 = BestAvrg;
load('doe3');
best3 = BestAvrg;
load('doe4');
best4 = BestAvrg;
load('doe5');
best5 = BestAvrg;
load('doe6');
best6 = BestAvrg;
load('doe7');
best7 = BestAvrg;
load('doe8');
best8 = BestAvrg;

it = 1:1:1000;
bestList = [best1;best2;best3;best4;best5;best6;best7;best8];
N = 8; 
C = linspecer(N);
hold off;
for ii=1:N
    
    plot(it,bestList(ii,:),'color',C(ii,:),'linewidth',1);
    hold on;
end
xlabel('number of generations');
ylabel('cost');
box off;
%plot(it,best1,'r',it,best2,'g',it,best3,'b',it,best4,'c',it,best5,'y',it,best6,it,best7,it,best8);
legend('mr=0.1, sr=0.05, pop=25','mr=0.2, sr=0.05, pop=25','mr=0.1, sr=0.1, pop=25', ...
    'mr=0.2, sr=0.1, pop=25','mr=0.1, sr=0.05, pop=50','mr=0.2, sr=0.05, pop=50', ...
    'mr=0.1, sr=0.1, pop=50','mr=0.2, sr=0.1, pop=50');