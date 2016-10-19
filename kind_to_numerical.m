function [train_x,test_x]=kind_to_numerical(splice_traindata_x,splice_testdata_x)

[train_size_row,train_size_column]=size(splice_traindata_x);
[test_size_row,test_size_column]=size(splice_testdata_x);

%%splice种类数据数值化:
train_x=zeros(train_size_row,4*train_size_column);
test_x=zeros(test_size_row,4*test_size_column);
for i=1:train_size_row
    for j=1:train_size_column
        if splice_traindata_x(i,j)==1
           train_x(i,4*(j-1)+1:4*j)=[1,0,0,0];
        else if splice_traindata_x(i,j)==2
             train_x(i,4*(j-1)+1:4*j)=[0,1,0,0];
            else if splice_traindata_x(i,j)==3
                   train_x(i,4*(j-1)+1:4*j)=[0,0,1,0];     
                else
                        train_x(i,4*(j-1)+1:4*j)=[0,0,0,1];
                end
            end
        end
    end
end
for i=1:test_size_row
    for j=1:test_size_column
        if splice_testdata_x(i,j)==1
           test_x(i,4*(j-1)+1:4*j)=[1,0,0,0];
        else if splice_testdata_x(i,j)==2
             test_x(i,4*(j-1)+1:4*j)=[0,1,0,0];
            else if splice_testdata_x(i,j)==3
                    test_x(i,4*(j-1)+1:4*j)=[0,0,1,0];     
                else
                         test_x(i,4*(j-1)+1:4*j)=[0,0,0,1];
                end
            end
        end
    end
end