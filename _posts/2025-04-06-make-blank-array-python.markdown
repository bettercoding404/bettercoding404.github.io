---
title: "在Python中创建空数组"
description: "在Python编程中，处理数组是一项常见任务。创建空数组是许多数据处理、算法实现等场景的起始步骤。本文将深入探讨在Python中创建空数组的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际编程中能灵活高效地运用这一技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，处理数组是一项常见任务。创建空数组是许多数据处理、算法实现等场景的起始步骤。本文将深入探讨在Python中创建空数组的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者在实际编程中能灵活高效地运用这一技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用Python列表创建空数组
    - 使用NumPy库创建空数组
3. 常见实践
    - 动态添加元素到空数组
    - 在循环中使用空数组
4. 最佳实践
    - 根据需求选择合适的库
    - 预先分配数组大小以提高性能
5. 小结
6. 参考资料

## 基础概念
在Python里，数组是一种有序的数据集合。空数组即不包含任何元素的数组。不同的库对于数组的实现方式有所不同，例如Python内置的列表类型可作为一种简单的数组，而NumPy库则提供了更高效、功能更强大的数组对象。

## 使用方法

### 使用Python列表创建空数组
Python的列表是一种灵活的数据结构，可以很方便地创建空数组。只需使用一对空的方括号即可。

```python
# 创建一个空列表（空数组）
empty_list = []
print(empty_list)  
```

### 使用NumPy库创建空数组
NumPy是Python中用于科学计算的强大库，它提供了多种创建空数组的方法。

1. **创建指定形状的空数组**
   ```python
   import numpy as np

   # 创建一个形状为(3, 4)的空数组，数据类型为浮点数
   empty_array = np.empty((3, 4))
   print(empty_array)  
   ```
   在上述代码中，`np.empty`函数接受一个表示形状的元组作为参数，创建一个指定形状的空数组。数组中的值是未初始化的，即这些值是内存中已有的值，所以每次运行结果可能不同。

2. **创建指定形状和数据类型的空数组**
   ```python
   import numpy as np

   # 创建一个形状为(2, 2)的空数组，数据类型为整数
   empty_int_array = np.empty((2, 2), dtype=int)
   print(empty_int_array)  
   ```
   这里通过`dtype`参数指定了数组的数据类型为整数。

## 常见实践

### 动态添加元素到空数组
当使用Python列表作为空数组时，可以使用`append`方法动态添加元素。

```python
empty_list = []
for i in range(5):
    empty_list.append(i)
print(empty_list)  
```

对于NumPy数组，由于其固定的大小和类型，不能像列表那样直接动态添加元素。通常需要创建一个新的更大的数组，然后将原数组的元素复制到新数组中。例如：

```python
import numpy as np

original_array = np.array([1, 2, 3])
new_size = len(original_array) + 2
new_array = np.empty(new_size)
new_array[:len(original_array)] = original_array
new_array[len(original_array):] = [4, 5]
print(new_array)  
```

### 在循环中使用空数组
在循环中使用空数组可以收集计算结果。例如，计算一系列数字的平方并存储在数组中。

```python
# 使用Python列表
squares_list = []
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    squares_list.append(num ** 2)
print(squares_list)  

# 使用NumPy数组
import numpy as np
numbers_np = np.array([1, 2, 3, 4, 5])
squares_np = np.empty(len(numbers_np))
for i in range(len(numbers_np)):
    squares_np[i] = numbers_np[i] ** 2
print(squares_np)  
```

## 最佳实践

### 根据需求选择合适的库
如果只是进行简单的数组操作，Python内置的列表可能就足够了。它具有灵活性，易于使用，适合处理小型、动态变化的数据集合。

但对于大规模的数值计算，NumPy库是更好的选择。NumPy数组在存储和计算效率上都远远高于Python列表，并且提供了丰富的数学函数和操作方法。

### 预先分配数组大小以提高性能
在使用NumPy数组时，如果已知数组最终的大小，预先分配数组大小可以提高性能。例如，在填充一个已知大小的数组时：

```python
import numpy as np

size = 1000
result_array = np.empty(size)
for i in range(size):
    result_array[i] = i ** 2
```

这样可以避免在循环中频繁地调整数组大小带来的性能开销。

## 小结
本文介绍了在Python中创建空数组的方法，包括使用Python列表和NumPy库。同时探讨了常见实践，如动态添加元素和在循环中使用空数组，以及最佳实践，如选择合适的库和预先分配数组大小。通过掌握这些知识，读者能够在不同的编程场景中更高效地处理数组。

## 参考资料
- [Python官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [NumPy官方文档](https://numpy.org/doc/){: rel="nofollow"}