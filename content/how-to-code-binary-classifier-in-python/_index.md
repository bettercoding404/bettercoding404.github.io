---
title: "如何在 Python 中编写二元分类器"
description: "在机器学习领域，二元分类是一项基础且重要的任务。它旨在将数据样本分为两个不同的类别。Python 作为数据科学和机器学习中最常用的编程语言之一，提供了丰富的库和工具来实现二元分类器。本文将详细介绍如何在 Python 中编写二元分类器，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在机器学习领域，二元分类是一项基础且重要的任务。它旨在将数据样本分为两个不同的类别。Python 作为数据科学和机器学习中最常用的编程语言之一，提供了丰富的库和工具来实现二元分类器。本文将详细介绍如何在 Python 中编写二元分类器，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 数据集准备
    - 选择分类算法
    - 模型训练与评估
3. 常见实践
    - 处理不平衡数据集
    - 特征工程
4. 最佳实践
    - 模型调优
    - 交叉验证
5. 小结
6. 参考资料

## 基础概念
### 二元分类
二元分类是将输入数据实例分配到两个可能类别之一的任务。例如，预测一封电子邮件是垃圾邮件还是非垃圾邮件，或者预测一个肿瘤是良性还是恶性。

### 分类算法
有多种算法可用于二元分类，如逻辑回归、决策树、支持向量机（SVM）、朴素贝叶斯等。每种算法都有其独特的优缺点和适用场景。

### 评估指标
为了评估二元分类器的性能，常用的指标包括准确率（Accuracy）、精确率（Precision）、召回率（Recall）、F1 值（F1-Score）等。
 - **准确率**：正确分类的样本数占总样本数的比例。
 - **精确率**：在所有预测为正类的样本中，实际为正类的比例。
 - **召回率**：在所有实际为正类的样本中，被正确预测为正类的比例。
 - **F1 值**：精确率和召回率的调和平均数，综合反映了模型的性能。

## 使用方法
### 数据集准备
在编写二元分类器之前，需要准备好数据集。通常，数据集分为训练集和测试集。训练集用于训练模型，测试集用于评估模型的性能。

```python
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split

# 加载乳腺癌数据集
data = load_breast_cancer()
X = data.data
y = data.target

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```

### 选择分类算法
这里以逻辑回归为例，展示如何使用 Scikit-learn 库实现二元分类器。

```python
from sklearn.linear_model import LogisticRegression

# 创建逻辑回归模型
model = LogisticRegression()

# 训练模型
model.fit(X_train, y_train)

# 进行预测
y_pred = model.predict(X_test)
```

### 模型训练与评估
训练完模型后，需要对其进行评估。

```python
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score

# 计算评估指标
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

print(f"准确率: {accuracy}")
print(f"精确率: {precision}")
print(f"召回率: {recall}")
print(f"F1 值: {f1}")
```

## 常见实践
### 处理不平衡数据集
在实际应用中，数据集可能存在类别不平衡的问题，即一个类别的样本数量远多于另一个类别。这可能导致模型在少数类上的性能较差。常见的处理方法包括：
 - **过采样**：增加少数类的样本数量，如 SMOTE 算法。
 - **欠采样**：减少多数类的样本数量。

```python
from imblearn.over_sampling import SMOTE

# 使用 SMOTE 进行过采样
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X_train, y_train)

# 重新训练模型
model.fit(X_resampled, y_resampled)
y_pred_resampled = model.predict(X_test)

# 计算评估指标
accuracy_resampled = accuracy_score(y_test, y_pred_resampled)
precision_resampled = precision_score(y_test, y_pred_resampled)
recall_resampled = recall_score(y_test, y_pred_resampled)
f1_resampled = f1_score(y_test, y_pred_resampled)

print(f"过采样后准确率: {accuracy_resampled}")
print(f"过采样后精确率: {precision_resampled}")
print(f"过采样后召回率: {recall_resampled}")
print(f"过采样后 F1 值: {f1_resampled}")
```

### 特征工程
特征工程是指对原始数据进行转换和提取，以创建更有效的特征。这可以提高模型的性能。常见的特征工程方法包括：
 - **标准化**：使数据具有零均值和单位方差。
 - **特征选择**：选择最相关的特征，减少噪声和维度。

```python
from sklearn.preprocessing import StandardScaler
from sklearn.feature_selection import SelectKBest, f_classif

# 标准化特征
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 特征选择
selector = SelectKBest(score_func=f_classif, k=10)
X_train_selected = selector.fit_transform(X_train_scaled, y_train)
X_test_selected = selector.transform(X_test_scaled)

# 训练模型
model.fit(X_train_selected, y_train)
y_pred_selected = model.predict(X_test_selected)

# 计算评估指标
accuracy_selected = accuracy_score(y_test, y_pred_selected)
precision_selected = precision_score(y_test, y_pred_selected)
recall_selected = recall_score(y_test, y_pred_selected)
f1_selected = f1_score(y_test, y_pred_selected)

print(f"特征工程后准确率: {accuracy_selected}")
print(f"特征工程后精确率: {precision_selected}")
print(f"特征工程后召回率: {recall_selected}")
print(f"特征工程后 F1 值: {f1_selected}")
```

## 最佳实践
### 模型调优
通过调整模型的超参数，可以提高模型的性能。常见的调优方法包括网格搜索（Grid Search）和随机搜索（Random Search）。

```python
from sklearn.model_selection import GridSearchCV

# 定义超参数搜索空间
param_grid = {
    'C': [0.01, 0.1, 1, 10, 100],
    'penalty': ['l1', 'l2']
}

# 使用网格搜索进行模型调优
grid_search = GridSearchCV(LogisticRegression(), param_grid, cv=5)
grid_search.fit(X_train, y_train)

# 输出最佳超参数和最佳模型
best_params = grid_search.best_params_
best_model = grid_search.best_estimator_

print(f"最佳超参数: {best_params}")

# 使用最佳模型进行预测
y_pred_best = best_model.predict(X_test)

# 计算评估指标
accuracy_best = accuracy_score(y_test, y_pred_best)
precision_best = precision_score(y_test, y_pred_best)
recall_best = recall_score(y_test, y_pred_best)
f1_best = f1_score(y_test, y_pred_best)

print(f"调优后准确率: {accuracy_best}")
print(f"调优后精确率: {precision_best}")
print(f"调优后召回率: {recall_best}")
print(f"调优后 F1 值: {f1_best}")
```

### 交叉验证
交叉验证是一种评估模型性能的有效方法，它将数据集分成多个子集，轮流将其中一个子集作为测试集，其余子集作为训练集，最后综合多个评估结果得到一个更可靠的性能指标。

```python
from sklearn.model_selection import cross_val_score

# 使用 5 折交叉验证评估模型
scores = cross_val_score(LogisticRegression(), X, y, cv=5)

print(f"交叉验证得分: {scores}")
print(f"平均交叉验证得分: {scores.mean()}")
```

## 小结
本文详细介绍了在 Python 中编写二元分类器的过程，包括基础概念、使用方法、常见实践和最佳实践。通过数据集准备、选择合适的分类算法、进行模型训练与评估，以及处理不平衡数据集、特征工程、模型调优等步骤，可以构建出性能良好的二元分类器。希望读者通过本文的学习，能够在实际项目中高效地应用二元分类技术。

## 参考资料
- [Scikit-learn 官方文档](https://scikit-learn.org/stable/)
- [Imbalanced-learn 官方文档](https://imbalanced-learn.org/stable/)
- 《Python 机器学习基础教程》