%%**********************读入训练数据*******************
clc;
clear;
sonar_traindata=load('data\sonar-test.txt');
d=10
%%*******************PCA
sonar_traindata_label=sonar_traindata(:,61);
sonar_traindata_x=sonar_traindata(:,1:60);
[size_row,size_columa]=size(sonar_traindata_x);
%%中心化
sonar_traindata_meanx=sonar_traindata_x;
for j=1:size_row
     sonar_traindata_meanx(j,:)=sonar_traindata_x(j,:)-mean(sonar_traindata_x);
end
%%对协方差矩阵求特征值
sonar_traindata_C=sonar_traindata_meanx'*sonar_traindata_meanx;
 [V,D] = eig(sonar_traindata_C);    %由于eig得到的D是从小到大排的，所以可以直接用倒序
 sort_D=sort(diag(D),'descend');
 W=zeros(d,size_columa);                       
for j=1:d
    W(j,:)=V(:,find(diag(D)==sort_D(j)))';
end
sonar_traindata_PCAx= W * sonar_traindata_x';   

