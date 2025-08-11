---
title: "利用Python的Scikit-learn创建平衡数据集"
description: "在机器学习和数据挖掘领域，数据集的平衡性对模型的性能有着至关重要的影响。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现欠佳。本文将深入探讨如何使用Python的Scikit-learn库来创建平衡数据集，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在机器学习和数据挖掘领域，数据集的平衡性对模型的性能有着至关重要的影响。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现欠佳。本文将深入探讨如何使用Python的Scikit-learn库来创建平衡数据集，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 不平衡数据集的问题
    - 平衡数据集的重要性
2. **使用方法**
    - 过采样技术
    - 欠采样技术
3. **常见实践**
    - 示例数据集准备
    - 过采样实践
    - 欠采样实践
4. **最佳实践**
    - 结合过采样和欠采样
    - 评估平衡后数据集的效果
5. **小结**
6. **参考资料**

## 基础概念
### 不平衡数据集的问题
不平衡数据集是指数据集中不同类别的样本数量存在显著差异。例如，在一个预测疾病的数据集中，健康样本可能占绝大多数，而患病样本则很少。这种不平衡会导致模型在训练过程中倾向于多数类，从而对少数类的识别能力较差。

### 平衡数据集的重要性
平衡数据集可以提高模型的泛化能力，使模型对所有类别都能进行准确的预测。平衡后的数据集有助于避免模型过拟合多数类，增强对少数类的捕捉能力，从而提升整体模型性能。

## 使用方法
### 过采样技术
过采样是指增加少数类样本数量，使其与多数类样本数量接近。Scikit-learn中的`imblearn`库提供了多种过采样方法，如`SMOTE`（Synthetic Minority Over-sampling Technique）。

```python
from imblearn.over_sampling import SMOTE
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=10,
                           weights=[0.9, 0.1], random_state=42)

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 使用SMOTE进行过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)
```

### 欠采样技术
欠采样是指减少多数类样本数量，以达到数据集平衡的目的。例如，`RandomUnderSampler`可以随机删除多数类样本。

```python
from imblearn.under_sampling import RandomUnderSampler

# 使用RandomUnderSampler进行欠采样
undersampler = RandomUnderSampler(random_state=42)
X_resampled_under, y_resampled_under = undersampler.fit_resample(X_train, y_train)
```

## 常见实践
### 示例数据集准备
我们首先生成一个不平衡的分类数据集。

```python
from sklearn.datasets import make_classification
import pandas as pd

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=20,
                           n_informative=10, n_redundant=10,
                           weights=[0.9, 0.1], random_state=42)

# 将数据转换为DataFrame格式以便查看
data = pd.DataFrame(X)
data['target'] = y
print(data['target'].value_counts())
```

### 过采样实践
使用`SMOTE`对训练集进行过采样。

```python
from imblearn.over_sampling import SMOTE
from sklearn.model_selection import train_test_split

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 使用SMOTE进行过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

print(pd.Series(y_resampled).value_counts())
```

### 欠采样实践
使用`RandomUnderSampler`对训练集进行欠采样。

```python
from imblearn.under_sampling import RandomUnderSampler

# 使用RandomUnderSampler进行欠采样
undersampler = RandomUnderSampler(random_state=42)
X_resampled_under, y_resampled_under = undersampler.fit_resample(X_train, y_train)

print(pd.Series(y_resampled_under).value_counts())
```

## 最佳实践
### 结合过采样和欠采样
可以先使用欠采样减少多数类样本数量，再使用过采样增加少数类样本数量，以达到更好的平衡效果。

```python
from imblearn.pipeline import Pipeline
from imblearn.under_sampling import RandomUnderSampler
from imblearn.over_sampling import SMOTE

# 创建结合欠采样和过采样的管道
pipeline = Pipeline([
    ('under', RandomUnderSampler(random_state=42)),
    ('over', SMOTE(random_state=42))
])

X_resampled_combined, y_resampled_combined = pipeline.fit_resample(X_train, y_train)

print(pd.Series(y_resampled_combined).value_counts())
```

### 评估平衡后数据集的效果
使用平衡后的数据集训练模型，并通过合适的评估指标（如F1值、召回率等）来评估模型性能。

```python
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import f1_score

# 使用平衡后的数据集训练模型
model = DecisionTreeClassifier(random_state=42)
model.fit(X_resampled_combined, y_resampled_combined)

# 预测测试集
y_pred = model.predict(X_test)

# 评估模型
f1 = f1_score(y_test, y_pred)
print(f"F1 Score: {f1}")
```

## 小结
通过本文，我们了解了不平衡数据集的问题以及平衡数据集的重要性。在Scikit-learn中，我们学习了过采样和欠采样技术的使用方法，并通过实践展示了如何应用这些技术来创建平衡数据集。最佳实践部分介绍了结合过采样和欠采样以及评估平衡效果的方法，帮助读者更好地处理不平衡数据集问题，提升模型性能。

## 参考资料