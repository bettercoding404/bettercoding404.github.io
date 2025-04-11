---
title: "Python 中的非数字值（Not a Number, NaN）"
description: "在 Python 的数值计算和数据处理中，经常会遇到一些特殊的值，其中之一就是“非数字”（Not a Number，简称 NaN）。NaN 用于表示那些无法表示为有效数字的值，例如 0 除以 0 的结果。理解 NaN 在 Python 中的概念、使用方法以及处理方式，对于编写健壮的数据处理和科学计算代码至关重要。本文将深入探讨 Python 中 NaN 的相关知识，帮助读者更好地掌握这一特殊值。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的数值计算和数据处理中，经常会遇到一些特殊的值，其中之一就是“非数字”（Not a Number，简称 NaN）。NaN 用于表示那些无法表示为有效数字的值，例如 0 除以 0 的结果。理解 NaN 在 Python 中的概念、使用方法以及处理方式，对于编写健壮的数据处理和科学计算代码至关重要。本文将深入探讨 Python 中 NaN 的相关知识，帮助读者更好地掌握这一特殊值。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 生成 NaN
    - 检测 NaN
3. 常见实践
    - 处理包含 NaN 的数据
    - 在数值计算中遇到 NaN
4. 最佳实践
    - 数据清洗中的 NaN 处理
    - 避免产生意外的 NaN
5. 小结
6. 参考资料

## 基础概念
NaN 是一个特殊的浮点数值，用于表示无效的、未定义的或无法计算的数值结果。在数学运算中，某些操作没有明确的数值答案，例如 0 除以 0，或者对负数取平方根（在实数范围内）。在 Python 中，当执行这些操作时，结果通常会返回 NaN。

NaN 具有一些特殊的性质：
- 它与任何其他数字（包括自身）进行比较都返回 `False`。例如，`nan == nan` 返回 `False`，这与普通数字的比较行为不同。
- 它在数学运算中具有传播性。如果一个运算涉及到 NaN，结果通常也是 NaN。

## 使用方法

### 生成 NaN
在 Python 中，可以通过多种方式生成 NaN。

**使用 `float('nan')`**
```python
nan_value = float('nan')
print(nan_value)  
```

**使用 `numpy` 库**
如果安装了 `numpy` 库，可以使用 `numpy.nan` 来生成 NaN。
```python
import numpy as np

nan_from_numpy = np.nan
print(nan_from_numpy)  
```

### 检测 NaN
检测一个值是否为 NaN 可以使用不同的方法，具体取决于是否使用了 `numpy` 库。

**不使用 `numpy` 库**
在标准 Python 中，可以使用 `math` 库的 `isnan()` 函数来检测一个值是否为 NaN。
```python
import math

test_value = float('nan')
if math.isnan(test_value):
    print("该值是 NaN")
```

**使用 `numpy` 库**
`numpy` 库提供了 `isnan()` 函数来检测数组中的元素是否为 NaN。
```python
import numpy as np

arr = np.array([1, np.nan, 3])
nan_indices = np.isnan(arr)
print(nan_indices)  
```

## 常见实践

### 处理包含 NaN 的数据
在数据处理中，经常会遇到包含 NaN 的数据集。常见的处理方式有以下几种：

**删除包含 NaN 的行或列**
在 `pandas` 库中，可以使用 `dropna()` 方法来删除包含 NaN 的行或列。
```python
import pandas as pd

data = {'col1': [1, np.nan, 3], 'col2': [4, 5, np.nan]}
df = pd.DataFrame(data)

# 删除包含 NaN 的行
df_dropped_rows = df.dropna(axis=0)  
print(df_dropped_rows)

# 删除包含 NaN 的列
df_dropped_cols = df.dropna(axis=1)  
print(df_dropped_cols)
```

**填充 NaN 值**
可以使用 `fillna()` 方法用特定的值填充 NaN。
```python
# 用 0 填充 NaN
df_filled_with_zero = df.fillna(0)
print(df_filled_with_zero)

# 用前一个值填充 NaN
df_filled_with_prev = df.fillna(method='ffill')
print(df_filled_with_prev)
```

### 在数值计算中遇到 NaN
在数值计算中，如果结果包含 NaN，可能会影响后续的计算。需要根据具体情况进行处理。
```python
import numpy as np

arr = np.array([1, np.nan, 3])

# 计算数组的和，结果会是 NaN
sum_with_nan = np.sum(arr)
print(sum_with_nan)  

# 忽略 NaN 计算和
sum_ignoring_nan = np.nansum(arr)
print(sum_ignoring_nan)  
```

## 最佳实践

### 数据清洗中的 NaN 处理
在数据清洗阶段，应该根据数据的性质和用途选择合适的 NaN 处理方法：
- 如果数据集中 NaN 占比很小，可以考虑删除包含 NaN 的行或列。
- 如果 NaN 较多，可以尝试使用合理的值填充，例如均值、中位数或众数。对于时间序列数据，使用前一个值或后一个值填充可能是合适的。

### 避免产生意外的 NaN
在编写代码时，要注意避免产生意外的 NaN。例如，在进行除法运算时，要确保除数不为零。
```python
a = 5
b = 0
try:
    result = a / b
except ZeroDivisionError:
    result = float('nan')
    print("发生除零错误，结果设为 NaN")
```

## 小结
NaN 在 Python 的数据处理和数值计算中是一个重要的概念。了解如何生成、检测和处理 NaN 对于编写高效、健壮的代码至关重要。在实际应用中，要根据具体情况选择合适的方法来处理包含 NaN 的数据，同时尽量避免在计算过程中产生意外的 NaN。

## 参考资料