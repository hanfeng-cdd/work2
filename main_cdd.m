%%
%Author: Chen Dongdong   e-mail:chendd.summer@gmail.com  
%sonar_PCA_acc,sonar_SVD_acc,sonar_ISO_acc�ֱ��ʾsonar���ݼ�����PCA��SVD��ISOMAP��ά��õ��ķ��ྫ��
%splice_PCA_acc,splice_SVD_acc,splice_ISO_acc�ֱ��ʾsplice���ݼ�����PCA��SVD��ISOMAP��ά��õ��ķ��ྫ��
clear;
clc
tic;
%%
%��������
dim=[10,20,30];
sonar_ISO_k=6;
splice_ISO_k=5;
%%
disp('  begin to deal with sonar data    ');
sonar_traindata=load('data\sonar-train.txt');
sonar_testdata=load('data\sonar-test.txt');
[sonar_PCA_acc,sonar_SVD_acc,sonar_ISO_acc]=start(sonar_traindata(:,1:end-1),sonar_traindata(:,end),sonar_testdata(:,1:end-1),sonar_testdata(:,end),dim,sonar_ISO_k);   %�����ַ��������
time1=toc;
fprintf(['the totle time for sonar is:',num2str(time1),'\n']);
%%
disp('begin to deal with splice data ');
splice_traindata=load('data\splice-train.txt');      %��������
splice_testdata=load('data\splice-test.txt');
[splice_train_x,splice_test_x]=kind_to_numerical(splice_traindata(:,1:end-1),splice_testdata(:,1:end-1));  %��splice����������ֵ��
[splice_PCA_acc,splice_SVD_acc,splice_ISO_acc]=start(splice_train_x,splice_traindata(:,end),splice_test_x,splice_testdata(:,end),dim,splice_ISO_k);   %�����ַ��������
totle_time=toc;
fprintf(['the totle time for splice is:',num2str(totle_time-time1),'\n']);
fprintf(['the totle time  is:',num2str(totle_time),'\n']);
 
