---
title: "Python 按字典值排序：深入解析与实践"
description: "在 Python 编程中，字典（`dict`）是一种非常实用的数据结构，用于存储键值对。然而，有时我们需要根据字典的值对字典进行排序。这在数据分析、数据处理以及许多其他场景中都非常有用。本文将深入探讨如何在 Python 中按字典值对字典进行排序，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，字典（`dict`）是一种非常实用的数据结构，用于存储键值对。然而，有时我们需要根据字典的值对字典进行排序。这在数据分析、数据处理以及许多其他场景中都非常有用。本文将深入探讨如何在 Python 中按字典值对字典进行排序，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `sorted()` 函数和 `lambda` 表达式
    - 使用 `operator.itemgetter()`
3. 常见实践
    - 升序排序
    - 降序排序
    - 对嵌套字典的值进行排序
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在 Python 中，字典是一种无序的数据结构，这意味着字典中的键值对没有固定的顺序。当我们需要按字典的值对字典进行排序时，实际上是创建一个新的有序数据结构（通常是列表），其中包含原字典的键值对，并且这些键值对是根据值的大小进行排序的。

## 使用方法

### 使用 `sorted()` 函数和 `lambda` 表达式
`lambda` 表达式是 Python 中用于创建匿名函数的一种简洁方式。结合 `sorted()` 函数，我们可以很方便地按字典的值进行排序。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}

sorted_dict = sorted(my_dict.items(), key=lambda item: item[1])
print(sorted_dict)
```

在上述代码中：
- `my_dict.items()` 返回一个包含所有键值对的视图对象。
- `key=lambda item: item[1]` 是排序的关键。`lambda item: item[1]` 定义了一个匿名函数，该函数接受一个参数 `item`（即字典中的一个键值对），并返回该键值对的第二个元素，也就是值。`sorted()` 函数根据这个值对字典的键值对进行排序。

### 使用 `operator.itemgetter()`
`operator.itemgetter()` 是 Python `operator` 模块中的一个函数，它可以用来获取对象的特定字段。这也可以用于按字典的值进行排序。

```python
import operator

my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}

sorted_dict = sorted(my_dict.items(), key=operator.itemgetter(1))
print(sorted_dict)
```

在这个例子中，`operator.itemgetter(1)` 起到了与前面 `lambda item: item[1]` 相同的作用，它返回键值对中的第二个元素（值），用于排序。

## 常见实践

### 升序排序
前面的例子都是按字典的值进行升序排序。如果要降序排序，只需在 `sorted()` 函数中添加 `reverse=True` 参数。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}

sorted_dict_descending = sorted(my_dict.items(), key=lambda item: item[1], reverse=True)
print(sorted_dict_descending)
```

### 对嵌套字典的值进行排序
当字典的值是另一个字典时，我们同样可以按嵌套字典的值进行排序。

```python
nested_dict = {
    'group1': {'apple': 3, 'banana': 1},
    'group2': {'cherry': 2, 'date': 4}
}

sorted_nested_dict = {
    key: dict(sorted(value.items(), key=lambda item: item[1]))
    for key, value in nested_dict.items()
}

print(sorted_nested_dict)
```

在上述代码中，我们使用字典推导式遍历 `nested_dict` 的每一个键值对。对于每个值（也是一个字典），我们使用 `sorted()` 函数按其值进行排序，然后将排序后的字典重新赋值给原来的键。

### 最佳实践

#### 性能优化
对于大型字典，使用 `operator.itemgetter()` 可能比 `lambda` 表达式性能更好，因为 `operator.itemgetter()` 是内置函数，执行速度更快。

#### 代码可读性
虽然 `lambda` 表达式简洁，但对于复杂的排序逻辑，使用命名函数而不是 `lambda` 表达式可以提高代码的可读性。

```python
def get_value(item):
    return item[1]

my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}

sorted_dict = sorted(my_dict.items(), key=get_value)
print(sorted_dict)
```

## 小结
在 Python 中按字典值排序是一个常见的需求，通过 `sorted()` 函数结合 `lambda` 表达式或 `operator.itemgetter()`，我们可以轻松实现这一功能。在实际应用中，需要根据具体情况选择合适的方法，同时要注意性能优化和代码可读性。

## 参考资料
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- [Python 官方文档 - operator.itemgetter()](https://docs.python.org/3/library/operator.html#operator.itemgetter){: rel="nofollow"}