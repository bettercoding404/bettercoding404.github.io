---
title: "Python 将文本转换为 NumPy 数组"
description: "在数据处理和科学计算中，我们常常需要将文本数据转换为 NumPy 数组。NumPy 数组具有高效的存储和计算性能，能大大提升数据处理的速度。本文将详细介绍如何在 Python 中把文本转换为 NumPy 数组，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在数据处理和科学计算中，我们常常需要将文本数据转换为 NumPy 数组。NumPy 数组具有高效的存储和计算性能，能大大提升数据处理的速度。本文将详细介绍如何在 Python 中把文本转换为 NumPy 数组，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 从简单文本字符串转换
    - 从文本文件转换
3. 常见实践
    - 处理数值文本
    - 处理文本标签
4. 最佳实践
    - 内存优化
    - 数据类型指定
5. 小结
6. 参考资料

## 基础概念
### NumPy 数组
NumPy（Numerical Python）是 Python 中用于科学计算的核心库。NumPy 数组是一个多维的数值容器，所有元素必须是相同的数据类型，这使得它在存储和计算上非常高效。

### 文本数据
文本数据是一种常见的数据形式，它可以包含数字、字符、单词等。在将文本转换为 NumPy 数组时，我们需要根据文本的内容和结构进行相应的处理。

## 使用方法

### 从简单文本字符串转换
如果文本数据是一个简单的字符串，并且包含数值，我们可以使用以下步骤将其转换为 NumPy 数组。

```python
import numpy as np

# 简单文本字符串
text = "1 2 3 4 5"

# 将字符串按空格分割成列表
text_list = text.split()

# 将列表中的元素转换为数值并创建 NumPy 数组
arr = np.array([int(num) for num in text_list])

print(arr)
```

### 从文本文件转换
当文本数据存储在文件中时，我们可以使用 `numpy.loadtxt()` 函数。

```python
import numpy as np

# 假设文本文件 data.txt 内容为：
# 1 2 3
# 4 5 6
arr = np.loadtxt('data.txt')

print(arr)
```

## 常见实践

### 处理数值文本
如果文本文件中的数值数据包含缺失值，我们可以使用 `numpy.genfromtxt()` 函数，并指定缺失值的表示方式。

```python
import numpy as np

# 假设文本文件 data_with_missing.txt 内容为：
# 1 2 3
# 4 5 NaN
arr = np.genfromtxt('data_with_missing.txt', filling_values=np.nan)

print(arr)
```

### 处理文本标签
当文本数据包含标签时，我们可以先将标签和数值分开处理。

```python
import numpy as np

# 假设文本文件 data_with_labels.txt 内容为：
# label1 1 2 3
# label2 4 5 6
with open('data_with_labels.txt') as f:
    lines = f.readlines()

labels = []
data = []
for line in lines:
    parts = line.split()
    labels.append(parts[0])
    data.append([float(num) for num in parts[1:]])

data_arr = np.array(data)

print(labels)
print(data_arr)
```

## 最佳实践

### 内存优化
在处理大型文本数据时，内存管理非常重要。可以使用 `numpy.memmap()` 函数，它可以将数据存储在磁盘上，而不是全部加载到内存中。

```python
import numpy as np

# 创建一个内存映射文件
mmap_arr = np.memmap('large_data.dat', dtype='float64', mode='w+', shape=(1000000, 10))

# 可以像操作普通 NumPy 数组一样操作 mmap_arr
mmap_arr[0, 0] = 1.0

# 关闭内存映射
mmap_arr.flush()
del mmap_arr
```

### 数据类型指定
在转换文本为 NumPy 数组时，明确指定数据类型可以提高效率和避免错误。

```python
import numpy as np

# 假设文本文件 data.txt 内容为数值
arr = np.loadtxt('data.txt', dtype=np.int32)

print(arr.dtype)
```

## 小结
通过本文，我们学习了在 Python 中将文本转换为 NumPy 数组的基础概念、多种使用方法、常见实践以及最佳实践。在实际应用中，我们需要根据文本数据的特点和需求选择合适的方法，并注意内存管理和数据类型指定，以提高数据处理的效率和准确性。

## 参考资料
- [NumPy 官方文档](https://numpy.org/doc/){: rel="nofollow"}
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}