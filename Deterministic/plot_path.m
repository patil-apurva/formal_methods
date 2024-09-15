close all;
%plot the regions
figure(1)
hold on;
axis equal;
xlim([0 1]); 
ylim([0 1]);
box on;

for i=1:size(obsx,1)
    fill(cell2mat(obsx(i)),cell2mat(obsy(i)),'r')
end

for i=1:size(livex,1)
    fill(cell2mat(livex(i)),cell2mat(livey(i)),'g')
end

%plot the sampled points
scatter (points(:,1),points(:,2),'.','k');
scatter (points(1,1),points(1,2),800,'.','b');

%plot transitions
for i=1:size(trans,1)
    X=[points(trans(i,1),1),points(trans(i,2),1)];
    Y=[points(trans(i,1),2),points(trans(i,2),2)];
    plot(X,Y,'k')
end

path=[1 96 82 32 5 23 42 88 65 88 42 58 51 69 70 72 70 69 51 58 23 5 48 76 28 36];
for i=1:size(path,2)-1
    X=[points(path(i),1),points(path(i+1),1)];
    Y=[points(path(i),2),points(path(i+1),2)];
    plot(X,Y,'b','LineWidth',4)
end

size(path,2)