
% create data
mu_1 = [1 -1]; Sigma = [.9 .4; .4 .8];
r1 = mvnrnd(mu_1, Sigma, 500);
%figure;
%plot(r1(:,1),r1(:,2),'.');
%hold on;
mu_2 = [-1 1]; Sigma = [.9 .4; .4 .3];
r2 = mvnrnd(mu_2, Sigma, 500);
%plot(r2(:,1),r2(:,2),'r.');

data=[r1;r2];

figure;
hold on;

[u re]=KMeans_function(data,2);
[m n]=size(re);
for i=1:m
    if re(i,3)==1
        plot(re(i,1),re(i,2),'ro');
    else 
        plot(re(i,1),re(i,2),'bo');
    end
    
end
plot(u(1,1),u(1,2),'k+','MarkerSize',14,'LineWidth',4);
hold on;
plot(u(2,1),u(2,2),'k+','MarkerSize',14,'LineWidth',4);