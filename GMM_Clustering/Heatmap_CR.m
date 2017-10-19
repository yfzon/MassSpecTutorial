% Draw heatmap of 15 clusters
clear;close all
cluster=xlsread('15clusters_CR.xls',1);
data=xlsread('mmc3_data.xls',1,'A2:C3286');
[~,name,~]=xlsread('mmc3.xlsx',1,'A3:A3287'); %read the txt words
HeatMap(data(cluster==1,:),'Colormap',redbluecmap)
HeatMap(data(cluster==2,:),'Colormap',redbluecmap)
HeatMap(data(cluster==3,:),'Colormap',redbluecmap)
HeatMap(data(cluster==4,:),'Colormap',redbluecmap)
HeatMap(data(cluster==5,:),'Colormap',redbluecmap)
HeatMap(data(cluster==6,:),'Colormap',redbluecmap)
HeatMap(data(cluster==7,:),'Colormap',redbluecmap)
HeatMap(data(cluster==8,:),'Colormap',redbluecmap)
HeatMap(data(cluster==9,:),'Colormap',redbluecmap)
HeatMap(data(cluster==10,:),'Colormap',redbluecmap)
HeatMap(data(cluster==11,:),'Colormap',redbluecmap)
HeatMap(data(cluster==12,:),'Colormap',redbluecmap)
HeatMap(data(cluster==13,:),'Colormap',redbluecmap)
HeatMap(data(cluster==14,:),'Colormap',redbluecmap)
HeatMap(data(cluster==15,:),'Colormap',redbluecmap)