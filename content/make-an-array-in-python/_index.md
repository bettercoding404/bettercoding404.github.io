---
title: "在Python中创建数组"
description: "在Python编程中，数组是一种用于存储多个元素的数据结构。与其他编程语言类似，Python中的数组允许你在一个变量名下组织和管理一组相关的数据。理解如何在Python中创建数组是进行数据处理、科学计算以及许多其他应用的基础。本文将详细介绍在Python中创建数组的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在Python编程中，数组是一种用于存储多个元素的数据结构。与其他编程语言类似，Python中的数组允许你在一个变量名下组织和管理一组相关的数据。理解如何在Python中创建数组是进行数据处理、科学计算以及许多其他应用的基础。本文将详细介绍在Python中创建数组的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用列表创建数组**
    - **使用`array`模块创建数组**
    - **使用`numpy`库创建数组**
3. **常见实践**
    - **访问数组元素**
    - **修改数组元素**
    - **数组的拼接与拆分**
4. **最佳实践**
    - **选择合适的数组类型**
    - **内存管理与性能优化**
5. **小结**
6. **参考资料**

## 基础概念
在Python中，数组是一种有序的数据集合，可以包含各种数据类型，如整数、浮点数、字符串等。数组的每个元素都有一个对应的索引，通过索引可以访问和操作数组中的元素。Python本身并没有内置的数组类型，但可以通过多种方式来创建和使用数组，常见的有使用列表（`list`）、`array`模块以及强大的`numpy`库。

## 使用方法

### 使用列表创建数组
在Python中，列表是一种非常灵活的数据结构，可以作为数组来使用。创建列表的方式很简单，只需将元素用方括号括起来，并用逗号分隔。

```python
# 创建一个整数列表作为数组
int_array = [1, 2, 3, 4, 5]
print(int_array)

# 创建一个包含不同数据类型的列表作为数组
mixed_array = [1, "hello", 3.14]
print(mixed_array)
```

### 使用`array`模块创建数组
Python的`array`模块提供了`array`类型，用于创建更紧凑的数组。`array`类型要求所有元素具有相同的数据类型。

```python
import array

# 创建一个整数数组
int_array = array.array('i', [1, 2, 3, 4, 5])
print(int_array)

# 创建一个字符数组
char_array = array.array('u', ['a', 'b', 'c'])
print(char_array)
```

在上述代码中，`'i'`表示整数类型，`'u'`表示Unicode字符类型。完整的类型码列表可以参考Python官方文档。

### 使用`numpy`库创建数组
`numpy`是Python中用于科学计算的强大库，它提供了`ndarray`（n维数组）类型，具有高效的数值计算能力。

```python
import numpy as np

# 创建一个一维数组
one_d_array = np.array([1, 2, 3, 4, 5])
print(one_d_array)

# 创建一个二维数组
two_d_array = np.array([[1, 2, 3], [4, 5, 6]])
print(two_d_array)
```

`numpy`数组可以通过多种方式创建，如`np.zeros`、`np.ones`、`np.arange`等函数，用于创建特定值或特定范围的数组。

```python
# 创建一个全零的一维数组
zeros_array = np.zeros(5)
print(zeros_array)

# 创建一个全一的二维数组
ones_array = np.ones((3, 3))
print(ones_array)

# 创建一个指定范围的数组
range_array = np.arange(1, 10, 2)  # 从1到10，步长为2
print(range_array)
```

## 常见实践

### 访问数组元素
对于列表和`numpy`数组，都可以通过索引来访问元素。索引从0开始。

```python
# 访问列表元素
my_list = [10, 20, 30, 40, 50]
print(my_list[0])  # 输出 10
print(my_list[-1])  # 输出 50，负索引表示从末尾开始计数

# 访问numpy数组元素
import numpy as np
my_array = np.array([10, 20, 30, 40, 50])
print(my_array[0])  # 输出 10
print(my_array[-1])  # 输出 50
```

对于二维数组，需要使用两个索引来访问元素。

```python
# 访问二维numpy数组元素
two_d_array = np.array([[1, 2, 3], [4, 5, 6]])
print(two_d_array[0, 1])  # 输出 2，访问第一行第二列的元素
```

### 修改数组元素
可以通过索引来修改数组中的元素。

```python
# 修改列表元素
my_list = [10, 20, 30, 40, 50]
my_list[2] = 35
print(my_list)  # 输出 [10, 20, 35, 40, 50]

# 修改numpy数组元素
import numpy as np
my_array = np.array([10, 20, 30, 40, 50])
my_array[2] = 35
print(my_array)  # 输出 [10, 20, 35, 40, 50]
```

### 数组的拼接与拆分
在处理数组时，经常需要将多个数组合并或拆分成较小的数组。

```python
import numpy as np

# 拼接numpy数组
array1 = np.array([1, 2, 3])
array2 = np.array([4, 5, 6])
concatenated_array = np.concatenate((array1, array2))
print(concatenated_array)  # 输出 [1 2 3 4 5 6]

# 拆分numpy数组
split_arrays = np.split(concatenated_array, 2)
print(split_arrays)  # 输出 [array([1, 2, 3]), array([4, 5, 6])]
```

## 最佳实践

### 选择合适的数组类型
- 如果数据类型多样且对性能要求不高，使用列表即可。列表非常灵活，可以包含不同类型的数据。
- 如果所有元素类型相同，且需要紧凑的存储和一定的性能提升，可以考虑使用`array`模块。
- 对于科学计算和大规模数值处理，`numpy`库是首选。`numpy`数组具有高度优化的实现，提供了丰富的数学函数和高效的计算能力。

### 内存管理与性能优化
- `numpy`数组在内存使用上更加高效，因为它们是连续存储的。在进行数值计算时，应尽量使用`numpy`数组以提高性能。
- 避免频繁的数组创建和销毁操作，尽量重用现有数组，以减少内存分配和释放的开销。

## 小结
在Python中创建数组有多种方式，每种方式都有其适用场景。通过列表可以快速创建灵活的数组，`array`模块适用于创建紧凑的同类型数组，而`numpy`库则是科学计算和大规模数据处理的强大工具。掌握数组的创建、访问、修改以及拼接拆分等操作，能够帮助你更高效地处理数据。在实际应用中，根据数据特点和性能需求选择合适的数组类型，并注意内存管理和性能优化，将有助于编写出高质量的Python代码。

## 参考资料
- [Python官方文档 - list](https://docs.python.org/3/library/stdtypes.html#list)
- [Python官方文档 - array](https://docs.python.org/3/library/array.html)
- [NumPy官方文档](https://numpy.org/doc/)