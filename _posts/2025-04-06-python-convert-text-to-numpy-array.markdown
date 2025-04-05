---
title: "Python 将文本转换为 NumPy 数组"
description: "在数据分析和机器学习领域，经常需要处理各种格式的数据。文本数据是一种常见的数据来源，而将文本转换为 NumPy 数组是数据预处理的重要步骤。NumPy 数组具有高效的存储和计算性能，能够极大地提升数据处理的速度。本文将详细介绍如何在 Python 中把文本转换为 NumPy 数组，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一关键技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据分析和机器学习领域，经常需要处理各种格式的数据。文本数据是一种常见的数据来源，而将文本转换为 NumPy 数组是数据预处理的重要步骤。NumPy 数组具有高效的存储和计算性能，能够极大地提升数据处理的速度。本文将详细介绍如何在 Python 中把文本转换为 NumPy 数组，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一关键技术。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **从简单文本字符串转换**
    - **从文本文件转换**
3. **常见实践**
    - **处理数值型文本数据**
    - **处理文本分类数据**
4. **最佳实践**
    - **优化内存使用**
    - **提高转换效率**
5. **小结**
6. **参考资料**

## 基础概念
### NumPy 数组
NumPy（Numerical Python）是 Python 中用于高效处理多维数组的库。NumPy 数组是一个同质的多维数组对象，即数组中的所有元素都具有相同的数据类型。它提供了丰富的数学函数和操作方法，能够快速地对数据进行各种计算。

### 文本数据
文本数据是以字符串形式表示的数据。它可以包含各种信息，如数字、字母、标点符号等。在将文本转换为 NumPy 数组时，需要根据文本数据的性质进行相应的处理，确保转换后的数组能够正确表示原始文本信息。

## 使用方法

### 从简单文本字符串转换
如果文本数据是以简单字符串形式存在，可以先将字符串拆分成单个元素，然后再转换为 NumPy 数组。

```python
import numpy as np

# 简单文本字符串
text = "1 2 3 4 5"

# 将字符串按空格拆分
split_text = text.split()

# 将拆分后的列表转换为 NumPy 数组
arr = np.array(split_text, dtype=int)

print(arr)
```

### 从文本文件转换
当文本数据存储在文件中时，可以使用 `numpy.loadtxt()` 函数来读取文件并转换为 NumPy 数组。

```python
import numpy as np

# 假设文本文件 data.txt 内容为：
# 1 2 3
# 4 5 6
# 7 8 9

arr = np.loadtxt('data.txt', dtype=int)
print(arr)
```

## 常见实践

### 处理数值型文本数据
在许多情况下，文本数据可能是数值型的，例如存储在文本文件中的数字表格。使用 `numpy.loadtxt()` 函数可以很方便地处理这种情况。

```python
import numpy as np

# 文本文件内容为数值数据
# 1.5 2.5
# 3.5 4.5

arr = np.loadtxt('numeric_data.txt', dtype=float)
print(arr)
```

### 处理文本分类数据
对于文本分类数据，需要先对文本进行编码，将每个类别映射为一个数字，然后再转换为 NumPy 数组。

```python
import numpy as np
from sklearn.preprocessing import LabelEncoder

# 文本分类数据
text_classes = ["apple", "banana", "apple", "cherry"]

# 创建 LabelEncoder 对象
le = LabelEncoder()

# 对文本进行编码
encoded_classes = le.fit_transform(text_classes)

# 转换为 NumPy 数组
arr = np.array(encoded_classes)

print(arr)
```

## 最佳实践

### 优化内存使用
在处理大规模文本数据时，内存使用是一个重要问题。可以使用 `numpy.memmap()` 函数创建内存映射数组，这样数据不会全部加载到内存中，而是在需要时从磁盘读取。

```python
import numpy as np

# 创建内存映射数组
mmap_arr = np.memmap('large_data.txt', dtype='float32', mode='r', shape=(1000000, 10))

# 可以像普通 NumPy 数组一样操作
print(mmap_arr.shape)
```

### 提高转换效率
对于非常大的文本文件，可以逐块读取数据并进行转换，而不是一次性读取整个文件。

```python
import numpy as np

chunk_size = 10000
data = []

with open('large_text_file.txt', 'r') as f:
    while True:
        chunk = f.readlines(chunk_size)
        if not chunk:
            break
        # 对每一块数据进行处理
        arr_chunk = np.loadtxt(chunk, dtype=int)
        data.append(arr_chunk)

# 合并所有块
final_arr = np.concatenate(data)
print(final_arr)
```

## 小结
本文详细介绍了在 Python 中把文本转换为 NumPy 数组的方法。从基础概念出发，阐述了 NumPy 数组和文本数据的特点。接着介绍了从简单文本字符串和文本文件转换的基本使用方法，以及处理数值型和文本分类数据的常见实践。最后，提供了优化内存使用和提高转换效率的最佳实践。通过掌握这些内容，读者能够在实际工作中更加高效地处理文本数据，并将其转换为适合分析和计算的 NumPy 数组格式。

## 参考资料
- [NumPy 官方文档](https://numpy.org/doc/){: rel="nofollow"}
- [Scikit-learn 官方文档](https://scikit-learn.org/stable/){: rel="nofollow"}