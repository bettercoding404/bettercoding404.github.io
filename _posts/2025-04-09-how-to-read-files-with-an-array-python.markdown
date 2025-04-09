---
title: "Python 中使用数组读取文件"
description: "在 Python 编程中，处理文件和数组是非常常见的任务。将文件内容读取到数组中，可以方便地对数据进行后续的处理、分析和操作。本文将详细介绍如何在 Python 中使用数组读取文件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的编程技能。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 编程中，处理文件和数组是非常常见的任务。将文件内容读取到数组中，可以方便地对数据进行后续的处理、分析和操作。本文将详细介绍如何在 Python 中使用数组读取文件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的编程技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `open()` 函数和列表
    - 使用 `numpy` 库
3. **常见实践**
    - 读取文本文件到数组
    - 读取 CSV 文件到数组
4. **最佳实践**
    - 错误处理
    - 内存管理
5. **小结**
6. **参考资料**

## 基础概念
### 文件
文件是存储在计算机存储设备上的数据集合。在 Python 中，文件可以分为文本文件和二进制文件。文本文件以字符形式存储数据，而二进制文件则以字节形式存储数据。在读取文件时，需要根据文件的类型选择合适的方法。

### 数组
数组是一种数据结构，用于存储多个相同类型的元素。在 Python 中，最常用的数组实现是列表（`list`）和 `numpy` 库中的 `ndarray`。列表是一种动态数组，可以存储不同类型的元素，而 `ndarray` 是一种静态数组，要求所有元素具有相同的类型，并且在数值计算方面具有更高的效率。

## 使用方法
### 使用 `open()` 函数和列表
Python 内置的 `open()` 函数用于打开文件，返回一个文件对象。可以使用文件对象的方法读取文件内容，并将其存储到列表中。

```python
# 打开文件
file = open('example.txt', 'r')

# 读取文件的所有行到列表
lines = file.readlines()

# 关闭文件
file.close()

# 打印列表内容
for line in lines:
    print(line.strip())
```

在上述代码中：
1. 使用 `open()` 函数打开名为 `example.txt` 的文件，模式为 `r`（只读）。
2. 使用 `readlines()` 方法读取文件的所有行，并将其存储到列表 `lines` 中。
3. 使用 `close()` 方法关闭文件，释放系统资源。
4. 遍历列表 `lines`，使用 `strip()` 方法去除每行末尾的换行符并打印。

### 使用 `numpy` 库
`numpy` 是一个用于科学计算的 Python 库，提供了高效的多维数组对象 `ndarray`。可以使用 `numpy` 库的函数读取文件内容到 `ndarray` 中。

```python
import numpy as np

# 从文本文件读取数据到 ndarray
data = np.loadtxt('example.txt')

# 打印 ndarray 内容
print(data)
```

在上述代码中：
1. 导入 `numpy` 库并简称为 `np`。
2. 使用 `np.loadtxt()` 函数从名为 `example.txt` 的文本文件读取数据，并将其存储到 `ndarray` 对象 `data` 中。`np.loadtxt()` 函数默认以空格作为分隔符，读取的数据类型为浮点数。
3. 打印 `ndarray` 对象 `data` 的内容。

## 常见实践
### 读取文本文件到数组
假设文本文件 `example.txt` 内容如下：
```
1 2 3
4 5 6
7 8 9
```

```python
import numpy as np

# 使用 numpy 读取文本文件
data = np.loadtxt('example.txt')
print(data)

# 使用内置函数读取文本文件
file = open('example.txt', 'r')
lines = file.readlines()
file.close()

new_list = []
for line in lines:
    numbers = line.strip().split(' ')
    new_list.append([int(num) for num in numbers])
print(new_list)
```

### 读取 CSV 文件到数组
CSV（逗号分隔值）文件是一种常用的文本文件格式，用于存储表格数据。可以使用 `numpy` 库的 `genfromtxt()` 函数读取 CSV 文件内容到 `ndarray` 中。

假设 `data.csv` 文件内容如下：
```
1,2,3
4,5,6
7,8,9
```

```python
import numpy as np

# 读取 CSV 文件到 ndarray
data = np.genfromtxt('data.csv', delimiter=',')
print(data)
```

在上述代码中，使用 `np.genfromtxt()` 函数读取 `data.csv` 文件，指定分隔符为逗号（`','`）。

## 最佳实践
### 错误处理
在读取文件时，可能会遇到各种错误，如文件不存在、权限不足等。因此，在代码中应该添加适当的错误处理机制。

```python
try:
    file = open('nonexistent_file.txt', 'r')
    lines = file.readlines()
    file.close()
except FileNotFoundError:
    print("文件未找到")
```

### 内存管理
当处理大型文件时，一次性将整个文件内容读取到内存中可能会导致内存不足。可以采用逐行读取的方式，减少内存占用。

```python
file = open('large_file.txt', 'r')
for line in file:
    # 处理每一行数据
    pass
file.close()
```

## 小结
本文详细介绍了在 Python 中使用数组读取文件的方法，包括使用内置函数和 `numpy` 库。通过基础概念的讲解、使用方法的示例、常见实践的展示以及最佳实践的建议，读者应该能够熟练掌握如何在不同场景下读取文件内容到数组中，并进行相应的处理。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [numpy 官方文档](https://numpy.org/doc/){: rel="nofollow"}