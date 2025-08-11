---
title: "Python 中的非数字值（Not a Number）"
description: "在 Python 编程中，处理数值数据时有时会遇到一些特殊情况，其中就包括非数字值（Not a Number，简称 NaN）。NaN 用于表示一个未定义或不可表示的值，在处理浮点数计算、数据缺失或某些特殊运算结果时经常会遇到它。理解如何在 Python 中处理 NaN 对于编写健壮的数据处理和科学计算代码至关重要。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，处理数值数据时有时会遇到一些特殊情况，其中就包括非数字值（Not a Number，简称 NaN）。NaN 用于表示一个未定义或不可表示的值，在处理浮点数计算、数据缺失或某些特殊运算结果时经常会遇到它。理解如何在 Python 中处理 NaN 对于编写健壮的数据处理和科学计算代码至关重要。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 检测 NaN
    - 创建 NaN
3. 常见实践
    - 数据清理中的 NaN 处理
    - 统计计算中的 NaN 处理
4. 最佳实践
    - 数据预处理时的 NaN 处理策略
    - 避免在计算中产生不必要的 NaN
5. 小结
6. 参考资料

## 基础概念
NaN 是一个浮点值，表示“不是一个数字”。它在 Python 中属于 `float` 数据类型。NaN 具有一些特殊的性质，例如任何与 NaN 进行的算术运算（加、减、乘、除等）结果仍然是 NaN，并且 NaN 与自身不相等。这意味着在比较时，不能简单地使用 `==` 来判断一个值是否为 NaN。

## 使用方法

### 检测 NaN
在 Python 中，可以使用 `math` 模块或 `numpy` 库来检测一个值是否为 NaN。

#### 使用 `math` 模块
```python
import math

num1 = float('nan')
num2 = 5

print(math.isnan(num1))  
print(math.isnan(num2))  
```

#### 使用 `numpy` 库
```python
import numpy as np

arr = np.array([1, np.nan, 3])

for num in arr:
    print(np.isnan(num))  
```

### 创建 NaN
可以通过多种方式创建 NaN 值。

#### 使用 `float('nan')`
```python
nan_value = float('nan')
print(nan_value)  
```

#### 使用 `numpy.nan`
```python
import numpy as np

nan_array = np.array([1, np.nan, 3])
print(nan_array)  
```

## 常见实践

### 数据清理中的 NaN 处理
在处理数据集时，经常会遇到包含 NaN 值的数据。常见的处理方法有删除包含 NaN 的行或列，或者填充 NaN 值。

#### 删除包含 NaN 的行
```python
import pandas as pd

data = {'col1': [1, np.nan, 3], 'col2': [4, 5, np.nan]}
df = pd.DataFrame(data)

cleaned_df = df.dropna()
print(cleaned_df)  
```

#### 填充 NaN 值
```python
import pandas as pd

data = {'col1': [1, np.nan, 3], 'col2': [4, 5, np.nan]}
df = pd.DataFrame(data)

filled_df = df.fillna(0)
print(filled_df)  
```

### 统计计算中的 NaN 处理
在进行统计计算时，NaN 值可能会影响结果。例如，计算平均值时，默认情况下 `numpy` 和 `pandas` 会忽略 NaN 值。

#### 使用 `numpy` 计算平均值
```python
import numpy as np

arr = np.array([1, np.nan, 3])
mean_value = np.nanmean(arr)
print(mean_value)  
```

#### 使用 `pandas` 计算平均值
```python
import pandas as pd

data = {'col1': [1, np.nan, 3]}
df = pd.DataFrame(data)
mean_value = df['col1'].mean()
print(mean_value)  
```

## 最佳实践

### 数据预处理时的 NaN 处理策略
在数据预处理阶段，应根据数据的特点和分析目的选择合适的 NaN 处理策略。如果数据集较大且 NaN 值较少，可以考虑删除包含 NaN 的行或列。但如果 NaN 值较多，删除可能会导致大量有价值的数据丢失，此时可以选择填充 NaN 值，填充方法可以根据数据的性质选择均值、中位数、众数等。

### 避免在计算中产生不必要的 NaN
在进行复杂的数值计算时，要注意避免出现除以零或其他可能导致 NaN 结果的运算。可以在进行运算前添加条件判断，确保数据的有效性。

```python
import numpy as np

a = 5
b = 0

if b != 0:
    result = a / b
else:
    result = np.nan
print(result)  
```

## 小结
NaN 在 Python 中是一个重要的概念，特别是在处理数值数据和科学计算时。理解如何检测、创建和处理 NaN 值对于编写高效、健壮的代码至关重要。通过合理运用 NaN 处理方法，可以更好地清理和分析数据，避免在计算中出现意外的结果。

## 参考资料
- [Python 官方文档 - math 模块](https://docs.python.org/3/library/math.html)
- [NumPy 官方文档](https://numpy.org/doc/)
- [Pandas 官方文档](https://pandas.pydata.org/docs/)