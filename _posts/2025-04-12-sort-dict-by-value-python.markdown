---
title: "Python 中按字典值排序"
description: "在 Python 编程中，字典（`dict`）是一种非常常用的数据结构，它用于存储键值对。有时，我们需要根据字典的值对字典进行排序，而不是默认的按键排序。本文将深入探讨在 Python 中如何按字典的值进行排序，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，字典（`dict`）是一种非常常用的数据结构，它用于存储键值对。有时，我们需要根据字典的值对字典进行排序，而不是默认的按键排序。本文将深入探讨在 Python 中如何按字典的值进行排序，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `sorted()` 函数结合 `items()` 方法
    - 使用 `operator` 模块
    - 使用 `lambda` 表达式
3. 常见实践
    - 对简单字典按值排序
    - 对嵌套字典按值排序
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
在 Python 中，字典是无序的数据结构。这意味着当我们迭代字典时，元素的顺序是不确定的。然而，在许多实际应用场景中，我们需要根据字典的值来对字典进行排序，以便更好地分析和处理数据。按字典值排序就是将字典的键值对按照值的大小（升序或降序）重新排列。

## 使用方法

### 使用 `sorted()` 函数结合 `items()` 方法
`items()` 方法用于返回字典的所有键值对组成的视图对象，该对象可以被迭代。`sorted()` 函数用于对可迭代对象进行排序。我们可以通过传递一个自定义的排序键函数来指定按值排序。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=lambda item: item[1])
print(sorted_dict)
```

在上述代码中，`lambda item: item[1]` 表示取每个键值对中的值作为排序的依据。运行结果将是一个由元组组成的列表，每个元组包含键和值，并且按照值的升序排列。

### 使用 `operator` 模块
`operator` 模块提供了一些有用的函数，用于简化排序操作。我们可以使用 `operator.itemgetter()` 函数来指定排序依据。

```python
import operator

my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=operator.itemgetter(1))
print(sorted_dict)
```

`operator.itemgetter(1)` 表示获取每个元素的第二个元素（即值）作为排序的键。这种方法在性能上可能会比使用 `lambda` 表达式稍快一些。

### 使用 `lambda` 表达式实现降序排序
如果我们想要按值降序排序，只需要在 `sorted()` 函数中添加 `reverse=True` 参数。

```python
my_dict = {'apple': 3, 'banana': 1, 'cherry': 2}
sorted_dict = sorted(my_dict.items(), key=lambda item: item[1], reverse=True)
print(sorted_dict)
```

## 常见实践

### 对简单字典按值排序
假设有一个存储学生成绩的字典，我们想要按成绩从高到低对学生进行排序。

```python
student_scores = {'Alice': 85, 'Bob': 78, 'Charlie': 92}
sorted_students = sorted(student_scores.items(), key=lambda item: item[1], reverse=True)
print(sorted_students)
```

### 对嵌套字典按值排序
对于嵌套字典，我们可以先提取需要排序的值，然后进行排序。例如，有一个存储学生信息的嵌套字典，每个学生的信息中包含成绩，我们按成绩对学生进行排序。

```python
students = [
    {'name': 'Alice','score': 85},
    {'name': 'Bob','score': 78},
    {'name': 'Charlie','score': 92}
]

sorted_students = sorted(students, key=lambda student: student['score'], reverse=True)
print(sorted_students)
```

## 最佳实践

### 性能优化
对于大规模数据，使用 `operator.itemgetter()` 通常比 `lambda` 表达式性能更好。因为 `operator.itemgetter()` 是内置函数，执行效率更高。

### 代码可读性优化
为了提高代码的可读性，当排序逻辑比较复杂时，可以将排序键函数定义为一个独立的函数，而不是使用匿名的 `lambda` 表达式。

```python
def get_score(student):
    return student['score']

students = [
    {'name': 'Alice','score': 85},
    {'name': 'Bob','score': 78},
    {'name': 'Charlie','score': 92}
]

sorted_students = sorted(students, key=get_score, reverse=True)
print(sorted_students)
```

## 小结
在 Python 中按字典值排序有多种方法，每种方法都有其特点和适用场景。通过使用 `sorted()` 函数结合 `items()` 方法、`operator` 模块以及 `lambda` 表达式，我们可以灵活地实现按字典值排序。在实际应用中，需要根据数据规模和代码可读性等因素选择合适的方法。

## 参考资料
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- [Python 官方文档 - operator 模块](https://docs.python.org/3/library/operator.html){: rel="nofollow"}