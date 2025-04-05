---
title: "Python 列表排序：深入理解与高效运用"
description: "在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、分析算法结果还是整理用户输入，排序功能都发挥着重要作用。本文将深入探讨 Python 中对列表进行排序的相关知识，从基础概念到最佳实践，帮助读者全面掌握这一重要技能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、分析算法结果还是整理用户输入，排序功能都发挥着重要作用。本文将深入探讨 Python 中对列表进行排序的相关知识，从基础概念到最佳实践，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 列表的 `sort()` 方法
    - `sorted()` 函数
3. **常见实践**
    - 按数字大小排序
    - 按字符串字母顺序排序
    - 自定义排序规则
4. **最佳实践**
    - 性能优化
    - 稳定性考量
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，列表（List）是一种有序的可变数据类型，可以包含各种不同类型的元素。排序操作就是将列表中的元素按照一定的顺序进行重新排列，常见的顺序有升序（从小到大）和降序（从大到小）。

## 使用方法
### 列表的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接对原列表进行排序，没有返回值。语法如下：
```python
list.sort(key=None, reverse=False)
```
- `key`：指定一个函数，用于从每个元素中提取一个比较键。默认为 `None`，即直接比较元素本身。
- `reverse`：一个布尔值，默认为 `False`，表示升序排序；如果设为 `True`，则表示降序排序。

示例：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  
```
输出：
```
[1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
```

### `sorted()` 函数
`sorted()` 函数是 Python 的内置函数，它会返回一个新的已排序列表，原列表不会被修改。语法如下：
```python
sorted(iterable, key=None, reverse=False)
```
参数含义与 `sort()` 方法相同。

示例：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list)
print(new_list)  
print(my_list)  
```
输出：
```
[1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
```

## 常见实践
### 按数字大小排序
对包含数字的列表进行排序是最常见的操作之一。
```python
number_list = [10, 5, 8, 12, 3]
number_list.sort()
print(number_list)  
```
输出：
```
[3, 5, 8, 10, 12]
```

### 按字符串字母顺序排序
对于包含字符串的列表，可以按照字母顺序进行排序。
```python
string_list = ["banana", "apple", "cherry", "date"]
string_list.sort()
print(string_list)  
```
输出：
```
['apple', 'banana', 'cherry', 'date']
```

### 自定义排序规则
有时候我们需要根据特定的规则对列表进行排序，这时候可以通过 `key` 参数来指定一个函数。例如，我们有一个包含字典的列表，每个字典表示一个学生的信息，我们想按照学生的成绩进行排序：
```python
students = [
    {"name": "Alice", "score": 85},
    {"name": "Bob", "score": 78},
    {"name": "Charlie", "score": 92}
]

students.sort(key=lambda student: student["score"])
print(students)  
```
输出：
```
[{'name': 'Bob','score': 78}, {'name': 'Alice','score': 85}, {'name': 'Charlie','score': 92}]
```

## 最佳实践
### 性能优化
- **选择合适的排序方法**：对于小型列表，`sort()` 方法和 `sorted()` 函数的性能差异不大。但对于大型列表，尤其是需要多次排序的场景，`sort()` 方法直接修改原列表，避免了创建新列表的开销，性能更优。
- **使用内置类型**：Python 的内置类型（如整数、字符串）排序效率较高。尽量避免在排序过程中进行复杂的类型转换或计算。

### 稳定性考量
排序的稳定性是指在排序过程中，相等元素的相对顺序是否保持不变。`sort()` 方法和 `sorted()` 函数都是稳定排序算法。在某些情况下，稳定性非常重要，例如对学生成绩排序时，如果成绩相同，希望保持原来的输入顺序，稳定排序就能满足这一需求。

## 小结
本文详细介绍了 Python 中对列表进行排序的基础概念、使用方法、常见实践以及最佳实践。通过 `sort()` 方法和 `sorted()` 函数，我们可以轻松对列表进行排序，并根据不同需求自定义排序规则。在实际应用中，合理选择排序方法和注意性能优化、稳定性等因素，能够提高程序的效率和质量。

## 参考资料
- [Python 官方文档 - 列表排序](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - sorted() 函数](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}