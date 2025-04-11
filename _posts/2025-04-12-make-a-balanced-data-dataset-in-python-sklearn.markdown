---
title: "利用 Python Scikit-learn 创建平衡数据集"
description: "在机器学习领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现欠佳。本文将深入探讨如何使用 Python 的 Scikit-learn 库来创建平衡数据集，介绍其基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际项目中更好地处理数据集平衡性问题。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在机器学习领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现欠佳。本文将深入探讨如何使用 Python 的 Scikit-learn 库来创建平衡数据集，介绍其基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际项目中更好地处理数据集平衡性问题。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **随机欠采样**
    - **随机过采样**
    - **综合采样方法**
3. **常见实践**
    - **处理分类问题中的不平衡数据集**
    - **结合模型评估**
4. **最佳实践**
    - **数据预处理的顺序**
    - **多种采样方法结合**
5. **小结**
6. **参考资料**

## 基础概念
在机器学习中，平衡数据集意味着数据集中各个类别（标签）的样本数量大致相等。例如，在一个二分类问题中，如果正类和负类的样本数量接近，那么这个数据集就是相对平衡的。不平衡数据集可能会使模型偏向于多数类，导致对少数类的预测能力下降。

Scikit-learn 是一个广泛使用的机器学习库，提供了多种处理不平衡数据集的工具和方法，旨在通过不同的采样策略来调整数据集的平衡性，提高模型在各个类别上的性能。

## 使用方法

### 随机欠采样
随机欠采样是从多数类中随机选择一部分样本，使得多数类和少数类的样本数量达到平衡。Scikit-learn 中的 `RandomUnderSampler` 类可以实现这一功能。

```python
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from imblearn.under_sampling import RandomUnderSampler

# 生成一个不平衡的分类数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=10,
                           n_clusters_per_class=2, weights=[0.9, 0.1],
                           random_state=42)

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 初始化随机欠采样器
undersampler = RandomUnderSampler(random_state=42)

# 对训练集进行欠采样
X_resampled, y_resampled = undersampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("欠采样后训练集多数类样本数:", sum(y_resampled == 0))
print("欠采样后训练集少数类样本数:", sum(y_resampled == 1))
```

### 随机过采样
随机过采样是通过复制少数类的样本来增加少数类的样本数量，从而实现数据集的平衡。Scikit-learn 中的 `RandomOverSampler` 类可用于此目的。

```python
from imblearn.over_sampling import RandomOverSampler

# 初始化随机过采样器
oversampler = RandomOverSampler(random_state=42)

# 对训练集进行过采样
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("过采样后训练集多数类样本数:", sum(y_resampled == 0))
print("过采样后训练集少数类样本数:", sum(y_resampled == 1))
```

### 综合采样方法
除了简单的随机欠采样和过采样，还有一些综合的采样方法，如 SMOTE（Synthetic Minority Over-sampling Technique）。SMOTE 通过在少数类样本的特征空间中生成新的合成样本来增加少数类的样本数量。

```python
from imblearn.over_sampling import SMOTE

# 初始化 SMOTE 采样器
smote = SMOTE(random_state=42)

# 对训练集进行 SMOTE 采样
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("SMOTE 采样后训练集多数类样本数:", sum(y_resampled == 0))
print("SMOTE 采样后训练集少数类样本数:", sum(y_resampled == 1))
```

## 常见实践

### 处理分类问题中的不平衡数据集
在处理实际的分类问题时，不平衡数据集很常见。例如，在欺诈检测任务中，正常交易的数量通常远远大于欺诈交易的数量。通过上述采样方法，可以在训练模型之前对数据集进行平衡处理，提高模型对欺诈交易的检测能力。

### 结合模型评估
在对数据集进行采样后，需要使用合适的评估指标来评估模型的性能。对于不平衡数据集，准确率可能不是一个合适的指标，因为模型可能通过简单地预测多数类就能获得较高的准确率。常用的评估指标包括精确率（Precision）、召回率（Recall）、F1 值等。

```python
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report

# 使用决策树模型
model = DecisionTreeClassifier(random_state=42)

# 在欠采样后的数据集上训练模型
model.fit(X_resampled, y_resampled)

# 对测试集进行预测
y_pred = model.predict(X_test)

# 输出分类报告
print(classification_report(y_test, y_pred))
```

## 最佳实践

### 数据预处理的顺序
在进行数据预处理时，需要注意采样操作的顺序。通常，应该先进行数据清洗和特征工程，然后再进行采样。这样可以确保采样操作是在经过处理的干净数据上进行，避免引入不必要的偏差。

### 多种采样方法结合
在某些情况下，单一的采样方法可能无法达到最佳效果。可以尝试结合多种采样方法，例如先进行欠采样，然后再对少数类进行过采样，或者使用 SMOTE 等更复杂的方法，以获得更好的数据集平衡效果和模型性能。

## 小结
本文详细介绍了使用 Python Scikit-learn 创建平衡数据集的方法，包括随机欠采样、随机过采样和综合采样方法等。同时，阐述了常见实践和最佳实践，如在实际分类问题中的应用以及与模型评估的结合。通过合理运用这些方法，可以有效解决不平衡数据集带来的问题，提高机器学习模型的性能和泛化能力。

## 参考资料
- [Scikit-learn 官方文档](https://scikit-learn.org/stable/){: rel="nofollow"}
- [imbalanced-learn 官方文档](https://imbalanced-learn.org/stable/){: rel="nofollow"}
- 《Python 机器学习基础教程》
 