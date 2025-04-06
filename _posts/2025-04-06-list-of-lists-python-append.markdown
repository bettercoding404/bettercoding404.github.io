---
title: "Python 中嵌套列表的追加操作（List of Lists Append）"
description: "在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。而嵌套列表（list of lists），即列表中包含其他列表，更是为处理复杂数据提供了便利。`append` 方法作为列表操作的重要组成部分，在处理嵌套列表时发挥着关键作用。掌握 `list of lists` 的 `append` 操作，能让开发者更灵活地构建和操作复杂的数据结构。本文将详细介绍其基础概念、使用方法、常见实践及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。而嵌套列表（list of lists），即列表中包含其他列表，更是为处理复杂数据提供了便利。`append` 方法作为列表操作的重要组成部分，在处理嵌套列表时发挥着关键作用。掌握 `list of lists` 的 `append` 操作，能让开发者更灵活地构建和操作复杂的数据结构。本文将详细介绍其基础概念、使用方法、常见实践及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 向最外层列表追加新的子列表
    - 向已有的子列表追加元素
3. 常见实践
    - 构建二维矩阵
    - 按类别分组数据
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
### 什么是列表（list）
列表是 Python 中的一种有序、可变的数据结构，用方括号 `[]` 表示，可以包含各种数据类型，如整数、字符串、浮点数，甚至其他列表。例如：
```python
my_list = [1, "hello", 3.14]
```

### 什么是嵌套列表（list of lists）
嵌套列表就是列表中包含其他列表，也被称为二维列表（在处理二维数据时常用）或多维列表（维度可以超过二维）。以下是一个简单的嵌套列表示例：
```python
nested_list = [[1, 2], [3, 4], [5, 6]]
```
在这个例子中，`nested_list` 是一个包含三个子列表的嵌套列表。

### `append` 方法
`append` 方法是列表对象的内置方法，用于在列表的末尾添加一个元素。对于嵌套列表，它可以用于添加新的子列表或者向已有的子列表中添加元素。

## 使用方法

### 向最外层列表追加新的子列表
要向嵌套列表的最外层列表追加一个新的子列表，只需使用 `append` 方法，将新的子列表作为参数传入。
```python
nested_list = [[1, 2], [3, 4]]
new_sub_list = [5, 6]
nested_list.append(new_sub_list)
print(nested_list) 
```
输出结果：
```
[[1, 2], [3, 4], [5, 6]]
```

### 向已有的子列表追加元素
如果要向嵌套列表中的某个已有的子列表追加元素，首先需要定位到该子列表，然后再使用 `append` 方法。
```python
nested_list = [[1, 2], [3, 4]]
# 向第一个子列表追加元素 3
nested_list[0].append(3)
print(nested_list) 
```
输出结果：
```
[[1, 2, 3], [3, 4]]
```

## 常见实践

### 构建二维矩阵
在数学和计算机科学中，二维矩阵是一种常见的数据结构。可以使用嵌套列表来表示二维矩阵，并且通过 `append` 方法动态构建。
```python
matrix = []
rows = 3
cols = 4
for i in range(rows):
    row = []
    for j in range(cols):
        row.append(i * cols + j + 1)
    matrix.append(row)
print(matrix) 
```
输出结果：
```
[[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]
```

### 按类别分组数据
假设有一组数据，需要按照某个类别进行分组。可以使用嵌套列表来实现，每个子列表代表一个类别。
```python
data = [1, 2, 3, 4, 5, 6, 7, 8]
even_group = []
odd_group = []
for num in data:
    if num % 2 == 0:
        even_group.append(num)
    else:
        odd_group.append(num)
grouped_data = [even_group, odd_group]
print(grouped_data) 
```
输出结果：
```
[[2, 4, 6, 8], [1, 3, 5, 7]]
```

## 最佳实践

### 性能优化
在处理大型嵌套列表时，性能是一个重要考虑因素。尽量减少不必要的 `append` 操作，因为每次 `append` 操作都会导致列表的内存重新分配（如果当前内存空间不足）。可以预先分配足够的空间，使用列表推导式或者 `extend` 方法（在需要添加多个元素时）来提高性能。
```python
# 预先分配空间
nested_list = [[] for _ in range(10)]
# 使用 extend 方法添加多个元素
sub_list = [1, 2, 3]
nested_list[0].extend(sub_list)
print(nested_list) 
```

### 代码可读性优化
为了提高代码的可读性，尽量将复杂的 `append` 操作封装成函数。这样代码结构更清晰，便于维护和扩展。
```python
def add_to_nested_list(nested_list, sub_list):
    nested_list.append(sub_list)
    return nested_list

nested_list = [[1, 2]]
new_sub_list = [3, 4]
result = add_to_nested_list(nested_list, new_sub_list)
print(result) 
```

## 小结
本文详细介绍了 Python 中嵌套列表（list of lists）的 `append` 操作。首先阐述了列表、嵌套列表以及 `append` 方法的基础概念，接着介绍了向最外层列表追加新子列表和向已有子列表追加元素的使用方法。通过构建二维矩阵和按类别分组数据的常见实践示例，展示了 `append` 操作在实际场景中的应用。最后，从性能优化和代码可读性优化两个方面给出了最佳实践建议。掌握这些知识和技巧，能帮助开发者更高效地使用嵌套列表的 `append` 操作，处理复杂的数据结构和业务逻辑。

## 参考资料
- 《Python 核心编程》