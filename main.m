%%**********************读入数据*******************
clc;
clear;
sonar_traindata=load('data\sonar-train.txt');
sonar_testdata=load('data\sonar-test.txt');
d=10           %降维后的维度
%%*******************PCA**********************
sonar_traindata_label=sonar_traindata(:,61);
sonar_traindata_x=sonar_traindata(:,1:60);
sonar_testdata_x=sonar_testdata(:,1:60);
sonar_testdata_label=sonar_testdata(:,61);
[train_size_row,train_size_columa]=size(sonar_traindata_x);

%%中心化
sonar_traindata_meanx=sonar_traindata_x;
for j=1:train_size_row
     sonar_traindata_meanx(j,:)=sonar_traindata_x(j,:)-mean(sonar_traindata_x);
end
% [PCA_W,PCA_S,PCA_V]=svd(sonar_traindata_meanx');    %是对原数据转置进行奇异值分解
% PCA_W=PCA_W(:,1:d)';
%对协方差矩阵求特征值
sonar_traindata_C=sonar_traindata_meanx'*sonar_traindata_meanx;
 [V,D] = eig(sonar_traindata_C);    %由于eig得到的D是从小到大排的，所以可以直接用倒序
 sort_D=sort(diag(D),'descend');
 PCA_W=zeros(d,train_size_columa);                       
for j=1:d
    PCA_W(j,:)=V(:,find(diag(D)==sort_D(j)))';     %这里计算出来的每个w都可以取正，也可以取负
end
%***************************SVD***************************************
[SVD_W,SVD_S,SVD_V]=svd(sonar_traindata_x');    %是对原数据转置进行奇异值分解
SVD_W=SVD_W(:,1:d)';


%%*****************************ISOMAP*********************************
k=6;     %6是最少的全连通
[sonar_traindata_ISOx,sonar_testdata_ISOx]=isomap(sonar_traindata_x,sonar_testdata_x,k,d);
%**************************将数据投影到低维空间************************

%%PCA投影
sonar_traindata_PCAx= PCA_W * sonar_traindata_x';   %将训练数据投影到低维空间
sonar_traindata_PCAx=sonar_traindata_PCAx';
sonar_testdata_PCAx= PCA_W * sonar_testdata_x';   %将测试数据投影到低维空间,每一行是一个数据点
sonar_testdata_PCAx=sonar_testdata_PCAx';
%%SVD投影
sonar_traindata_SVDx= SVD_W * sonar_traindata_x';   %将训练数据投影到低维空间
sonar_traindata_SVDx=sonar_traindata_SVDx';
sonar_testdata_SVDx= SVD_W * sonar_testdata_x';   %将测试数据投影到低维空间,每一行是一个数据点
sonar_testdata_SVDx=sonar_testdata_SVDx';
%%ISOMAP投影

%***************************执行1—N—N，计算精度******************************
test_num=size(sonar_testdata_x,1);
%%计算PCA精确度
PCA_label=one_n_n(sonar_traindata_PCAx,sonar_traindata_label,sonar_testdata_PCAx);
test_right_PCAnum=sum((sonar_testdata_label - PCA_label)==0);
sonar_PCA_acc=test_right_PCAnum/test_num
 %%计算SVD精确度  
SVD_label=one_n_n(sonar_traindata_SVDx,sonar_traindata_label,sonar_testdata_SVDx);
test_right_SVDnum=sum((sonar_testdata_label - SVD_label)==0);
sonar_SVD_acc=test_right_SVDnum/test_num    
 %%计算ISO精确度  
ISO_label=one_n_n(sonar_traindata_ISOx,sonar_traindata_label,sonar_testdata_ISOx);
test_right_ISOnum=sum((sonar_testdata_label - ISO_label)==0);
sonar_ISO_acc=test_right_ISOnum/test_num   


