function testlabel=one_n_n(train_x,train_label,test_x)
[train_size_row,train_size_columa]=size(train_x);
[test_size_row,test_size_columa]=size(test_x);
testlabel=zeros(test_size_row,1);
for i=1:test_size_row
        dist= pdist2(test_x(i,:),train_x,'Euclidean'); %返回一个欧氏距离列矩阵
        a=find(dist==min(dist));
        if sum(train_label(a)>=0)                 %最近的距离有多个的时候考虑种类最多的，种类数目一样则判为1
            testlabel(i)= 1;
        else
             testlabel(i)= -1;
        end
        
end
end

        
    