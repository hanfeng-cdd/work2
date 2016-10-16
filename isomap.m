function [train_ISOx,test_ISOx]=isomap(train_x,test_x,k,d)

[traindata_row,traindata_column]=size(train_x);
[testdata_row,testdata_column]=size(test_x);
train_ISOx=zeros(traindata_row,d);
test_ISOx=zeros(testdata_row,d);
x=[train_x;test_x];
[x_row,x_column]=size(x);
%%初始化生成图G={S,T,W}
i=1;
 dist= pdist2(x(i,:),x,'Euclidean'); %返回一个欧氏距离列矩阵
 sort_dist=sort(dist,'ascend');
 j=2;
 S=i;
 T=find(dist==sort_dist(j));
 W=sort_dist(j);
 for j=3:k+1   %因为他自己的计算也在里面
     S=[S,i];
     T=[T,find(dist==sort_dist(j))];
     W=[W,sort_dist(j)];
 end
 for i=2:x_row
     dist= pdist2(x(i,:),x,'Euclidean'); %返回一个欧氏距离列矩阵
      sort_dist=sort(dist,'ascend');
      for j=2:k+1
          S=[S,i];
          T=[T,find(dist==sort_dist(j))];
          W=[W,sort_dist(j)];
      end
 end
 S1=S;
 T1=T;
 S=[S1,T1];
 T=[T1,S1];
 W=[W,W];
%for i=1:x_row
G=sparse(S,T,W);
G(x_row,x_row)=0;      %确保G是行列一样的，有的可能是孤立点
Dist=graphallshortestpaths(G);    %计算出了距离矩阵，接下来就是MDS算法了
max(max(Dist))
Dist2=Dist.*Dist;
%%MDS算法
for i=1:x_row
    dist2_sum_row(i)=sum(Dist2(i,:))/x_row;
    dist2_sum_column(i)=sum(Dist2(:,i))/x_row;
end
dist2_sum=sum(sum(Dist2))/(x_row*x_row);
B=zeros(x_row,x_row);
for i=1:x_row
    for j=1:x_row
        B(i,j)= -0.5 * (Dist2(i,j)+dist2_sum- dist2_sum_row(i)- dist2_sum_column(j));
    end
end
 [V,D] = eig(B);    %由于eig得到的D是从小到大排的，所以可以直接用倒序
 sort_D=sort(diag(D),'descend');
 want_D=sort_D(1:d);
 want_D=diag(want_D);
 sort_V=sort(V,'descend');
 ISO_x=zeros(x_row,d);                       
 ISO_x=V(:,1:d)*sqrt(want_D);    %
%  %%计算新空间的距离
%  new_D= squareform(pdist(ISO_x,'Euclidean'));
%  error=new_D-Dist;
%  sum(sum(error))
 
 train_ISOx = ISO_x(1:traindata_row,:);
 test_ISOx = ISO_x(traindata_row+1:traindata_row+testdata_row,:);
end


    
