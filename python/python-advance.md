# 关联算法

稀疏矩阵：**sparse**，零元素数目远远多于非零元素数目，并且非零元素的分布没有规律的矩阵。  
支持度：**Support**，项集的支持度就是该项集出现的次数除以总的记录数  
置信度：**Confidence**，发生X的条件下，又发生Y的概率。  

## Apriori

平时不用！

## FP-Tree

安装包：`pyfpgrowth`





------

# 回归分析

导入库和类：

```python
from sklearn.linear_model import LinearRegression
```

## 显著性经验  

拟合优度：R^2，相当于相关系数的平方

<hr>

# 时间序列

用y预测y



------

# 集成学习

多模型判断  

库：`sklearn.ensemble`

## Bagging RandomForest

随机森林：基于决策树  
类：`RandomForestClassifier`  
特征重要性

## AdaBoost 增强型

## Boosting

基于误差回归



------

# 数据挖掘

1. 通过数据，寻找规律，进行预测
2. 分类：预测客户流失
3. 回归：预测客户收入

## 工具包

Numpy：ndarray数据结构
Scipy：基础数学计算
Pandas：数学分析
Scikit-Learn：数据挖掘工具

## 分类算法

1. 要有标注数据
2. 有监督的机器学习算法
3. 学习方法  
   1. 原理，应用场景，优缺点
   2. 对数据的要求
   3. 有哪些参数可以调整
   4. 论文 + 源码 + 项目

------

## 决策树(Decision Tree)

适合做二分类

1. 特征选择
   1. 熵(Entropy)
   2. Gini不纯度(二分类)
   3. 信息增益，信息增益率
2. 分类不平衡问题
3. 根据业务筛选建模数据对象
   1. 指标设计，特征设计
4. 数据清洗和整理
   - 拉格朗日插值法

## 分类案例：iris

1. 商业理解：对莺尾花的数据进行分类
2. 

------

## 贝叶斯算法

贝叶斯定理：要求特征之间相互独立  
​    P(B|A) = P(A|B)P(B)/P(A)  

1. 要求特征之间相互独立，基于概率密度的算法
2. 适合做文本分类，但无法理解特征之间的隐含关系

## Python中的贝叶斯

`sklearn.naive_bayes`  

1. GaussianNB：连续的特征值
2. MultinomialNB：适合处理文本
3. BernoulliNB：0-1分布

------

## 逻辑回归

对线性不可分的数据进行分类

------

## SVM(支持向量机)

非线性映射  
提升样本空间  

1. 线性核函数K(x,y)=x·y；
2. 多项式核函数K(x,y)=[(x·y)+1]^d；
3. 径向基函数K(x,y)=exp(-|x-y|^2/d^2）
4. 二层神经网络核函数K(x,y)=tanh(a(x·y)+b）．
5. 高斯核函数

## 神经网络