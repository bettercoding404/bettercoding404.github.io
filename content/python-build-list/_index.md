---
title: "Python 构建列表：基础与实践"
description: "在 Python 编程中，列表（List）是一种非常重要的数据结构。它是一个有序的可变元素集合，可以包含各种不同类型的数据，例如整数、字符串、甚至其他列表。理解如何有效地构建列表是 Python 编程的基础技能之一，这篇博客将深入探讨 Python 构建列表的相关知识，帮助你更好地掌握这一关键技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（List）是一种非常重要的数据结构。它是一个有序的可变元素集合，可以包含各种不同类型的数据，例如整数、字符串、甚至其他列表。理解如何有效地构建列表是 Python 编程的基础技能之一，这篇博客将深入探讨 Python 构建列表的相关知识，帮助你更好地掌握这一关键技术。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 直接初始化
    - 使用 `range()` 函数构建列表
    - 列表推导式
3. 常见实践
    - 构建数值列表
    - 构建字符串列表
    - 从其他数据结构转换为列表
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
列表是 Python 中的一种序列类型，用方括号 `[]` 表示。它具有以下特点：
- **有序性**：列表中的元素按照定义的顺序存储，可以通过索引访问。
- **可变性**：可以修改、添加或删除列表中的元素。
- **异构性**：可以包含不同类型的元素，例如 `[1, 'hello', True]`。

## 使用方法
### 直接初始化
最基本的构建列表的方法是直接在方括号内列出元素。
```python
# 初始化一个包含整数的列表
numbers = [1, 2, 3, 4, 5]
print(numbers)

# 初始化一个包含不同类型元素的列表
mixed_list = [1, 'apple', True, 3.14]
print(mixed_list)
```

### 使用 `range()` 函数构建列表
`range()` 函数可以生成一个整数序列，常用于构建数值列表。
```python
# 使用 range() 生成从 0 到 4 的整数列表
list1 = list(range(5))
print(list1)

# 使用 range() 生成从 5 到 9 的整数列表
list2 = list(range(5, 10))
print(list2)

# 使用 range() 生成从 0 到 10 步长为 2 的整数列表
list3 = list(range(0, 11, 2))
print(list3)
```

### 列表推导式
列表推导式是一种简洁的语法，用于根据现有列表或其他可迭代对象创建新列表。
```python
# 基于现有列表创建新列表，将每个元素翻倍
original_list = [1, 2, 3, 4]
new_list = [x * 2 for x in original_list]
print(new_list)

# 使用条件语句过滤元素
filtered_list = [x for x in original_list if x % 2 == 0]
print(filtered_list)
```

## 常见实践
### 构建数值列表
在数据分析和科学计算中，经常需要构建数值列表。
```python
# 构建一个包含 1 到 100 的平方的列表
squares = [i ** 2 for i in range(1, 101)]
print(squares)
```

### 构建字符串列表
在文本处理任务中，构建字符串列表很常见。
```python
# 构建一个包含字符串长度的列表
strings = ['apple', 'banana', 'cherry']
lengths = [len(s) for s in strings]
print(lengths)
```

### 从其他数据结构转换为列表
可以将元组、集合等其他数据结构转换为列表。
```python
# 将元组转换为列表
tuple_data = (1, 2, 3)
list_from_tuple = list(tuple_data)
print(list_from_tuple)

# 将集合转换为列表
set_data = {4, 5, 6}
list_from_set = list(set_data)
print(list_from_set)
```

## 最佳实践
### 性能优化
在处理大量数据时，性能非常重要。列表推导式通常比传统的 `for` 循环更快。
```python
import time

# 使用 for 循环构建列表
start_time = time.time()
result1 = []
for i in range(1000000):
    result1.append(i)
end_time = time.time()
print(f"For loop time: {end_time - start_time} seconds")

# 使用列表推导式构建列表
start_time = time.time()
result2 = [i for i in range(1000000)]
end_time = time.time()
print(f"List comprehension time: {end_time - start_time} seconds")
```

### 代码可读性
保持代码的可读性很重要。对于复杂的列表推导式，可以适当添加注释或拆分成多个步骤。
```python
# 复杂的列表推导式
data = [1, 2, 3, 4, 5]
result = [x ** 2 if x % 2 == 0 else x + 1 for x in data]
# 为了可读性，可以拆分成多个步骤
even_squares = [x ** 2 for x in data if x % 2 == 0]
odd_incremented = [x + 1 for x in data if x % 2 != 0]
result = even_squares + odd_incremented
```

## 小结
本文深入介绍了 Python 构建列表的基础概念、多种使用方法、常见实践以及最佳实践。通过直接初始化、`range()` 函数和列表推导式等方法，你可以灵活地构建各种类型的列表。在实际应用中，要注意性能优化和代码可读性，以编写高效且易于维护的 Python 代码。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- [Python 教程 - 列表推导式](https://www.runoob.com/python3/python3-list-comprehensions.html)