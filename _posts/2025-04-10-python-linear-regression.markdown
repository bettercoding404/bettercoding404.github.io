---
title: "Python 线性回归：从基础到实践"
description: "线性回归是一种广泛应用于统计学和机器学习领域的基本算法，用于建立一个变量（因变量）与一个或多个其他变量（自变量）之间的线性关系模型。在 Python 中，有多种库可以方便地实现线性回归。本文将深入探讨 Python 中线性回归的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一强大的工具。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
线性回归是一种广泛应用于统计学和机器学习领域的基本算法，用于建立一个变量（因变量）与一个或多个其他变量（自变量）之间的线性关系模型。在 Python 中，有多种库可以方便地实现线性回归。本文将深入探讨 Python 中线性回归的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一强大的工具。

<!-- more -->
## 目录
1. 线性回归基础概念
2. Python 中线性回归的使用方法
    - 使用 `numpy` 和 `scipy` 实现简单线性回归
    - 使用 `scikit - learn` 进行线性回归
3. 常见实践
    - 数据预处理
    - 模型评估
    - 交叉验证
4. 最佳实践
    - 特征工程
    - 处理多重共线性
    - 正则化
5. 小结
6. 参考资料

## 线性回归基础概念
线性回归假设因变量 $y$ 和自变量 $x_1, x_2, \cdots, x_n$ 之间存在线性关系，其数学模型可以表示为：

$$ y = \beta_0 + \beta_1x_1 + \beta_2x_2 + \cdots + \beta_nx_n + \epsilon $$

其中，$\beta_0$ 是截距，$\beta_1, \beta_2, \cdots, \beta_n$ 是回归系数，$\epsilon$ 是误差项。线性回归的目标是找到一组最佳的回归系数，使得预测值与实际值之间的误差最小。通常使用最小二乘法来估计回归系数，即最小化误差的平方和：

$$ \min_{\beta_0, \beta_1, \cdots, \beta_n} \sum_{i = 1}^{m} (y_i - (\beta_0 + \beta_1x_{i1} + \beta_2x_{i2} + \cdots + \beta_nx_{in}))^2 $$

其中，$m$ 是样本数量，$y_i$ 是第 $i$ 个样本的实际值，$x_{ij}$ 是第 $i$ 个样本的第 $j$ 个自变量的值。

## Python 中线性回归的使用方法

### 使用 `numpy` 和 `scipy` 实现简单线性回归
`numpy` 是 Python 中用于数值计算的基础库，`scipy` 则提供了更高级的科学计算功能。下面是使用这两个库实现简单线性回归（只有一个自变量）的示例：

```python
import numpy as np
from scipy import stats


# 生成一些示例数据
x = np.array([1, 2, 3, 4, 5])
y = np.array([2, 4, 5, 4, 6])

# 使用 scipy 的 linregress 函数进行线性回归
slope, intercept, r_value, p_value, std_err = stats.linregress(x, y)

print(f"斜率: {slope}")
print(f"截距: {intercept}")
print(f"相关系数: {r_value}")
print(f"p 值: {p_value}")
print(f"标准误差: {std_err}")

# 预测新的值
new_x = 6
predicted_y = slope * new_x + intercept
print(f"当 x = {new_x} 时，预测的 y 值为: {predicted_y}")
```

### 使用 `scikit - learn` 进行线性回归
`scikit - learn` 是 Python 中最常用的机器学习库之一，它提供了丰富的工具和算法。以下是使用 `scikit - learn` 进行多元线性回归的示例：

```python
from sklearn.linear_model import LinearRegression
import numpy as np


# 生成一些多元示例数据
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
y = np.array([2, 4, 6, 8])

# 创建线性回归模型并拟合数据
model = LinearRegression()
model.fit(X, y)

# 输出模型的系数和截距
print(f"系数: {model.coef_}")
print(f"截距: {model.intercept_}")

# 预测新的数据
new_X = np.array([[9, 10]])
predicted_y = model.predict(new_X)
print(f"预测的 y 值为: {predicted_y}")
```

## 常见实践

### 数据预处理
在进行线性回归之前，数据预处理是非常重要的步骤，包括数据清洗、缺失值处理、特征缩放等。例如，使用 `scikit - learn` 中的 `StandardScaler` 对数据进行标准化：

```python
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
import numpy as np


# 生成示例数据
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
y = np.array([2, 4, 6, 8])

# 数据标准化
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# 创建线性回归模型并拟合数据
model = LinearRegression()
model.fit(X_scaled, y)

# 输出模型的系数和截距
print(f"系数: {model.coef_}")
print(f"截距: {model.intercept_}")
```

