---
title: "利用 Python Scikit-learn 创建平衡数据集"
description: "在机器学习中，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。本文将详细介绍如何使用 Python 的 Scikit-learn 库来创建平衡数据集，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

# 利用 Python Scikit-learn 创建平衡数据集

## 简介
在机器学习中，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。本文将详细介绍如何使用 Python 的 Scikit-learn 库来创建平衡数据集，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 欠采样方法
    - 过采样方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
### 不平衡数据集
不平衡数据集指的是数据集中不同类别样本数量差异较大的情况。例如，在一个疾病预测的数据集中，健康样本数量远远多于患病样本数量。这种不平衡可能会使模型在训练过程中过度偏向多数类，从而忽略少数类的特征，导致模型对少数类的预测能力下降。

### 平衡数据集的重要性
平衡数据集有助于提高模型的泛化能力和公平性。通过平衡类别分布，可以确保模型对每个类别都能学习到足够的特征，从而在不同类别上都能做出准确的预测。这对于一些关键领域，如医疗诊断、欺诈检测等尤为重要。

## 使用方法
### 欠采样方法
欠采样是通过减少多数类样本数量来使数据集达到平衡的方法。Scikit-learn 中常用的欠采样方法是 `RandomUnderSampler`。

```python
from imblearn.under_sampling import RandomUnderSampler
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=10,
                           n_clusters_per_class=2, weights=[0.9, 0.1],
                           random_state=42)

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 初始化欠采样器
undersampler = RandomUnderSampler(random_state=42)

# 对训练集进行欠采样
X_resampled, y_resampled = undersampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数量:", sum(y_train == 0))
print("原始训练集少数类样本数量:", sum(y_train == 1))
print("欠采样后训练集多数类样本数量:", sum(y_resampled == 0))
print("欠采样后训练集少数类样本数量:", sum(y_resampled == 1))
```

### 过采样方法
过采样是通过增加少数类样本数量来平衡数据集的方法。Scikit-learn 中常用的过采样方法是 `RandomOverSampler` 和 `SMOTE`（Synthetic Minority Over-sampling Technique）。

#### RandomOverSampler
```python
from imblearn.over_sampling import RandomOverSampler

# 初始化过采样器
oversampler = RandomOverSampler(random_state=42)

# 对训练集进行过采样
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)

print("原始训练集多数类样本数量:", sum(y_train == 0))
print("原始训练集少数类样本数量:", sum(y_train == 1))
print("过采样后训练集多数类样本数量:", sum(y_resampled == 0))
print("过采样后训练集少数类样本数量:", sum(y_resampled == 1))
```

#### SMOTE
```python
from imblearn.over_sampling import SMOTE

# 初始化 SMOTE 过采样器
smote = SMOTE(random_state=42)

# 对训练集进行 SMOTE 过采样
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

print("原始训练集多数类样本数量:", sum(y_train == 0))
print("原始训练集少数类样本数量:", sum(y_train == 1))
print("SMOTE 过采样后训练集多数类样本数量:", sum(y_resampled == 0))
print("SMOTE 过采样后训练集少数类样本数量:", sum(y_resampled == 1))
```

## 常见实践
1. **结合欠采样和过采样**：在某些情况下，单独使用欠采样或过采样可能无法达到理想的效果。可以尝试先对多数类进行欠采样，然后对少数类进行过采样，以实现更好的平衡。
2. **分层采样**：在划分训练集和测试集时，使用分层采样（如 `stratify` 参数）可以确保训练集和测试集中各类别的比例与原始数据集相同，有助于评估模型在不平衡数据上的性能。

## 最佳实践
1. **数据探索**：在进行平衡操作之前，先对数据集进行全面的探索，了解数据的分布、特征等情况，以便选择合适的平衡方法。
2. **交叉验证**：在平衡数据集后，使用交叉验证来评估模型性能，确保模型的稳定性和泛化能力。
3. **多种方法尝试**：不同的数据集和任务可能适合不同的平衡方法，因此建议尝试多种方法，并根据评估指标选择最佳方案。

## 小结
通过使用 Scikit-learn 中的欠采样和过采样方法，可以有效地创建平衡数据集，提高模型在不平衡数据上的性能。在实际应用中，需要根据数据集的特点和任务需求选择合适的方法，并结合数据探索、交叉验证等步骤，以获得最佳的模型效果。

## 参考资料
- [Scikit-learn 官方文档](https://scikit-learn.org/stable/){: rel="nofollow"}
- [imbalanced-learn 官方文档](https://imbalanced-learn.org/stable/){: rel="nofollow"}
- 《Python 机器学习基础教程》