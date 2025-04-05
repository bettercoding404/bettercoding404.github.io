---
title: "Python 列表排序：sort() 方法全解析"
description: "在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。对列表进行排序是数据处理和算法实现中经常遇到的需求。Python 提供了多种方式对列表进行排序，其中 `sort()` 方法是最直接和常用的方式之一。本文将深入探讨 Python 中 `sort()` 方法的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握和运用这一功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，列表（list）是一种常用且功能强大的数据结构。对列表进行排序是数据处理和算法实现中经常遇到的需求。Python 提供了多种方式对列表进行排序，其中 `sort()` 方法是最直接和常用的方式之一。本文将深入探讨 Python 中 `sort()` 方法的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握和运用这一功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 简单排序
    - 自定义排序规则
    - 反向排序
3. 常见实践
    - 数字列表排序
    - 字符串列表排序
    - 复杂对象列表排序
4. 最佳实践
    - 性能优化
    - 稳定性考量
5. 小结
6. 参考资料

## 基础概念
在 Python 中，`sort()` 方法是列表对象的一个内置方法，用于对列表中的元素进行排序。它会直接修改原始列表，而不是返回一个新的已排序列表。这一点与 `sorted()` 函数不同，`sorted()` 函数会返回一个新的已排序列表，而原始列表保持不变。

## 使用方法
### 简单排序
对列表进行简单排序是 `sort()` 方法最基本的应用。当调用 `sort()` 方法时，如果不提供任何参数，它会按照元素的默认排序规则对列表进行排序。对于数字列表，会按照从小到大的顺序排序；对于字符串列表，会按照字母顺序排序。

```python
# 数字列表排序
number_list = [5, 2, 8, 1, 9]
number_list.sort()
print(number_list) 

# 字符串列表排序
string_list = ["banana", "apple", "cherry"]
string_list.sort()
print(string_list) 
```

### 自定义排序规则
`sort()` 方法允许通过 `key` 参数自定义排序规则。`key` 参数接受一个函数，该函数将列表中的每个元素作为输入，并返回一个用于比较的键。通过这种方式，可以根据元素的特定属性或计算结果进行排序。

```python
# 根据字符串长度对列表进行排序
string_list = ["banana", "apple", "cherry"]
string_list.sort(key=len)
print(string_list) 

# 自定义对象列表排序
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]
people.sort(key=lambda person: person.age)
print(people) 
```

### 反向排序
通过设置 `reverse` 参数为 `True`，可以实现反向排序。`reverse` 参数默认为 `False`，即正向排序。

```python
# 数字列表反向排序
number_list = [5, 2, 8, 1, 9]
number_list.sort(reverse=True)
print(number_list) 

# 字符串列表反向排序
string_list = ["banana", "apple", "cherry"]
string_list.sort(reverse=True)
print(string_list) 
```

## 常见实践
### 数字列表排序
在数据分析和算法实现中，对数字列表进行排序是非常常见的操作。例如，在统计数据时，可能需要对一组成绩进行排序，以便分析成绩分布。

```python
scores = [75, 88, 62, 90, 78]
scores.sort()
print(scores) 
```

### 字符串列表排序
在文本处理和信息检索中，对字符串列表进行排序可以帮助整理数据。比如，对一个包含城市名称的列表进行排序，方便查找和管理。

```python
cities = ["Beijing", "Shanghai", "Guangzhou", "Shenzhen"]
cities.sort()
print(cities) 
```

### 复杂对象列表排序
在面向对象编程中，经常需要对包含自定义对象的列表进行排序。例如，在一个学生管理系统中，对学生对象列表按照成绩或年龄进行排序。

```python
class Student:
    def __init__(self, name, grade):
        self.name = name
        self.grade = grade

    def __repr__(self):
        return f"Student({self.name}, {self.grade})"

students = [Student("Alice", 85), Student("Bob", 78), Student("Charlie", 92)]
students.sort(key=lambda student: student.grade, reverse=True)
print(students) 
```

## 最佳实践
### 性能优化
当处理大规模列表时，性能是一个重要的考虑因素。Python 的 `sort()` 方法采用了快速排序算法，平均时间复杂度为 $O(n log n)$。为了进一步提高性能，可以尽量减少不必要的计算和操作。例如，在自定义排序规则时，确保 `key` 函数的计算复杂度较低。

### 稳定性考量
`sort()` 方法是稳定的排序算法，这意味着相等元素的相对顺序在排序后保持不变。在某些应用场景中，稳定性是非常重要的。例如，在对学生成绩进行排序时，如果成绩相同，希望保持学生原来的顺序，这时稳定排序算法就很有用。

## 小结
本文详细介绍了 Python 中 `sort()` 方法的基础概念、使用方法、常见实践以及最佳实践。通过 `sort()` 方法，我们可以轻松地对列表进行排序，无论是简单的数字或字符串列表，还是复杂的自定义对象列表。在实际应用中，合理运用 `sort()` 方法的参数和特性，可以提高代码的效率和可读性。希望读者通过本文的学习，能够更好地掌握和运用 `sort()` 方法来解决实际问题。

## 参考资料
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》