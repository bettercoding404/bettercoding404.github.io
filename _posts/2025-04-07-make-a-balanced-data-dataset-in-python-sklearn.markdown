---
title: "在Python的scikit - learn中创建平衡数据集"
description: "在机器学习和数据挖掘领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。scikit - learn是Python中广泛使用的机器学习库，它提供了多种方法来处理不平衡数据集，创建平衡数据集。本文将深入探讨在scikit - learn中创建平衡数据集的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在机器学习和数据挖掘领域，数据集的平衡性对于模型的性能和泛化能力至关重要。不平衡的数据集可能导致模型在多数类上表现良好，但在少数类上表现不佳。scikit - learn是Python中广泛使用的机器学习库，它提供了多种方法来处理不平衡数据集，创建平衡数据集。本文将深入探讨在scikit - learn中创建平衡数据集的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - 不平衡数据集的问题
    - 平衡数据集的重要性
2. **使用方法**
    - 随机欠采样
    - 随机过采样
    - SMOTE（合成少数类过采样技术）
3. **常见实践**
    - 处理分类问题中的不平衡数据
    - 结合不同方法创建平衡数据集
4. **最佳实践**
    - 数据预处理前的探索性分析
    - 评估指标的选择
    - 交叉验证中的数据集平衡
5. **代码示例**
    - 随机欠采样示例
    - 随机过采样示例
    - SMOTE示例
6. **小结**
7. **参考资料**

## 基础概念
### 不平衡数据集的问题
不平衡数据集是指数据集中不同类别的样本数量存在显著差异。例如，在一个医疗诊断数据集中，可能95%的样本是健康的，而只有5%的样本是患病的。这种不平衡会导致机器学习模型产生偏差，因为模型往往会偏向于多数类，对少数类的识别能力较差。

### 平衡数据集的重要性
平衡数据集可以提高模型的泛化能力，使模型在各个类别上都能有较好的表现。平衡数据集有助于减少模型过拟合多数类的风险，提升模型在少数类上的预测准确性，从而在实际应用中提供更可靠的预测结果。

## 使用方法
### 随机欠采样
随机欠采样是从多数类中随机选择一部分样本，使其数量与少数类样本数量相等。在scikit - learn中，可以使用`RandomUnderSampler`类来实现。
```python
from imblearn.under_sampling import RandomUnderSampler
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1],
                           random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 随机欠采样
undersampler = RandomUnderSampler(random_state=42)
X_resampled, y_resampled = undersampler.fit_resample(X_train, y_train)
```

### 随机过采样
随机过采样是通过复制少数类样本，使其数量与多数类样本数量相等。在scikit - learn中，可以使用`RandomOverSampler`类来实现。
```python
from imblearn.over_sampling import RandomOverSampler

# 随机过采样
oversampler = RandomOverSampler(random_state=42)
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)
```

### SMOTE（合成少数类过采样技术）
SMOTE不是简单地复制少数类样本，而是通过在少数类样本的特征空间中生成新的合成样本。在scikit - learn中，可以使用`SMOTE`类来实现。
```python
from imblearn.over_sampling import SMOTE

# SMOTE过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)
```

## 常见实践
### 处理分类问题中的不平衡数据
在分类问题中，不平衡数据可能导致模型对少数类的预测能力不足。通过上述的欠采样、过采样或SMOTE方法，可以调整数据集的平衡性，提高模型在少数类上的表现。例如，在信用卡欺诈检测中，欺诈交易通常是少数类，通过平衡数据集可以更好地识别欺诈行为。

### 结合不同方法创建平衡数据集
可以结合欠采样和过采样方法。例如，先使用欠采样减少多数类样本数量，再使用过采样或SMOTE增加少数类样本数量，以达到更好的平衡效果。

## 最佳实践
### 数据预处理前的探索性分析
在进行数据集平衡处理之前，进行探索性数据分析，了解数据的分布、特征之间的关系等。这有助于选择合适的平衡方法，避免过度处理数据。

### 评估指标的选择
在不平衡数据集上，准确率可能不是一个合适的评估指标，因为模型可以通过简单地预测多数类来获得较高的准确率。可以选择F1值、召回率、ROC曲线下面积（AUC）等指标来更准确地评估模型性能。

### 交叉验证中的数据集平衡
在进行交叉验证时，确保在每个折叠中都对数据集进行平衡处理，以避免数据泄露和确保模型评估的准确性。

## 代码示例
### 随机欠采样示例
```python
from imblearn.under_sampling import RandomUnderSampler
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import f1_score

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1],
                           random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 随机欠采样
undersampler = RandomUnderSampler(random_state=42)
X_resampled, y_resampled = undersampler.fit_resample(X_train, y_train)

# 训练模型
model = DecisionTreeClassifier(random_state=42)
model.fit(X_resampled, y_resampled)

# 评估模型
y_pred = model.predict(X_test)
print("随机欠采样后的F1值:", f1_score(y_test, y_pred))
```

### 随机过采样示例
```python
from imblearn.over_sampling import RandomOverSampler
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import f1_score

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1],
                           random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 随机过采样
oversampler = RandomOverSampler(random_state=42)
X_resampled, y_resampled = oversampler.fit_resample(X_train, y_train)

# 训练模型
model = DecisionTreeClassifier(random_state=42)
model.fit(X_resampled, y_resampled)

# 评估模型
y_pred = model.predict(X_test)
print("随机过采样后的F1值:", f1_score(y_test, y_pred))
```

### SMOTE示例
```python
from imblearn.over_sampling import SMOTE
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import f1_score

# 生成不平衡数据集
X, y = make_classification(n_samples=1000, n_features=2, n_redundant=0,
                           n_clusters_per_class=1, weights=[0.9, 0.1],
                           random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# SMOTE过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

# 训练模型
model = DecisionTreeClassifier(random_state=42)
model.fit(X_resampled, y_resampled)

# 评估模型
y_pred = model.predict(X_test)
print("SMOTE过采样后的F1值:", f1_score(y_test, y_pred))
```

## 小结
在Python的scikit - learn中创建平衡数据集是处理不平衡数据问题的重要步骤。通过随机欠采样、随机过采样和SMOTE等方法，可以有效地调整数据集的平衡性，提高模型的性能和泛化能力。在实际应用中，结合数据探索性分析、合适的评估指标选择以及交叉验证中的数据集平衡处理等最佳实践，能够更好地利用这些方法，为机器学习模型提供高质量的数据集。

## 参考资料