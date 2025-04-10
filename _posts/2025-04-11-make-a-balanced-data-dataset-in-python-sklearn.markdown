---
title: "利用 Python Scikit-learn 构建平衡数据集"
description: "在机器学习领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。Scikit-learn 是 Python 中一个强大的机器学习库，提供了多种方法来创建和处理平衡数据集。本文将深入探讨如何使用 Scikit-learn 在 Python 中构建平衡数据集，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在机器学习领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。Scikit-learn 是 Python 中一个强大的机器学习库，提供了多种方法来创建和处理平衡数据集。本文将深入探讨如何使用 Scikit-learn 在 Python 中构建平衡数据集，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是平衡数据集
    - 不平衡数据集的问题
2. **使用方法**
    - 随机欠采样
    - 随机过采样
    - SMOTE（ Synthetic Minority Over-sampling Technique）
3. **常见实践**
    - 数据集划分与平衡处理顺序
    - 评估指标的选择
4. **最佳实践**
    - 结合多种方法
    - 交叉验证中的平衡处理
5. **代码示例**
    - 随机欠采样示例
    - 随机过采样示例
    - SMOTE 示例
6. **小结**
7. **参考资料**

## 基础概念

### 什么是平衡数据集
平衡数据集指的是数据集中各个类别（标签）的样本数量大致相等。例如，在一个二分类问题中，正类和负类的样本数量接近，这样的数据集就是平衡的。平衡数据集有助于模型学习到各类别的特征，避免模型过度偏向多数类。

### 不平衡数据集的问题
不平衡数据集可能带来以下问题：
- **模型性能偏差**：模型倾向于预测多数类，导致少数类的预测准确率很低。
- **泛化能力差**：模型在训练数据上表现良好，但在实际应用中对少数类的识别能力不足。

## 使用方法

### 随机欠采样
随机欠采样是从多数类中随机选择一部分样本，使得多数类和少数类的样本数量达到平衡。在 Scikit-learn 中，可以使用 `RandomUnderSampler` 类来实现。

### 随机过采样
随机过采样是通过复制少数类的样本，增加少数类的样本数量，从而实现数据集的平衡。Scikit-learn 提供了 `RandomOverSampler` 类来进行随机过采样。

### SMOTE（ Synthetic Minority Over-sampling Technique）
SMOTE 是一种更智能的过采样方法。它不是简单地复制少数类样本，而是通过在少数类样本的特征空间中生成新的合成样本，来增加少数类的样本数量。Scikit-learn 中的 `SMOTE` 类可以实现这一功能。

## 常见实践

### 数据集划分与平衡处理顺序
通常，在进行数据集划分（如训练集和测试集划分）之前进行平衡处理。这样可以确保训练集和测试集都具有平衡性，避免在测试集中出现严重的类别不平衡问题。

### 评估指标的选择
在处理不平衡数据集时，准确率不再是一个合适的评估指标。常用的评估指标包括精确率（Precision）、召回率（Recall）、F1 值（F1-Score）等。这些指标能够更全面地评估模型在不同类别上的性能。

## 最佳实践

### 结合多种方法
可以将欠采样和过采样方法结合使用。例如，先对多数类进行欠采样，然后对少数类进行过采样，以达到更好的平衡效果。

### 交叉验证中的平衡处理
在进行交叉验证时，需要在每个折叠（fold）中分别进行平衡处理，以确保模型在不同数据子集上都能得到公平的评估。

## 代码示例

### 随机欠采样示例
```python
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from imblearn.under_sampling import RandomUnderSampler

# 生成一个不平衡的数据集
X, y = make_classification(n_samples=1000, n_features=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1],
                           random_state=42)

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

### 随机过采样示例
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

### SMOTE 示例
```python
from imblearn.over_sampling import SMOTE

# SMOTE 过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

print("原始训练集多数类样本数:", sum(y_train == 0))
print("原始训练集少数类样本数:", sum(y_train == 1))
print("SMOTE 过采样后训练集多数类样本数:", sum(y_resampled == 0))
print("SMOTE 过采样后训练集少数类样本数:", sum(y_resampled == 1))
```

## 小结
构建平衡数据集是机器学习中的一个重要步骤，能够显著提高模型的性能和泛化能力。Scikit-learn 及其扩展库提供了丰富的工具来实现数据集的平衡处理。通过理解不同方法的原理和适用场景，并遵循常见实践和最佳实践，我们可以有效地处理不平衡数据集，为模型训练提供更好的数据基础。

## 参考资料
- 《Python 机器学习基础教程》
- 《Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow》