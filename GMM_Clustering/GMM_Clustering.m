%Clustering data from mixture of gaussian distribution
%https://cn.mathworks.com/help/stats/cluster-gaussian-mixture-data-using-soft-clustering.html

%Simulate data from a mixture of two bivariate Gaussian distibutions
rng(0,'twister') %For reproducibility
mu1=[1,2];
sigma1=[3 0.2; 0.2 2]
mu2=[-1 -2];
sigma2=[2 0; 0 1];
X=[mvnrnd(mu1,sigma1,200);mvnrnd(mu2,sigma2,100)]; %generate the data points belong to two group(GM distribution)

%Two component
gm=fitgmdist(X,2);    %X:target data points(x,y) dataset size 300, fit into 2 component
threshold=[0.4 0.6] %The probability in 0.4-0.6 is considered

%Estimate component-member posterior probabilities for all data points
%using the fitted GMM gm
P =posterior(gm,X); %บ๓ั้

%Plot the posibility of data points for the component
n=size(X,1)
[~,order]=sort(P(:,1));

figure
plot(1:n,P(order,1),'r-',1:n,P(order,2),'b-') %plot in the order
legend({'Cluster 1','Cluster 2'})
ylabel('Cluster Membership Score')
xlabel('Point Ranking')
title('GMM with Full Unshared Covariances')
idx=cluster(gm,X);   %save the 300 points with belonging to the group
idxBoth=find(P(:,1)>=threshold(1) & P(:,1)<=threshold(2));
numInBoth=numel(idxBoth)

figure
gscatter(X(:,1),X(:,2),idx,'rb','+o',5) %plot the two component with color
hold on
plot(X(idxBoth,1),X(idxBoth,2),'ko','MarkerSize',10)
legend({'Cluster 1','Cluster 2','Both Clusters'},'Location','SouthEast')
title('Scatter Plot - GMM with Full Unshared Covariances')
hold off