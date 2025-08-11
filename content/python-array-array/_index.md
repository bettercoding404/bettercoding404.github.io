---
title: "Python 数组（array）深入解析"
description: "在 Python 编程中，`array` 模块提供了一种高效存储和操作基本数据类型序列的数据结构。与 Python 内置的列表（`list`）不同，`array` 更专注于存储同质数据（即相同数据类型的数据），这使得它在处理大量数值数据时更加高效，占用更少的内存空间。本文将详细介绍 Python `array` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握和运用这一数据结构。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，`array` 模块提供了一种高效存储和操作基本数据类型序列的数据结构。与 Python 内置的列表（`list`）不同，`array` 更专注于存储同质数据（即相同数据类型的数据），这使得它在处理大量数值数据时更加高效，占用更少的内存空间。本文将详细介绍 Python `array` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握和运用这一数据结构。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 创建数组
    - 访问数组元素
    - 修改数组元素
    - 数组操作
3. 常见实践
    - 数值计算
    - 文件 I/O
4. 最佳实践
    - 选择合适的数据类型
    - 内存管理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
`array` 是 Python 标准库中的一个模块，它提供了 `array` 数据类型。`array` 本质上是一个存储相同数据类型元素的序列，类似于列表，但具有更紧凑的内存表示。`array` 中的每个元素都必须是相同的数据类型，这与列表不同，列表可以包含不同数据类型的元素。

## 使用方法

### 创建数组
要使用 `array`，首先需要导入 `array` 模块。创建数组时，需要指定数组的数据类型和初始元素。以下是一个创建整数数组的示例：

```python
import array

# 创建一个整数数组
int_array = array.array('i', [1, 2, 3, 4, 5])
print(int_array)
```

在上述代码中，`'i'` 是数据类型代码，表示有符号整数。常见的数据类型代码如下：

| 代码 | 数据类型 |
|---|---|
| `'b'` | 有符号字节 |
| `'B'` | 无符号字节 |
| `'u'` | Unicode 字符（UTF-16 编码） |
| `'h'` | 有符号短整数 |
| `'H'` | 无符号短整数 |
| `'i'` | 有符号整数 |
| `'I'` | 无符号整数 |
| `'l'` | 有符号长整数 |
| `'L'` | 无符号长整数 |
| `'f'` | 单精度浮点数 |
| `'d'` | 双精度浮点数 |

### 访问数组元素
可以使用索引来访问数组中的元素，索引从 0 开始。例如：

```python
import array

int_array = array.array('i', [1, 2, 3, 4, 5])

# 访问第一个元素
print(int_array[0])  

# 访问最后一个元素
print(int_array[-1])  
```

### 修改数组元素
可以通过索引直接修改数组中的元素：

```python
import array

int_array = array.array('i', [1, 2, 3, 4, 5])

# 修改第三个元素
int_array[2] = 10
print(int_array)
```

### 数组操作
`array` 支持许多常见的序列操作，如长度获取、切片、连接等。

```python
import array

int_array1 = array.array('i', [1, 2, 3])
int_array2 = array.array('i', [4, 5, 6])

# 获取数组长度
print(len(int_array1))  

# 切片操作
print(int_array1[1:3])  

# 连接两个数组
combined_array = int_array1 + int_array2
print(combined_array)  
```

## 常见实践

### 数值计算
`array` 在数值计算中非常有用，尤其是在处理大量数值数据时。例如，计算数组中所有元素的总和：

```python
import array

int_array = array.array('i', [1, 2, 3, 4, 5])

# 计算总和
total = sum(int_array)
print(total)
```

### 文件 I/O
`array` 可以方便地用于文件读写操作。例如，将数组写入二进制文件并从文件中读取数组：

```python
import array

# 创建一个数组
int_array = array.array('i', [1, 2, 3, 4, 5])

# 写入二进制文件
with open('data.bin', 'wb') as f:
    int_array.tofile(f)

# 从二进制文件读取数组
new_array = array.array('i')
with open('data.bin', 'rb') as f:
    new_array.fromfile(f, len(int_array))

print(new_array)
```

## 最佳实践

### 选择合适的数据类型
根据数据的范围和性质选择合适的数据类型代码。例如，如果数据都是非负整数且范围较小，可以选择 `'B'`（无符号字节）以节省内存。

### 内存管理
由于 `array` 存储同质数据，内存使用更为紧凑。在处理大量数据时，使用 `array` 可以减少内存占用，提高程序性能。

### 性能优化
在进行数值计算时，`array` 比列表更快。如果性能要求较高，应优先使用 `array` 而不是列表。

## 小结
Python 的 `array` 模块提供了一种高效存储和操作基本数据类型序列的数据结构。通过了解其基础概念、使用方法、常见实践和最佳实践，读者可以在合适的场景中充分发挥 `array` 的优势，提高程序的性能和内存使用效率。

## 参考资料
- [Python 官方文档 - array 模块](https://docs.python.org/3/library/array.html)
- 《Python 核心编程》
- 《Python 数据分析实战》