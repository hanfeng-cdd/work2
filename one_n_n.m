function testlabel=one_n_n(train_x,train_label,test_x)
[train_size_row,train_size_columa]=size(train_x);
[test_size_row,test_size_columa]=size(test_x);
testlabel=zeros(test_size_row,1);
for i=1:test_size_row
        dist= pdist2(test_x(i,:),train_x,'Euclidean'); %返回一个欧氏距离列矩阵
        testlabel(i)= train_label(find(dist==min(dist)));
end
end

        
    