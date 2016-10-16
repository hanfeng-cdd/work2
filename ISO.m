
clc;
clear;
sonar_traindata=load('data\sonar-train.txt');
sonar_testdata=load('data\sonar-test.txt');
sonar_traindata_label=sonar_traindata(:,61);
sonar_traindata_x=sonar_traindata(:,1:60);
sonar_testdata_x=sonar_testdata(:,1:60);
sonar_testdata_label=sonar_testdata(:,61);
d=10
k=10;    %k如果太小，会存在断路
[sonar_traindata_ISOx,sonar_testdata_ISOx]=isomap(sonar_traindata_x,sonar_testdata_x,k,d);