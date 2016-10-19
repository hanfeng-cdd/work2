function [PCA_acc,SVD_acc,ISO_acc]=start(train_x,train_label,test_x,test_label,dim,ISO_k)

[train_size_row,train_size_column]=size(train_x);
[test_size_row,test_size_column]=size(test_x);
%%
%�õ�PCAͶӰ����
for j=1:train_size_row        %���Ļ�
     train_meanx(j,:)=train_x(j,:)-mean(train_x);
end
[PCA_U,PCA_S,PCA_V]=svd(train_meanx');    %�Ƕ�ԭ����ת�ý�������ֵ�ֽ�
%%
%�õ�SVDͶӰ����
[SVD_U,SVD_S,SVD_V]=svd(train_x');    %�Ƕ�ԭ����ת�ý�������ֵ�ֽ�
%%�õ�ISOMAPͶӰ����
 [ISO_U,ISO_D]=isomap1(train_x,test_x,ISO_k);
%%
%�õ���άͶӰֵ�����Ҽ��㾫��
test_num=size(test_x,1);
l=length(dim);
PCA_acc=zeros(l,1);
SVD_acc=zeros(l,1);
ISO_acc=zeros(l,1);
for l=1:length(dim)
    d=dim(l);      %ȷ��ά��
    %%PCA
    PCA_W=PCA_U(:,1:d)';
    traindata_PCAx= PCA_W * train_x';   %��ѵ������ͶӰ����ά�ռ�
    traindata_PCAx=traindata_PCAx';
    testdata_PCAx= PCA_W * test_x';   %����������ͶӰ����ά�ռ�,ÿһ����һ�����ݵ�
    testdata_PCAx=testdata_PCAx';
    PCA_label=one_n_n(traindata_PCAx,train_label,testdata_PCAx);
    test_right_PCAnum=sum((test_label - PCA_label)==0);
    PCA_acc(l)=test_right_PCAnum/test_num;
    
    %%SVD
    SVD_W=SVD_U(:,1:d)';
    traindata_SVDx= SVD_W * train_x';   %��ѵ������ͶӰ����ά�ռ�
    traindata_SVDx=traindata_SVDx';
    testdata_SVDx= SVD_W * test_x';   %����������ͶӰ����ά�ռ�,ÿһ����һ�����ݵ�
    testdata_SVDx=testdata_SVDx';
    SVD_label=one_n_n(traindata_SVDx,train_label,testdata_SVDx);
    test_right_SVDnum=sum((test_label - SVD_label)==0);
    SVD_acc(l)=test_right_SVDnum/test_num;   
    
    %%ISOMAP
    ISO_x=isomap2(ISO_U,ISO_D,d);
    traindata_ISOx = ISO_x(1:train_size_row,:);
    testdata_ISOx = ISO_x(train_size_row+1:train_size_row+test_size_row,:);
    ISO_label=one_n_n(traindata_ISOx,train_label,testdata_ISOx);
    test_right_ISOnum=sum((test_label - ISO_label)==0);
    ISO_acc(l)=test_right_ISOnum/test_num;      
end

