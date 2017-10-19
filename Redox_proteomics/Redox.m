clear;close all;
%read spectra from mzxml files
xmlstructure=mzxmlread('MS170981-BY-4.mzXML','Levels',1); %name:value can choose to only extract MS1 spectra
%Extract MS1 peaks with m/z range and RT range
%Peaklist contains one column of m/z one column intensity; Times stands for RT
[Peaklist,Times]=mzxml2peaks(xmlstructure);
%msdotplot(Peaklist,Times,'Quantile',0.95)
%many ways to correct baseline
%baseline adjustment and normalization
%peaks=msbackadj(Peak,Intensity);
%Yout=msnorm(X,intensity)
deltaTime=120;
deltaMz=0.02;
targetTime=49.1081*60;
targetMz=971.46448;
t1=targetTime-deltaTime;
t2=targetTime+deltaTime;
mz1=targetMz-deltaMz;
mz2=targetMz+deltaMz;
charge=2;
t=find(Times>t1 & Times<t2);
[MZ1,Y1]=msppresample(Peaklist(t),1000,'Range',[mz1,mz2]);
[MZ2,Y2]=msppresample(Peaklist(t),1000,'Range',[mz1+2/charge,mz2+2/charge]);
plot(Times(t),sum(Y1))
plot(Times(t),sum(Y2))
MZ_plot=cat(1,MZ1,MZ2);
Y_plot=cat(1,MZ1,MZ2);
h=plot(MZ1,sum(Y1),'b',MZ2,sum(Y2),'r')
xlabel('Mass/Charge (M/Z)');ylabel('Relative Intensity')
legend(h([1 end]),{'Ovarian Cancer','Control'})
title('Region of the pre-processed spectrograms')
axis([970 974 -2 1.5e9])
%suppose there are two MZ1 Y1 MZ2 Y2
area1=sum(sum(Y1));
area2=sum(sum(Y2));
%Calculate the ratio
sequence={'TRDACPLDNQPWQLAR'};
MD=isotopicdist('TRDACPLDNQPWQLAR','nterm','Amine','cterm','Amide','showplot',true);
ratio=(area2-area1*MD(3)/MD(1))/area1; %calculate C13/C12 ratio in each sample ratio equals to 0.0055 accord with PD results








