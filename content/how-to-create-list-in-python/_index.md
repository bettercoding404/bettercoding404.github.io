---
title: "深入探究 Python 中列表的创建"
description: "在 Python 编程世界里，列表（List）是一种极为重要的数据结构。它可以存储多个不同类型的元素，为数据的组织和处理提供了极大的灵活性。掌握如何创建列表是 Python 编程的基础技能之一，无论是简单的数据收集还是复杂的算法实现，都离不开列表的运用。本文将全面深入地探讨在 Python 中创建列表的各种方法，帮助读者更好地理解和使用这一强大的数据结构。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程世界里，列表（List）是一种极为重要的数据结构。它可以存储多个不同类型的元素，为数据的组织和处理提供了极大的灵活性。掌握如何创建列表是 Python 编程的基础技能之一，无论是简单的数据收集还是复杂的算法实现，都离不开列表的运用。本文将全面深入地探讨在 Python 中创建列表的各种方法，帮助读者更好地理解和使用这一强大的数据结构。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本创建方式
    - 从其他可迭代对象创建
    - 列表推导式
3. 常见实践
    - 创建空列表
    - 创建包含特定元素的列表
    - 根据条件创建列表
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
列表是 Python 中一种有序的可变序列，用方括号 `[]` 表示。它可以包含任意数量、任意类型的元素，比如整数、字符串、浮点数，甚至其他列表、字典等复杂数据结构。列表中的每个元素都有一个对应的索引，从 0 开始计数，这使得我们可以方便地访问和操作列表中的元素。

## 使用方法

### 基本创建方式
最简单的创建列表的方式就是在方括号内直接列出元素，元素之间用逗号分隔。

```python
# 创建一个包含整数的列表
numbers = [1, 2, 3, 4, 5]
print(numbers)

# 创建一个包含不同类型元素的列表
mixed_list = [10, "hello", 3.14, True]
print(mixed_list)
```

### 从其他可迭代对象创建
Python 中的许多可迭代对象（如字符串、元组、集合等）都可以用来创建列表。可以使用 `list()` 函数将这些可迭代对象转换为列表。

```python
# 从字符串创建列表
string = "python"
string_list = list(string)
print(string_list)

# 从元组创建列表
tuple_data = (1, 2, 3)
tuple_to_list = list(tuple_data)
print(tuple_to_list)
```

### 列表推导式
列表推导式是一种简洁而强大的创建列表的方式，它允许我们通过一个表达式和一个循环来生成列表。

```python
# 生成一个包含 1 到 10 的平方的列表
squares = [i**2 for i in range(1, 11)]
print(squares)

# 生成一个包含 1 到 10 中所有偶数的列表
even_numbers = [i for i in range(1, 11) if i % 2 == 0]
print(even_numbers)
```

## 常见实践

### 创建空列表
在某些情况下，我们需要先创建一个空列表，然后再逐步添加元素。

```python
empty_list = []
print(empty_list)

# 或者使用 list() 函数
empty_list_again = list()
print(empty_list_again)
```

### 创建包含特定元素的列表
有时候我们需要创建一个包含重复元素或特定规律元素的列表。

```python
# 创建一个包含 5 个 0 的列表
zeros_list = [0] * 5
print(zeros_list)

# 创建一个等差数列列表
arithmetic_sequence = [i * 2 + 1 for i in range(5)]
print(arithmetic_sequence)
```

### 根据条件创建列表
可以根据特定的条件来筛选和创建列表。

```python
# 从一个列表中筛选出大于 5 的元素并创建新列表
original_list = [1, 3, 7, 9, 4, 6]
filtered_list = [num for num in original_list if num > 5]
print(filtered_list)
```

## 最佳实践

### 性能优化
在处理大量数据时，列表推导式通常比传统的循环方式更高效。因为列表推导式是在底层用 C 语言实现的，执行速度更快。

```python
import time

# 使用循环创建列表
start_time = time.time()
loop_list = []
for i in range(1000000):
    loop_list.append(i)
end_time = time.time()
loop_time = end_time - start_time

# 使用列表推导式创建列表
start_time = time.time()
comprehension_list = [i for i in range(1000000)]
end_time = time.time()
comprehension_time = end_time - start_time

print(f"循环创建列表时间: {loop_time} 秒")
print(f"列表推导式创建列表时间: {comprehension_time} 秒")
```

### 代码可读性
保持代码的可读性非常重要。当列表推导式过于复杂时，最好将其拆分成多个步骤或者使用传统的循环方式，以提高代码的可维护性。

```python
# 复杂的列表推导式
complex_list = [i * j for i in range(1, 11) for j in range(1, 11) if i % 2 == 0 and j % 2 != 0]

# 拆分成多个步骤
even_numbers = [i for i in range(1, 11) if i % 2 == 0]
odd_numbers = [j for j in range(1, 11) if j % 2 != 0]
result_list = []
for i in even_numbers:
    for j in odd_numbers:
        result_list.append(i * j)

# 虽然代码量增加了，但更易读和维护
```

## 小结
通过本文的介绍，我们全面了解了在 Python 中创建列表的多种方法，包括基本创建方式、从其他可迭代对象创建以及强大的列表推导式。同时，我们还探讨了常见的实践场景和最佳实践，如性能优化和代码可读性方面的考虑。掌握这些知识将有助于读者在 Python 编程中更加高效地使用列表这一重要的数据结构，无论是简单的数据处理还是复杂的算法实现，都能更加得心应手。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- 《Python 核心编程》
- 《Effective Python》