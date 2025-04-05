---
title: "Python 列表排序：基础、应用与最佳实践"
description: "在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、分析算法结果还是组织信息，排序功能都能帮助我们更高效地管理和利用数据。本文将深入探讨在 Python 中如何对列表进行排序，涵盖基础概念、各种使用方法、常见实践场景以及最佳实践技巧，帮助读者全面掌握这一重要编程技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、分析算法结果还是组织信息，排序功能都能帮助我们更高效地管理和利用数据。本文将深入探讨在 Python 中如何对列表进行排序，涵盖基础概念、各种使用方法、常见实践场景以及最佳实践技巧，帮助读者全面掌握这一重要编程技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 列表的 `sort()` 方法
    - `sorted()` 函数
3. 常见实践
    - 按元素大小排序
    - 按自定义规则排序
    - 对复杂数据结构列表排序
4. 最佳实践
    - 性能优化
    - 代码可读性提升
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表（list）是一种有序的可变数据类型，它可以包含各种不同类型的元素，如整数、字符串、对象等。排序操作就是将列表中的元素按照特定的顺序重新排列，常见的顺序有升序（从小到大）和降序（从大到小）。Python 提供了方便的内置函数和方法来实现列表的排序功能。

## 使用方法

### 列表的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接在原列表上进行排序操作，不会返回新的列表。

**语法**：
```python
list.sort(key=None, reverse=False)
```
- `key`：指定一个函数，用于从每个列表元素中提取一个比较键。默认值为 `None`，即直接比较元素本身。
- `reverse`：一个布尔值，默认为 `False`，表示升序排序；如果设为 `True`，则表示降序排序。

**示例**：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

my_list.sort(reverse=True)
print(my_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

### `sorted()` 函数
`sorted()` 函数是 Python 的一个内置函数，它会返回一个新的已排序列表，而原列表保持不变。

**语法**：
```python
sorted(iterable, key=None, reverse=False)
```
参数与 `sort()` 方法类似：
- `iterable`：需要排序的可迭代对象，如列表、元组、集合等。
- `key`：指定一个函数，用于从每个元素中提取一个比较键。
- `reverse`：布尔值，控制排序顺序。

**示例**：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list)
print(new_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
print(my_list)   # 输出: [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]

new_list = sorted(my_list, reverse=True)
print(new_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

## 常见实践

### 按元素大小排序
这是最基本的排序需求，对于数值类型的列表，可以直接使用 `sort()` 方法或 `sorted()` 函数进行排序。

```python
number_list = [10, 5, 8, 12, 3]
sorted_numbers = sorted(number_list)
print(sorted_numbers)  # 输出: [3, 5, 8, 10, 12]

number_list.sort(reverse=True)
print(number_list)  # 输出: [12, 10, 8, 5, 3]
```

### 按自定义规则排序
有时候，我们需要根据特定的规则对列表元素进行排序。可以通过 `key` 参数指定一个函数来实现。

例如，对字符串列表按字符串长度排序：
```python
string_list = ["apple", "banana", "cherry", "date"]
sorted_by_length = sorted(string_list, key=lambda x: len(x))
print(sorted_by_length)  # 输出: ['date', 'apple', 'cherry', 'banana']
```

### 对复杂数据结构列表排序
当列表元素是复杂的数据结构，如字典或自定义对象时，同样可以通过 `key` 参数指定排序依据。

假设有一个包含字典的列表，每个字典表示一个学生的信息，我们要按学生的成绩进行排序：
```python
students = [
    {"name": "Alice", "score": 85},
    {"name": "Bob", "score": 78},
    {"name": "Charlie", "score": 92}
]

sorted_students = sorted(students, key=lambda student: student["score"], reverse=True)
print(sorted_students) 
# 输出: [{"name": "Charlie", "score": 92}, {"name": "Alice", "score": 85}, {"name": "Bob", "score": 78}]
```

## 最佳实践

### 性能优化
在处理大规模数据时，性能是一个重要的考虑因素。`sort()` 方法通常比 `sorted()` 函数性能更好，因为 `sort()` 是在原列表上进行操作，避免了创建新列表的开销。但如果需要保留原列表不变，`sorted()` 函数也是一个不错的选择。

另外，使用内置的排序算法通常比自己实现的排序算法性能更高。Python 的内置排序算法是 Timsort，它在各种数据分布情况下都有较好的性能表现。

### 代码可读性提升
为了提高代码的可读性，尽量使用有意义的函数名和变量名。在使用 `key` 参数时，将复杂的排序逻辑封装在一个单独的函数中，而不是使用匿名函数（lambda 表达式），除非逻辑非常简单。

```python
def get_score(student):
    return student["score"]

students = [
    {"name": "Alice", "score": 85},
    {"name": "Bob", "score": 78},
    {"name": "Charlie", "score": 92}
]

sorted_students = sorted(students, key=get_score, reverse=True)
print(sorted_students) 
```

## 小结
本文详细介绍了在 Python 中对列表进行排序的方法，包括列表的 `sort()` 方法和 `sorted()` 函数的使用，以及常见的实践场景和最佳实践技巧。通过合理运用这些方法和技巧，我们可以高效地对各种类型的列表进行排序，从而更好地处理和分析数据。

## 参考资料
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}