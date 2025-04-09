---
title: "在Python的scikit-learn中创建平衡数据集"
description: "在机器学习任务中，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型对多数类的过度拟合，而对少数类的预测效果不佳。scikit-learn（sklearn）作为Python中广泛使用的机器学习库，提供了多种方法来创建和处理平衡数据集。本文将深入探讨在sklearn中创建平衡数据集的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在机器学习任务中，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型对多数类的过度拟合，而对少数类的预测效果不佳。scikit-learn（sklearn）作为Python中广泛使用的机器学习库，提供了多种方法来创建和处理平衡数据集。本文将深入探讨在sklearn中创建平衡数据集的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 不平衡数据集的问题
    - 平衡数据集的重要性
2. **使用方法**
    - 随机欠采样
    - 随机过采样
    - SMOTE（ Synthetic Minority Over-sampling Technique）
3. **常见实践**
    - 处理类别型数据
    - 结合多种采样方法
4. **最佳实践**
    - 评估平衡效果
    - 交叉验证中的平衡
5. **代码示例**
    - 随机欠采样示例
    - 随机过采样示例
    - SMOTE示例
6. **小结**
7. **参考资料**

## 基础概念
### 不平衡数据集的问题
不平衡数据集指的是数据集中不同类别的样本数量存在显著差异。例如，在一个医疗诊断数据集中，患有某种疾病的样本可能只有少数几个，而健康样本数量众多。这种不平衡会导致模型在训练过程中倾向于多数类，因为多数类在损失函数计算中占据主导地位。结果是模型对少数类的识别能力较差，在实际应用中可能会遗漏重要信息。

### 平衡数据集的重要性
平衡数据集能够提升模型的泛化能力，使模型在不同类别的样本上都能有较好的预测表现。通过平衡数据集，可以避免模型过度关注多数类，从而更准确地捕捉少数类的特征和模式，提高整体的分类性能，特别是在对少数类的识别上。

## 使用方法
### 随机欠采样
随机欠采样是一种简单的方法，通过随机删除多数类的样本，使得数据集达到平衡。在sklearn中，可以使用`RandomUnderSampler`类来实现。

### 随机过采样
随机过采样则是通过复制少数类的样本，增加少数类的样本数量，从而实现数据集的平衡。`RandomOverSampler`类可以用于此目的。

### SMOTE（ Synthetic Minority Over-sampling Technique）
SMOTE是一种更复杂的过采样方法，它不是简单地复制少数类样本，而是通过在少数类样本的特征空间中生成新的合成样本。SMOTE能够避免简单复制带来的过拟合问题，生成更具代表性的样本。在`imblearn`库（与sklearn兼容）中，可以使用`SMOTE`类来实现。

## 常见实践
### 处理类别型数据
在处理包含类别型数据的数据集时，需要特别注意采样方法的适用性。一些采样方法可能需要对类别型数据进行编码（如独热编码），以确保正确的处理。在使用`RandomUnderSampler`或`RandomOverSampler`时，需要确保编码后的特征矩阵与标签向量正确对应。

### 结合多种采样方法
有时单一的采样方法可能无法达到理想的平衡效果。可以结合欠采样和过采样方法，例如先对多数类进行欠采样，然后对少数类进行SMOTE过采样，以获得更好的数据集平衡。

## 最佳实践
### 评估平衡效果
在应用采样方法后，需要评估数据集的平衡效果。可以使用类别比例、基尼系数等指标来衡量数据集的平衡性。同时，通过模型在平衡后数据集上的性能表现（如准确率、召回率、F1值等）来验证平衡的有效性。

### 交叉验证中的平衡
在进行交叉验证时，需要确保每个折叠（fold）中的数据集都是平衡的。可以在每次折叠时应用采样方法，或者使用分层交叉验证（Stratified KFold），它能够保证每个折叠中各类别的比例与原始数据集相似。

## 代码示例
### 随机欠采样示例
```python
from sklearn.datasets import make_classification
from imblearn.under_sampling import RandomUnderSampler
import numpy as np

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=10,
                           n_clusters_per_class=2, weights=[0.9, 0.1],
                           random_state=42)

# 初始化随机欠采样器
undersampler = RandomUnderSampler(random_state=42)

# 对数据集进行欠采样
X_resampled, y_resampled = undersampler.fit_resample(X, y)

print("原始数据集样本数量：", len(y))
print("欠采样后数据集样本数量：", len(y_resampled))
print("原始数据集中少数类样本数量：", np.sum(y == 1))
print("欠采样后数据集中少数类样本数量：", np.sum(y_resampled == 1))
```

### 随机过采样示例
```python
from imblearn.over_sampling import RandomOverSampler

# 初始化随机过采样器
oversampler = RandomOverSampler(random_state=42)

# 对数据集进行过采样
X_resampled, y_resampled = oversampler.fit_resample(X, y)

print("原始数据集样本数量：", len(y))
print("过采样后数据集样本数量：", len(y_resampled))
print("原始数据集中少数类样本数量：", np.sum(y == 1))
print("过采样后数据集中少数类样本数量：", np.sum(y_resampled == 1))
```

### SMOTE示例
```python
from imblearn.over_sampling import SMOTE

# 初始化SMOTE
smote = SMOTE(random_state=42)

# 对数据集进行SMOTE过采样
X_resampled, y_resampled = smote.fit_resample(X, y)

print("原始数据集样本数量：", len(y))
print("SMOTE过采样后数据集样本数量：", len(y_resampled))
print("原始数据集中少数类样本数量：", np.sum(y == 1))
print("SMOTE过采样后数据集中少数类样本数量：", np.sum(y_resampled == 1))
```

## 小结
在Python的scikit-learn中创建平衡数据集是提高机器学习模型性能的重要步骤。通过理解不平衡数据集的问题和平衡数据集的重要性，掌握随机欠采样、随机过采样和SMOTE等方法，以及遵循常见实践和最佳实践，能够有效地处理不平衡数据，提升模型在各类别上的预测能力。在实际应用中，需要根据数据集的特点和任务需求选择合适的采样方法，并通过评估和验证确保平衡效果。

## 参考资料
- 《Python Machine Learning》 - Sebastian Raschka, Vahid Mirjalili