---
title: "深入理解 Python 字典排序（Sort Python Dict）"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。然而，字典本身是无序的，这在某些场景下可能无法满足我们的需求。例如，我们可能希望按照键或值对字典进行排序，以便更方便地查找、分析或展示数据。本文将深入探讨如何在 Python 中对字典进行排序，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。然而，字典本身是无序的，这在某些场景下可能无法满足我们的需求。例如，我们可能希望按照键或值对字典进行排序，以便更方便地查找、分析或展示数据。本文将深入探讨如何在 Python 中对字典进行排序，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 按键排序
    - 按值排序
3. 常见实践
    - 对嵌套字典排序
    - 按多个条件排序
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，字典是一种无序的可变容器，它使用哈希表来存储键值对。这意味着字典中的元素没有固定的顺序，每次访问字典的顺序可能不同。然而，在某些情况下，我们需要对字典进行排序，以便按照特定的规则对数据进行排列。

排序的基本思想是根据键或值的某种顺序（例如升序或降序）对字典中的元素进行重新排列。Python 提供了多种方法来实现字典的排序，我们将在下面详细介绍。

## 使用方法

### 按键排序
要按字典的键进行排序，可以使用内置的 `sorted()` 函数。`sorted()` 函数接受一个可迭代对象（如字典的键、值或项）作为参数，并返回一个新的已排序列表。

```python
my_dict = {'banana': 3, 'apple': 2, 'cherry': 1}

# 按键排序，返回一个新的排序列表
sorted_keys = sorted(my_dict.keys())
print(sorted_keys)  # 输出: ['apple', 'banana', 'cherry']

# 如果要得到一个有序的字典，可以使用 OrderedDict（Python 3.7 之前版本需要）
from collections import OrderedDict

sorted_dict = OrderedDict(sorted(my_dict.items()))
print(sorted_dict)  
# 输出: OrderedDict([('apple', 2), ('banana', 3), ('cherry', 1)])

# 在 Python 3.7+ 版本中，普通字典会记住插入顺序，直接使用 dict 即可
sorted_dict = dict(sorted(my_dict.items()))
print(sorted_dict)  
# 输出: {'apple': 2, 'banana': 3, 'cherry': 1}
```

### 按值排序
按字典的值进行排序稍微复杂一些，因为 `sorted()` 函数默认是对可迭代对象的元素本身进行排序。我们需要使用 `lambda` 函数来指定按照字典的值进行排序。

```python
my_dict = {'banana': 3, 'apple': 2, 'cherry': 1}

# 按值排序，返回一个新的排序列表
sorted_values = sorted(my_dict.items(), key=lambda item: item[1])
print(sorted_values)  
# 输出: [('cherry', 1), ('apple', 2), ('banana', 3)]

# 如果要得到一个有序的字典
sorted_dict = dict(sorted(my_dict.items(), key=lambda item: item[1]))
print(sorted_dict)  
# 输出: {'cherry': 1, 'apple': 2, 'banana': 3}
```

## 常见实践

### 对嵌套字典排序
在实际应用中，我们可能会遇到嵌套字典的情况，即字典的值也是字典。对嵌套字典进行排序需要更复杂的逻辑。

```python
nested_dict = {
    'group1': {'apple': 3, 'banana': 2},
    'group2': {'cherry': 1, 'date': 4}
}

# 按内层字典的值对嵌套字典排序
sorted_nested_dict = dict(sorted(nested_dict.items(), key=lambda item: sum(item[1].values())))
print(sorted_nested_dict)  
# 输出: {'group2': {'cherry': 1, 'date': 4}, 'group1': {'apple': 3, 'banana': 2}}
```

### 按多个条件排序
有时候我们需要根据多个条件对字典进行排序。例如，先按值排序，值相同的情况下再按键排序。

```python
my_dict = {'banana': 3, 'apple': 3, 'cherry': 1}

# 先按值排序，值相同再按键排序
sorted_dict = dict(sorted(my_dict.items(), key=lambda item: (item[1], item[0])))
print(sorted_dict)  
# 输出: {'cherry': 1, 'apple': 3, 'banana': 3}
```

## 最佳实践

### 性能优化
在处理大型字典时，性能是一个重要的考虑因素。`sorted()` 函数的时间复杂度是 $O(n log n)$，其中 $n$ 是字典元素的数量。如果对性能要求极高，可以考虑使用更高效的数据结构或算法。例如，在某些情况下，使用堆排序或快速排序的变体可能会更高效。

### 代码可读性
为了提高代码的可读性，尽量避免使用过于复杂的 `lambda` 函数。可以将排序逻辑封装成一个独立的函数，这样代码的意图会更加清晰。

```python
my_dict = {'banana': 3, 'apple': 2, 'cherry': 1}

def sort_by_value(item):
    return item[1]

sorted_dict = dict(sorted(my_dict.items(), key=sort_by_value))
print(sorted_dict)  
# 输出: {'cherry': 1, 'apple': 2, 'banana': 3}
```

## 小结
本文详细介绍了在 Python 中对字典进行排序的方法，包括按键排序、按值排序、对嵌套字典排序以及按多个条件排序。同时，我们还讨论了一些最佳实践，如性能优化和代码可读性。掌握这些技巧将有助于你更高效地处理字典数据，提高编程效率。

## 参考资料
- [Python 官方文档 - sorted() 函数](https://docs.python.org/3/library/functions.html#sorted)
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)