---
title: "深入理解 Python 中数组长度的获取：array len"
description: "在 Python 的编程世界里，处理各种数据结构是日常开发的重要部分。其中，数组（array）是一种常用的数据结构，获取数组的长度是一个基础且关键的操作。`len` 函数在这一过程中扮演着核心角色。本文将详细介绍 `python array len` 的相关知识，帮助你更好地掌握如何获取数组长度以及在实际应用中的最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 的编程世界里，处理各种数据结构是日常开发的重要部分。其中，数组（array）是一种常用的数据结构，获取数组的长度是一个基础且关键的操作。`len` 函数在这一过程中扮演着核心角色。本文将详细介绍 `python array len` 的相关知识，帮助你更好地掌握如何获取数组长度以及在实际应用中的最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **内置数组类型（list）**
    - **NumPy 数组**
3. **常见实践**
    - **循环遍历数组并结合长度操作**
    - **根据数组长度进行条件判断**
4. **最佳实践**
    - **性能优化方面的考虑**
    - **代码可读性与可维护性**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，数组（严格来说，Python 内置的 `list` 类型可以当作一种动态数组使用）是一种有序且可变的数据集合。数组中的元素可以是不同的数据类型。`len` 是 Python 的内置函数，用于返回一个对象的长度。对于数组而言，它返回的是数组中元素的个数。

## 使用方法

### 内置数组类型（list）
Python 的 `list` 是最常用的数组形式。以下是使用 `len` 函数获取其长度的示例：

```python
# 创建一个 list
my_list = [1, 2, 3, 4, 5]

# 获取 list 的长度
length = len(my_list)

print(length)  
```

### NumPy 数组
NumPy 是 Python 中用于科学计算的重要库，其 `ndarray` 类型提供了比内置 `list` 更高效的数值计算支持。同样可以使用 `len` 函数获取其长度，但需要注意对于多维数组，`len` 返回的是第一维度的大小。

```python
import numpy as np

# 创建一个一维 NumPy 数组
my_np_array_1d = np.array([1, 2, 3, 4, 5])

# 获取一维 NumPy 数组的长度
length_1d = len(my_np_array_1d)

print(length_1d)  

# 创建一个二维 NumPy 数组
my_np_array_2d = np.array([[1, 2, 3], [4, 5, 6]])

# 获取二维 NumPy 数组第一维度的长度
length_2d = len(my_np_array_2d)

print(length_2d)  
```

## 常见实践

### 循环遍历数组并结合长度操作
在很多实际场景中，我们需要遍历数组并对每个元素进行操作。这时，数组的长度可以帮助我们控制循环的次数。

```python
my_list = [10, 20, 30, 40, 50]

for i in range(len(my_list)):
    print(f"Index {i}, Value {my_list[i]}")
```

### 根据数组长度进行条件判断
根据数组的长度，我们可以进行不同的操作。例如，当数组为空时执行特定的逻辑。

```python
my_list = []

if len(my_list) == 0:
    print("The list is empty.")
else:
    print("The list has elements.")
```

## 最佳实践

### 性能优化方面的考虑
对于大规模数据，使用 NumPy 数组而不是内置的 `list` 可以显著提高性能。在获取长度时，虽然 `len` 函数在两种类型上都很快，但 NumPy 的数组结构在内存管理和计算效率上更优。

```python
import numpy as np
import timeit

# 测试内置 list 的长度获取性能
def test_list_length():
    my_list = list(range(1000000))
    return len(my_list)

# 测试 NumPy 数组的长度获取性能
def test_numpy_length():
    my_np_array = np.arange(1000000)
    return len(my_np_array)

list_time = timeit.timeit(test_list_length, number = 100)
numpy_time = timeit.timeit(test_numpy_length, number = 100)

print(f"Time for list: {list_time} seconds")
print(f"Time for NumPy array: {numpy_time} seconds")
```

### 代码可读性与可维护性
在编写代码时，尽量使用描述性的变量名来存储数组长度，这样可以提高代码的可读性。例如：

```python
students = ["Alice", "Bob", "Charlie"]
student_count = len(students)

for i in range(student_count):
    print(f"Student {i + 1}: {students[i]}")
```

## 小结
在 Python 中，使用 `len` 函数获取数组长度是一个简单而强大的操作。无论是内置的 `list` 类型还是 NumPy 的 `ndarray` 类型，`len` 都能方便地返回数组元素的个数（对于多维数组，返回第一维度大小）。在实际应用中，结合数组长度进行循环遍历、条件判断等操作非常常见。同时，为了提高代码的性能和可读性，我们需要根据具体场景选择合适的数据结构，并采用良好的编程习惯。

## 参考资料
- [Python 官方文档 - Built-in Functions - len](https://docs.python.org/3/library/functions.html#len){: rel="nofollow"}
- [NumPy 官方文档](https://numpy.org/doc/stable/){: rel="nofollow"}