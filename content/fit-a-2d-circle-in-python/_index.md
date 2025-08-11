---
title: "在 Python 中拟合二维圆"
description: "在许多科学和工程领域，例如计算机视觉、机器人运动分析、数据分析等，我们经常需要从一组二维数据点中拟合出一个圆。在 Python 中，有多种方法可以实现这一任务。本文将深入探讨二维圆拟合的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握在 Python 中进行二维圆拟合的技巧。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在许多科学和工程领域，例如计算机视觉、机器人运动分析、数据分析等，我们经常需要从一组二维数据点中拟合出一个圆。在 Python 中，有多种方法可以实现这一任务。本文将深入探讨二维圆拟合的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握在 Python 中进行二维圆拟合的技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `scipy.optimize.curve_fit`
    - 使用 `least_squares` 方法
3. 常见实践
    - 数据生成与可视化
    - 噪声影响与处理
4. 最佳实践
    - 数据预处理
    - 选择合适的拟合方法
5. 小结
6. 参考资料

## 基础概念
二维圆的标准方程为 \((x - a)^2 + (y - b)^2 = r^2\)，其中 \((a, b)\) 是圆心坐标，\(r\) 是半径。拟合二维圆的目标是根据给定的一组二维数据点 \((x_i, y_i)\)，找到最优的参数 \(a\)、\(b\) 和 \(r\)，使得这些点尽可能地落在拟合出的圆上。通常使用最小二乘法来衡量拟合的优劣，即最小化所有数据点到拟合圆的距离平方和。

## 使用方法

### 使用 `scipy.optimize.curve_fit`
`scipy.optimize.curve_fit` 是 SciPy 库中用于曲线拟合的函数。我们首先需要定义一个圆的方程函数，然后使用 `curve_fit` 进行拟合。

```python
import numpy as np
from scipy.optimize import curve_fit
import matplotlib.pyplot as plt


def circle_eqn(points, a, b, r):
    x, y = points
    return np.sqrt((x - a) ** 2 + (y - b) ** 2) - r


# 生成一些示例数据
true_a, true_b, true_r = 2, 3, 4
theta = np.linspace(0, 2 * np.pi, 100)
x_true = true_a + true_r * np.cos(theta)
y_true = true_b + true_r * np.sin(theta)

# 添加一些噪声
noise = 0.5
x_noisy = x_true + np.random.normal(0, noise, len(x_true))
y_noisy = y_true + np.random.normal(0, noise, len(y_true))

initial_guess = [1, 1, 1]  # 初始猜测值
p0 = initial_guess
popt, pcov = curve_fit(circle_eqn, (x_noisy, y_noisy), np.zeros(len(x_noisy)), p0=p0)

fitted_a, fitted_b, fitted_r = popt
print(f"拟合的圆心坐标: ({fitted_a}, {fitted_b}), 半径: {fitted_r}")

# 可视化结果
plt.scatter(x_noisy, y_noisy, label='带噪声的数据点')
circle = plt.Circle((fitted_a, fitted_b), fitted_r, color='r', fill=False, label='拟合的圆')
ax = plt.gca()
ax.add_artist(circle)
plt.legend()
plt.show()
```

### 使用 `least_squares` 方法
`scipy.optimize.least_squares` 也可以用于圆的拟合，它通过最小化残差平方和来找到最优参数。

```python
from scipy.optimize import least_squares


def circle_residuals(params, x, y):
    a, b, r = params
    return np.sqrt((x - a) ** 2 + (y - b) ** 2) - r


# 使用 least_squares 进行拟合
initial_guess = [1, 1, 1]
result = least_squares(circle_residuals, initial_guess, args=(x_noisy, y_noisy))
fitted_a, fitted_b, fitted_r = result.x
print(f"拟合的圆心坐标: ({fitted_a}, {fitted_b}), 半径: {fitted_r}")

# 可视化结果
plt.scatter(x_noisy, y_noisy, label='带噪声的数据点')
circle = plt.Circle((fitted_a, fitted_b), fitted_r, color='g', fill=False, label='拟合的圆 (least_squares)')
ax = plt.gca()
ax.add_artist(circle)
plt.legend()
plt.show()
```

## 常见实践

### 数据生成与可视化
在实际应用中，我们需要生成或获取真实的数据，并进行可视化以便更好地理解数据分布。上述代码中已经展示了如何生成带噪声的圆形数据，并使用 `matplotlib` 进行可视化。

### 噪声影响与处理
噪声会对拟合结果产生影响。如上述代码所示，添加噪声后，拟合结果会与真实值有一定偏差。处理噪声的方法包括使用滤波技术（如高斯滤波）对数据进行预处理，或者增加数据点的数量以提高拟合的稳定性。

## 最佳实践

### 数据预处理
在进行拟合之前，对数据进行预处理是很重要的。这包括去除异常值、对数据进行归一化等操作。异常值可能会极大地影响拟合结果，而归一化可以加快优化算法的收敛速度。

### 选择合适的拟合方法
不同的拟合方法在不同的数据集上可能有不同的表现。`curve_fit` 适用于简单的函数拟合，而 `least_squares` 更灵活，可以处理更复杂的残差函数。在实际应用中，需要根据数据特点和问题的复杂度选择合适的方法。

## 小结
本文介绍了在 Python 中拟合二维圆的基础概念、使用方法、常见实践以及最佳实践。通过 `scipy.optimize` 库中的 `curve_fit` 和 `least_squares` 函数，我们可以有效地从二维数据点中拟合出圆的参数。在实际应用中，数据预处理和选择合适的拟合方法是提高拟合精度和稳定性的关键。

## 参考资料
- [SciPy 官方文档](https://docs.scipy.org/doc/scipy/reference/)
- [Matplotlib 官方文档](https://matplotlib.org/)