---
title: "Python 中的排序列表：sorted() 与 list.sort()"
description: "在 Python 编程中，处理和操作列表是一项常见的任务。排序是其中一项非常重要的操作，它能让我们按照特定的顺序对列表元素进行排列。Python 提供了两种主要的方式来对列表进行排序：内置函数 `sorted()` 和列表对象的方法 `list.sort()`。本文将深入探讨这两种方法的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和运用它们来处理列表排序问题。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，处理和操作列表是一项常见的任务。排序是其中一项非常重要的操作，它能让我们按照特定的顺序对列表元素进行排列。Python 提供了两种主要的方式来对列表进行排序：内置函数 `sorted()` 和列表对象的方法 `list.sort()`。本文将深入探讨这两种方法的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地理解和运用它们来处理列表排序问题。

<!-- more -->
## 目录
1. **基础概念**
    - `sorted()` 函数
    - `list.sort()` 方法
2. **使用方法**
    - 对简单列表排序
    - 按特定规则排序
    - 逆序排序
3. **常见实践**
    - 对包含不同数据类型的列表排序
    - 对字典列表排序
4. **最佳实践**
    - 性能考量
    - 选择合适的排序方法
5. **小结**
6. **参考资料**

## 基础概念
### `sorted()` 函数
`sorted()` 是 Python 的内置函数，它可以接受任何可迭代对象（如列表、元组、集合等）作为参数，并返回一个新的已排序列表。这意味着原始的可迭代对象不会被修改。

### `list.sort()` 方法
`list.sort()` 是列表对象的一个方法，它直接在原列表上进行排序操作，不会返回新的列表。调用该方法后，原列表的顺序会被改变。

## 使用方法
### 对简单列表排序
```python
# 使用 sorted() 函数
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_list = sorted(my_list)
print(sorted_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

# 使用 list.sort() 方法
my_list.sort()
print(my_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
```

### 按特定规则排序
我们可以通过 `key` 参数来指定一个函数，该函数将应用于每个元素，以确定排序的依据。

```python
# 按元素的绝对值排序
my_list = [-3, 1, -4, 1, -5, 9, -2, 6, 5, -3, 5]
sorted_by_abs = sorted(my_list, key=abs)
print(sorted_by_abs)  # 输出: [1, 1, -2, -3, -3, 4, 5, 5, 5, 6, 9]

# 对字符串列表按字符串长度排序
string_list = ["apple", "banana", "cherry", "date"]
sorted_by_length = sorted(string_list, key=len)
print(sorted_by_length)  # 输出: ['date', 'apple', 'cherry', 'banana']
```

### 逆序排序
可以通过 `reverse` 参数来实现逆序排序。

```python
# 使用 sorted() 函数逆序排序
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_reverse = sorted(my_list, reverse=True)
print(sorted_reverse)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]

# 使用 list.sort() 方法逆序排序
my_list.sort(reverse=True)
print(my_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

## 常见实践
### 对包含不同数据类型的列表排序
当列表中包含不同数据类型时，直接排序可能会导致错误。我们可以通过自定义 `key` 函数来处理这种情况。

```python
mixed_list = [1, "apple", 3.14, "banana", 2]
sorted_mixed = sorted(mixed_list, key=lambda x: (type(x).__name__, x))
print(sorted_mixed)  
# 输出: [1, 2, 3.14, 'apple', 'banana']
```

### 对字典列表排序
假设有一个字典列表，我们可以根据字典中的某个键来进行排序。

```python
students = [
    {"name": "Alice", "age": 20},
    {"name": "Bob", "age": 18},
    {"name": "Charlie", "age": 22}
]

sorted_students = sorted(students, key=lambda student: student["age"])
print(sorted_students)  
# 输出: [{'name': 'Bob', 'age': 18}, {'name': 'Alice', 'age': 20}, {'name': 'Charlie', 'age': 22}]
```

## 最佳实践
### 性能考量
- `list.sort()` 方法通常比 `sorted()` 函数更快，因为它直接在原列表上操作，不需要创建新的列表。如果不需要保留原始列表，并且性能是关键因素，优先选择 `list.sort()` 方法。
- 对于大型数据集，`sorted()` 函数可能会消耗更多的内存，因为它会返回一个新的列表。在这种情况下，要谨慎使用。

### 选择合适的排序方法
- 如果需要保留原始列表不变，使用 `sorted()` 函数。
- 如果对性能要求较高，并且可以修改原始列表，使用 `list.sort()` 方法。

## 小结
Python 的 `sorted()` 函数和 `list.sort()` 方法为我们提供了强大而灵活的列表排序功能。通过理解它们的基础概念、掌握各种使用方法以及遵循最佳实践，我们能够更高效地处理列表排序问题，提升程序的质量和性能。

## 参考资料
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}