---
title: "用Python的Scikit-learn创建平衡数据集"
description: "在机器学习领域，数据的平衡性对于模型的性能有着至关重要的影响。不平衡数据集往往会导致模型在多数类上表现良好，但在少数类上表现欠佳。Scikit-learn（sklearn）作为Python中广泛使用的机器学习库，提供了多种方法来创建平衡数据集。了解如何利用这些工具可以显著提升我们构建的机器学习模型的泛化能力和准确性。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在机器学习领域，数据的平衡性对于模型的性能有着至关重要的影响。不平衡数据集往往会导致模型在多数类上表现良好，但在少数类上表现欠佳。Scikit-learn（sklearn）作为Python中广泛使用的机器学习库，提供了多种方法来创建平衡数据集。了解如何利用这些工具可以显著提升我们构建的机器学习模型的泛化能力和准确性。

<!-- more -->
## 目录
1. 不平衡数据集问题
2. 基础概念
3. 使用方法
    - 随机欠采样
    - 随机过采样
    - SMOTE（合成少数类过采样技术）
4. 常见实践
    - 不平衡分类任务示例
    - 数据集预处理
5. 最佳实践
    - 结合欠采样和过采样
    - 交叉验证中的平衡处理
6. 小结
7. 参考资料

## 不平衡数据集问题
不平衡数据集指的是数据集中不同类别的样本数量存在显著差异的情况。例如，在一个疾病预测的数据集中，健康样本可能有数千条，而患病样本只有几百条。这种不平衡会使模型在训练过程中倾向于多数类，从而导致对少数类的预测效果不佳。在实际应用中，少数类可能是我们更关注的类别，如欺诈检测中的欺诈交易、医疗诊断中的罕见疾病等。

## 基础概念
### 欠采样
欠采样是通过减少多数类的样本数量来使数据集达到平衡的方法。它的优点是计算成本低，但可能会丢失一些信息，导致模型的泛化能力受限。

### 过采样
过采样则是增加少数类的样本数量来平衡数据集。常见的过采样方法包括复制少数类样本或生成新的少数类样本。过采样的优点是保留了所有的原始信息，但可能会导致过拟合问题。

### SMOTE
SMOTE是一种更智能的过采样技术，它不是简单地复制少数类样本，而是通过在少数类样本的特征空间中生成新的合成样本。具体来说，它找到少数类样本的最近邻，然后在这些最近邻之间生成新的样本，从而增加少数类样本的数量。

## 使用方法
### 随机欠采样
在Scikit-learn中，可以使用`RandomUnderSampler`进行随机欠采样。以下是一个简单的代码示例：

```python
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from imblearn.under_sampling import RandomUnderSampler

# 生成一个不平衡的分类数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=5,
                           weights=[0.9, 0.1], random_state=42)

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 随机欠采样
undersampler = RandomUnderSampler(random_state=42)
X_resampled, y_resampled = undersampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("欠采样后训练集多数类样本数:", sum(y_resampled == 0))
print("欠采样后训练集少数类样本数:", sum(y_resampled == 1))
```

### 随机过采样
使用`RandomOverSampler`进行随机过采样，代码示例如下：

```python
from imblearn.over_sampling import RandomOverSampler

# 随机过采样
oversampler = RandomOverSampler(random_state=42)
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("过采样后训练集多数类样本数:", sum(y_resampled == 0))
print("过采样后训练集少数类样本数:", sum(y_resampled == 1))
```

### SMOTE
使用`SMOTE`进行过采样，示例代码如下：

```python
from imblearn.over_sampling import SMOTE

# SMOTE过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("SMOTE过采样后训练集多数类样本数:", sum(y_resampled == 0))
print("SMOTE过采样后训练集少数类样本数:", sum(y_resampled == 1))
```

## 常见实践
### 不平衡分类任务示例
假设我们要进行一个客户流失预测任务，数据集中流失客户（少数类）和留存客户（多数类）数量不平衡。

```python
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, recall_score

# 读取数据
data = pd.read_csv('customer_churn_data.csv')
X = data.drop('churn', axis=1)
y = data['churn']

# 数据标准化
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# 随机过采样
oversampler = RandomOverSampler(random_state=42)
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)

# 训练逻辑回归模型
model = LogisticRegression(random_state=42)
model.fit(X_resampled, y_resampled)

# 预测
y_pred = model.predict(X_test)

# 评估模型
accuracy = accuracy_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)

print(f"准确率: {accuracy}")
print(f"召回率: {recall}")
```

### 数据集预处理
在进行过采样或欠采样之前，通常需要对数据集进行预处理，如特征缩放、缺失值处理等。这可以确保数据的质量，提高模型的性能。

```python
from sklearn.impute import SimpleImputer

# 处理缺失值
imputer = SimpleImputer(strategy='mean')
X_imputed = imputer.fit_transform(X)

# 特征缩放
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X_imputed)
```

## 最佳实践
### 结合欠采样和过采样
可以将欠采样和过采样结合使用，以充分利用两者的优点。例如，先对多数类进行欠采样，然后对少数类进行过采样。

```python
from imblearn.combine import SMOTEENN

# 使用SMOTEENN结合欠采样和过采样
smote_enn = SMOTEENN(random_state=42)
X_resampled, y_resampled = smote_enn.fit_resample(X_train, y_train)
```

### 交叉验证中的平衡处理
在进行交叉验证时，需要确保每个折叠中的数据集都是平衡的。可以使用`StratifiedKFold`来实现这一点，它会在划分折叠时尽量保持各类别的比例。

```python
from sklearn.model_selection import StratifiedKFold

kf = StratifiedKFold(n_splits=5)
for train_index, test_index in kf.split(X_train, y_train):
    X_train_fold, X_test_fold = X_train[train_index], X_train[test_index]
    y_train_fold, y_test_fold = y_train[train_index], y_train[test_index]

    # 对每个折叠进行过采样或欠采样
    oversampler = RandomOverSampler(random_state=42)
    X_resampled, y_resampled = oversampler.fit_resample(X_train_fold, y_train_fold)

    # 训练和评估模型
    model = LogisticRegression(random_state=42)
    model.fit(X_resampled, y_resampled)
    y_pred = model.predict(X_test_fold)
    accuracy = accuracy_score(y_test_fold, y_pred)
    recall = recall_score(y_test_fold, y_pred)

    print(f"折叠准确率: {accuracy}")
    print(f"折叠召回率: {recall}")
```

## 小结
通过使用Scikit-learn及其扩展库（如`imblearn`）中的方法，我们可以有效地处理不平衡数据集，提高机器学习模型的性能。随机欠采样、随机过采样和SMOTE等技术各有优缺点，在实际应用中需要根据数据集的特点和任务需求选择合适的方法。结合欠采样和过采样以及在交叉验证中进行平衡处理等最佳实践，可以进一步提升模型的泛化能力和稳定性。

## 参考资料
- 《Python机器学习基础教程》
- 《Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow》