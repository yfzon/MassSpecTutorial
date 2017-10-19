%GMM clustering of CR paper
%<Calorie Restriction and SIRT3 Trigger Global Reprogramming of the Mitochondrial Protein Acetylome>
%Data source: supplement
%Cluster number 15
clear;close all
X=xlsread('mmc3_data.xls',1,'A2:C3286')
%15 cluster component
gm=fitgmdist(X,15);    %X:target data points(x,y) dataset size 300, fit into 2 component
threshold=[0.4 0.6]; %The probability in 0.4-0.6 is considered
%Estimate component-member posterior probabilities for all data points
%using the fitted GMM gm
P =posterior(gm,X); %บ๓ั้
idx=cluster(gm,X);   %save the 3285 points with belonging to the group
idxBoth=find(P(:,1)>=threshold(1) & P(:,1)<=threshold(2));
numInBoth=numel(idxBoth);
hist(idx)
xlswrite('15clusters_CR.xls',idx)