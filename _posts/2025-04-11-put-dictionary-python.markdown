---
title: "Python 字典操作之 “put” 相关概念与实践"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。虽然 Python 中并没有名为 `put` 的标准字典方法，但我们通常会使用 `update` 方法以及直接通过键赋值等操作来实现类似于其他编程语言中 “put” 的功能，也就是向字典中添加或更新键值对。深入理解这些操作对于高效使用字典数据结构至关重要，本文将围绕这些操作展开详细介绍。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。虽然 Python 中并没有名为 `put` 的标准字典方法，但我们通常会使用 `update` 方法以及直接通过键赋值等操作来实现类似于其他编程语言中 “put” 的功能，也就是向字典中添加或更新键值对。深入理解这些操作对于高效使用字典数据结构至关重要，本文将围绕这些操作展开详细介绍。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 通过键赋值
    - 使用 `update` 方法
3. 常见实践
    - 添加新键值对
    - 更新已有键的值
    - 合并字典
4. 最佳实践
    - 性能考量
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
字典是 Python 中的一种无序数据结构，用于存储键值对。每个键都是唯一的，通过键可以快速访问对应的值。字典使用花括号 `{}` 来创建，键值对之间用冒号 `:` 分隔，不同键值对之间用逗号 `,` 分隔。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```
在这里，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 分别是对应的值。

## 使用方法
### 通过键赋值
在 Python 中，可以直接通过键来给字典添加新的键值对或更新已有的值。如果键不存在，Python 会自动创建一个新的键值对；如果键已经存在，对应的值会被更新。
```python
my_dict = {'name': 'Alice', 'age': 30}
# 添加新键值对
my_dict['city'] = 'New York'
print(my_dict)
# 更新已有键的值
my_dict['age'] = 31
print(my_dict)
```
### 使用 `update` 方法
`update` 方法用于将一个字典或可迭代对象的键值对更新到另一个字典中。如果有重复的键，原字典中的值会被新的值替换。
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}
dict1.update(dict2)
print(dict1)
```
`update` 方法还可以接受可迭代对象，例如元组列表：
```python
list_of_tuples = [('d', 5), ('e', 6)]
dict1.update(list_of_tuples)
print(dict1)
```

## 常见实践
### 添加新键值对
当需要向字典中添加新的信息时，通过键赋值是一种简单直接的方法。例如，记录学生的成绩：
```python
student_grades = {'Alice': 90, 'Bob': 85}
# 添加新学生的成绩
student_grades['Charlie'] = 78
print(student_grades)
```
### 更新已有键的值
在数据发生变化时，需要更新字典中的值。比如，学生成绩有变动：
```python
student_grades = {'Alice': 90, 'Bob': 85}
# 更新 Alice 的成绩
student_grades['Alice'] = 95
print(student_grades)
```
### 合并字典
在处理多个数据源时，常常需要将多个字典合并成一个。`update` 方法可以方便地实现这一功能：
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'c': 3, 'd': 4}
dict1.update(dict2)
print(dict1)
```

## 最佳实践
### 性能考量
当需要频繁地添加或更新大量键值对时，直接通过键赋值的方式性能可能更好。而 `update` 方法在处理较大字典时，由于内部实现机制，可能会有一定的性能开销。例如：
```python
import timeit

# 测试直接通过键赋值
def test_direct_assignment():
    my_dict = {}
    for i in range(10000):
        my_dict[i] = i
    return my_dict

# 测试使用 update 方法
def test_update_method():
    my_dict = {}
    new_dict = {i: i for i in range(10000)}
    my_dict.update(new_dict)
    return my_dict

print(timeit.timeit(test_direct_assignment, number = 100))
print(timeit.timeit(test_update_method, number = 100))
```
### 代码可读性
在代码中，尽量使用清晰明了的方式来操作字典。如果只是简单地添加或更新一个键值对，直接通过键赋值更直观；如果是合并多个字典或者更新多个键值对，使用 `update` 方法可以使代码更简洁易读。

## 小结
在 Python 中，虽然没有标准的 `put` 方法，但通过键赋值和 `update` 方法可以实现类似 “put” 的功能，即向字典中添加新键值对或更新已有值。通过键赋值适合单个键值对的操作，而 `update` 方法更适合批量更新或合并字典。在实际应用中，需要根据具体需求和性能考量来选择合适的方法，同时要注重代码的可读性，以便于维护和扩展。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》