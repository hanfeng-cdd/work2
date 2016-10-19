function [V,D]=isomap1(train_x,test_x,k)

[traindata_row,traindata_column]=size(train_x);
[testdata_row,testdata_column]=size(test_x);
x=[train_x;test_x];
[x_row,x_column]=size(x);
%%��ʼ������ͼG={S,T,W}
dist=pdist2(x,x);
for j=1:size(dist,1)  
    [a,index]=sort(dist(:,j),'ascend');
    dist(index(k+2:end),j)=0;
end
dist=max(dist,dist');   
Dist=graphallshortestpaths(sparse(dist)); 
%max(max(Dist))
%%MDS�㷨     ����֤������Ҫ��������ֵ���������
B =-.5*(Dist.^2 - sum(Dist.^2)'*ones(1,x_row)/x_row - ones(x_row,1)*sum(Dist.^2)/x_row + sum(sum(Dist.^2))/(x_row^2));
 [V,D] = eig(B);    %����eig�õ���D�Ǵ�С�����ŵģ����Կ���ֱ���õ���
 [D,index]=sort(diag(D),'descend');
 D=diag(D);
 V=V(:,index);