### 模型评估
常用的线性回归模型评估指标有均方误差（MSE）、均方根误差（RMSE）、平均绝对误差（MAE）和 $R^2$ 分数。以下是使用 `scikit - learn` 计算这些指标的示例：

```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import numpy as np


# 生成示例数据
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
y = np.array([2, 4, 6, 8])

# 创建线性回归模型并拟合数据
model = LinearRegression()
model.fit(X, y)

# 预测数据
y_pred = model.predict(X)

# 计算评估指标
mse = mean_squared_error(y, y_pred)
rmse = np.sqrt(mse)
mae = mean_absolute_error(y, y_pred)
r2 = r2_score(y, y_pred)

print(f"均方误差 (MSE): {mse}")
print(f"均方根误差 (RMSE): {rmse}")
print(f"平均绝对误差 (MAE): {mae}")
print(f"R^2 分数: {r2}")
```

### 交叉验证
交叉验证是一种评估模型泛化能力的有效方法。`scikit - learn` 提供了多种交叉验证策略，例如 `KFold` 交叉验证：

```python
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import KFold
from sklearn.metrics import mean_squared_error
import numpy as np


# 生成示例数据
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
y = np.array([2, 4, 6, 8])

kf = KFold(n_splits = 3)
mse_scores = []

for train_index, test_index in kf.split(X):
    X_train, X_test = X[train_index], X[test_index]
    y_train, y_test = y[train_index], y[test_index]

    model = LinearRegression()
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)

    mse = mean_squared_error(y_test, y_pred)
    mse_scores.append(mse)

print(f"平均均方误差: {np.mean(mse_scores)}")
```

## 最佳实践

### 特征工程
特征工程是提高线性回归模型性能的关键步骤。这包括创建新的特征、组合现有特征、对特征进行变换等。例如，对数值特征进行多项式扩展：

```python
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
import numpy as np


# 生成示例数据
X = np.array([[1], [2], [3], [4], [5]])
y = np.array([2, 4, 6, 8, 10])

# 多项式特征扩展
poly = PolynomialFeatures(degree = 2)
X_poly = poly.fit_transform(X)

# 创建线性回归模型并拟合数据
model = LinearRegression()
model.fit(X_poly, y)

# 预测数据
y_pred = model.predict(X_poly)

# 计算均方误差
mse = mean_squared_error(y, y_pred)
print(f"均方误差: {mse}")
```

### 处理多重共线性
多重共线性是指自变量之间存在高度相关性的情况，这可能导致模型不稳定和系数估计不准确。可以使用方差膨胀因子（VIF）来检测多重共线性，并通过逐步回归、主成分分析等方法来处理。以下是使用 VIF 检测多重共线性的示例：

```python
import pandas as pd
from statsmodels.stats.outliers_influence import variance_inflation_factor


# 生成示例数据
data = pd.DataFrame({
    'x1': [1, 2, 3, 4, 5],
    'x2': [2, 4, 6, 8, 10],
    'x3': [3, 6, 9, 12, 15]
})

# 计算 VIF
vif = pd.DataFrame()
vif["特征"] = data.columns
vif["VIF"] = [variance_inflation_factor(data.values, i) for i in range(data.shape[1])]
print(vif)
```

### 正则化
正则化是一种防止模型过拟合的技术，在线性回归中常用的正则化方法有岭回归（Ridge Regression）和套索回归（Lasso Regression）。`scikit - learn` 提供了相应的实现：

```python
from sklearn.linear_model import Ridge, Lasso
import numpy as np


# 生成示例数据
X = np.array([[1, 2], [3, 4], [5, 6], [7, 8]])
y = np.array([2, 4, 6, 8])

# 岭回归
ridge = Ridge(alpha = 0.1)
ridge.fit(X, y)
print(f"岭回归系数: {ridge.coef_}")

# 套索回归
lasso = Lasso(alpha = 0.1)
lasso.fit(X, y)
print(f"套索回归系数: {lasso.coef_}")
```

## 小结
本文全面介绍了 Python 中线性回归的相关知识，包括基础概念、使用不同库的实现方法、常见实践以及最佳实践。通过数据预处理、模型评估、交叉验证等常见实践，可以确保模型的准确性和可靠性；而特征工程、处理多重共线性和正则化等最佳实践则有助于进一步提升模型性能。希望读者通过本文的学习，能够熟练运用线性回归解决实际问题。

## 参考资料
- 《Python 数据分析实战》
- 《机器学习：基于 scikit - learn、Keras 和 TensorFlow》