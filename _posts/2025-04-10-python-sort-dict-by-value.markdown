---
title: "Python 按字典值排序：深入解析与实践"
description: "在 Python 编程中，字典（dictionary）是一种非常实用的数据结构，用于存储键值对。有时候，我们需要根据字典的值而不是键来对字典进行排序。本文将深入探讨如何在 Python 中按字典值进行排序，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一重要的操作技巧。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常实用的数据结构，用于存储键值对。有时候，我们需要根据字典的值而不是键来对字典进行排序。本文将深入探讨如何在 Python 中按字典值进行排序，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一重要的操作技巧。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `sorted()` 函数结合 `items()` 方法
    - 使用 `operator` 模块
    - 使用 `lambda` 表达式
3. **常见实践**
    - 对数值型值的字典排序
    - 对字符串型值的字典排序
4. **最佳实践**
    - 性能优化
    - 代码可读性优化
5. **小结**
6. **参考资料**

## 基础概念
字典是 Python 中的无序数据结构，这意味着键值对的存储顺序并不固定。然而，在许多情况下，我们需要根据字典的值对其进行排序，以便更好地分析和处理数据。按字典值排序，简单来说，就是将字典中的键值对按照值的大小（升序或降序）重新排列，这样我们可以快速获取最大值或最小值对应的键，或者对数据进行某种顺序的遍历。

## 使用方法
### 使用 `sorted()` 函数结合 `items()` 方法
Python 的内置函数 `sorted()` 可以对可迭代对象进行排序。字典的 `items()` 方法会返回一个包含所有键值对的视图对象，我们可以利用这一点来实现按值排序。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=lambda item: item[1])
print(sorted_dict)
```

在上述代码中，`sorted()` 函数的 `key` 参数指定了排序的依据，`lambda item: item[1]` 表示按照每个键值对中的第二个元素（即值）进行排序。`sorted()` 函数返回一个包含排序后键值对的列表。

### 使用 `operator` 模块
`operator` 模块提供了一些用于操作对象的函数，其中 `itemgetter()` 函数可以方便地实现按字典值排序。

```python
from operator import itemgetter

my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=itemgetter(1))
print(sorted_dict)
```

这里 `itemgetter(1)` 与前面的 `lambda item: item[1]` 作用相同，都是指定按第二个元素（值）进行排序。

### 使用 `lambda` 表达式
除了上述方法，我们还可以直接使用 `lambda` 表达式来定义排序的规则。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict, key=lambda k: my_dict[k])
print(sorted_dict)
```

在这个例子中，`lambda k: my_dict[k]` 表示根据键 `k` 获取对应的值，并以此值进行排序。不过需要注意的是，这里 `sorted()` 函数返回的是排序后的键组成的列表，而不是键值对。

## 常见实践
### 对数值型值的字典排序
```python
score_dict = {'Alice': 85, 'Bob': 70, 'Charlie': 90}
sorted_by_score = sorted(score_dict.items(), key=lambda item: item[1], reverse=True)
print(sorted_by_score)
```

上述代码对学生成绩字典按成绩从高到低排序，`reverse=True` 参数表示降序排列。

### 对字符串型值的字典排序
```python
name_dict = {'a': 'Alice', 'b': 'Bob', 'c': 'Charlie'}
sorted_by_name = sorted(name_dict.items(), key=lambda item: item[1])
print(sorted_by_name)
```

这段代码对包含名字的字典按名字的字母顺序进行升序排序。

## 最佳实践
### 性能优化
当处理大型字典时，性能是一个重要的考虑因素。使用 `operator.itemgetter()` 通常比 `lambda` 表达式具有更好的性能，因为 `itemgetter()` 是内置函数，执行效率更高。

### 代码可读性优化
虽然 `lambda` 表达式简洁，但在复杂的排序逻辑中，可能会降低代码的可读性。此时，可以将排序逻辑封装成一个独立的函数，提高代码的可读性和可维护性。

```python
def get_value(dict_item):
    return dict_item[1]

my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=get_value)
print(sorted_dict)
```

## 小结
本文详细介绍了在 Python 中按字典值排序的多种方法，包括使用 `sorted()` 函数结合 `items()` 方法、`operator` 模块以及 `lambda` 表达式。同时，我们探讨了常见实践场景和最佳实践，以帮助你在实际编程中高效地使用这一技巧。通过掌握这些方法，你可以更加灵活地处理字典数据，提升代码的质量和性能。

## 参考资料
- [Python 官方文档 - sorted() 函数](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- [Python 官方文档 - operator 模块](https://docs.python.org/3/library/operator.html){: rel="nofollow"}