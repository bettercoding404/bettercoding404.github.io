---
title: "在 Python 中遍历字典：深入理解与最佳实践"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。遍历字典，即逐个访问字典中的键值对，是日常编程中经常会遇到的操作。掌握如何高效且正确地遍历字典，对于编写简洁、清晰和高效的 Python 代码至关重要。本文将深入探讨在 Python 中遍历字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。遍历字典，即逐个访问字典中的键值对，是日常编程中经常会遇到的操作。掌握如何高效且正确地遍历字典，对于编写简洁、清晰和高效的 Python 代码至关重要。本文将深入探讨在 Python 中遍历字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 遍历键（keys）
    - 遍历值（values）
    - 遍历键值对（items）
3. 常见实践
    - 读取和处理键值对
    - 根据条件筛选键值对
4. 最佳实践
    - 性能优化
    - 代码可读性提升
5. 小结
6. 参考资料

## 基础概念
字典是 Python 中的一种无序数据结构，它由键值对组成。每个键都是唯一的，而值可以是任何 Python 对象。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```
在这个字典中，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 分别是对应的值。遍历字典就是按照一定的顺序逐个访问这些键值对。

## 使用方法

### 遍历键（keys）
可以使用 `keys()` 方法来遍历字典的键。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict.keys():
    print(key)
```
输出：
```
name
age
city
```
在 Python 中，`for key in my_dict` 和 `for key in my_dict.keys()` 是等效的，因为默认情况下，遍历字典就是遍历其键。

### 遍历值（values）
使用 `values()` 方法可以遍历字典的值。示例如下：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for value in my_dict.values():
    print(value)
```
输出：
```
Alice
30
New York
```

### 遍历键值对（items）
`items()` 方法用于遍历字典的键值对，以元组（tuple）的形式返回每个键值对。示例代码：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key, value in my_dict.items():
    print(f"{key}: {value}")
```
输出：
```
name: Alice
age: 30
city: New York
```

## 常见实践

### 读取和处理键值对
在很多实际场景中，需要读取字典中的键值对并进行相应的处理。例如，我们有一个存储学生成绩的字典，需要计算所有学生的平均成绩：
```python
scores = {'Alice': 85, 'Bob': 78, 'Charlie': 92}
total = 0
count = 0
for name, score in scores.items():
    total += score
    count += 1
average_score = total / count
print(f"Average score: {average_score}")
```
输出：
```
Average score: 85.0
```

### 根据条件筛选键值对
有时候，我们需要根据特定的条件筛选出符合要求的键值对。例如，在上述学生成绩字典中，筛选出成绩大于 80 分的学生：
```python
scores = {'Alice': 85, 'Bob': 78, 'Charlie': 92}
high_scorers = {}
for name, score in scores.items():
    if score > 80:
        high_scorers[name] = score
print(high_scorers)
```
输出：
```
{'Alice': 85, 'Charlie': 92}
```

## 最佳实践

### 性能优化
在处理大型字典时，性能是一个重要的考虑因素。例如，避免不必要的方法调用可以提高性能。使用 `for key in my_dict` 而不是 `for key in my_dict.keys()`，因为默认遍历字典就是遍历键，`keys()` 方法调用会增加额外的开销。

### 代码可读性提升
为了提高代码的可读性，使用 `items()` 方法遍历键值对时，给解包的变量取有意义的名字。例如，在遍历学生成绩字典时，使用 `name` 和 `score` 作为变量名，比使用 `key` 和 `value` 更直观。

## 小结
在 Python 中遍历字典有多种方法，每种方法都适用于不同的场景。通过 `keys()` 方法遍历键，`values()` 方法遍历值，`items()` 方法遍历键值对。在实际编程中，根据具体需求选择合适的遍历方法，并注意性能优化和代码可读性。掌握这些技巧，能够让我们更加高效地处理字典数据，编写出更优质的 Python 代码。

## 参考资料
- 《Python 核心编程》