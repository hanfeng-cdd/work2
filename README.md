# work2
PCA,SVD,IOSMAP To Dimensionality  Reduction


程序说明如下：

具体运行说明：
1.在MATLAB下打开main_cdd.m直接运行即可，得到结果是两个数据集基于三类降维算法的精度：例如：sonar_PCA_acc,sonar_SVD_acc,sonar_ISO_acc

2.可以修改dim的取值来改变降维后的维度，这里维度取为[10,20,30]。

3.可以修改sonar_ISO_k或者splice_ISO_k的取值来在ISOMAP算法中建立不同k值的近邻图。

本程序一共包含以下文件：
data：数据文件夹，里面包含题目所给的两个数据集，都是txt文件

main_cdd.m：开始文件，在这里开始读入数据

start.m: 核心程序文件，在这里调用各类算法降维，计算精度

kind_to_numercial.m: 将种类数据转化为数值数据程序

isomap1.m,isomap2.m : 将ISOMAP算法分成两部进行实现

one_n_n:最近邻分类器程序实现




