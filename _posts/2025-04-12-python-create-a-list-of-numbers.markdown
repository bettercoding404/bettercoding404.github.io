---
title: "Python 创建数字列表：从基础到最佳实践"
description: "在 Python 编程中，列表是一种非常重要的数据结构，它可以存储各种类型的数据，包括数字。创建数字列表是许多编程任务的基础，无论是进行简单的数学运算，还是处理复杂的数据集。本文将深入探讨如何在 Python 中创建数字列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，列表是一种非常重要的数据结构，它可以存储各种类型的数据，包括数字。创建数字列表是许多编程任务的基础，无论是进行简单的数学运算，还是处理复杂的数据集。本文将深入探讨如何在 Python 中创建数字列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用方括号直接创建
    - 使用 `range()` 函数创建
    - 使用列表推导式创建
3. 常见实践
    - 生成等差数列
    - 生成随机数列表
4. 最佳实践
    - 内存优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
列表是 Python 中的一种有序、可变的数据集合。它可以包含不同类型的元素，但在创建数字列表时，通常只包含数字（整数、浮点数等）。列表使用方括号 `[]` 来表示，元素之间用逗号分隔。例如：`[1, 2, 3]` 就是一个包含三个整数的列表。

## 使用方法

### 使用方括号直接创建
这是最基本的创建数字列表的方法。只需在方括号内直接列出数字即可。
```python
# 创建一个包含整数的列表
numbers1 = [1, 2, 3, 4, 5]
print(numbers1)

# 创建一个包含浮点数的列表
numbers2 = [1.5, 2.5, 3.5]
print(numbers2)
```
### 使用 `range()` 函数创建
`range()` 函数用于生成一个整数序列。它有三种常见的使用方式：
- `range(stop)`：生成从 0 到 `stop - 1` 的整数序列。
- `range(start, stop)`：生成从 `start` 到 `stop - 1` 的整数序列。
- `range(start, stop, step)`：生成从 `start` 到 `stop - 1`，步长为 `step` 的整数序列。

要将 `range()` 函数生成的序列转换为列表，可以使用 `list()` 函数。
```python
# 使用 range(stop)
numbers3 = list(range(5))
print(numbers3)

# 使用 range(start, stop)
numbers4 = list(range(2, 7))
print(numbers4)

# 使用 range(start, stop, step)
numbers5 = list(range(1, 10, 2))
print(numbers5)
```
### 使用列表推导式创建
列表推导式是一种简洁的语法，用于根据现有列表或其他可迭代对象创建新列表。它的基本语法是 `[expression for item in iterable if condition]`，其中 `expression` 是对每个 `item` 进行的操作，`if condition` 是可选的过滤条件。
```python
# 创建一个包含 1 到 10 的平方的列表
squares = [i ** 2 for i in range(1, 11)]
print(squares)

# 创建一个包含 1 到 10 中偶数的列表
even_numbers = [i for i in range(1, 11) if i % 2 == 0]
print(even_numbers)
```

## 常见实践

### 生成等差数列
等差数列是一种数字序列，其中相邻两个数字之间的差值是固定的。可以使用 `range()` 函数或列表推导式来生成等差数列。
```python
# 使用 range() 函数生成等差数列
arithmetic_sequence = list(range(1, 11, 2))
print(arithmetic_sequence)

# 使用列表推导式生成等差数列
start = 3
step = 4
length = 5
arithmetic_sequence_2 = [start + i * step for i in range(length)]
print(arithmetic_sequence_2)
```

### 生成随机数列表
在 Python 中，可以使用 `random` 模块生成随机数列表。
```python
import random

# 生成一个包含 5 个 1 到 100 之间随机整数的列表
random_numbers = [random.randint(1, 100) for _ in range(5)]
print(random_numbers)
```

## 最佳实践

### 内存优化
当创建大型数字列表时，内存使用可能成为一个问题。可以使用生成器表达式代替列表推导式，因为生成器是按需生成值，而不是一次性将所有值存储在内存中。
```python
# 使用生成器表达式生成平方数序列
square_generator = (i ** 2 for i in range(1, 1000000))
# 这里并没有实际占用大量内存，只有在迭代时才会生成值
for square in square_generator:
    if square > 10000:
        break
    print(square)
```

### 代码可读性
保持代码的可读性非常重要。在创建数字列表时，尽量使用有意义的变量名，并将复杂的逻辑拆分成多个步骤。
```python
# 不好的示例
nums = [i for i in range(1, 11) if i % 2 == 0]

# 好的示例
limit = 11
step = 2
even_numbers = [number for number in range(1, limit) if number % step == 0]
```

## 小结
本文介绍了在 Python 中创建数字列表的多种方法，包括使用方括号直接创建、`range()` 函数和列表推导式。还探讨了一些常见实践，如生成等差数列和随机数列表。在最佳实践部分，强调了内存优化和代码可读性的重要性。掌握这些知识，读者将能够更加高效地在 Python 中处理数字列表，解决各种编程问题。

## 参考资料
- 《Python 快速上手：让繁琐工作自动化》
- 《Effective Python: 编写高质量 Python 代码的 59 个有效方法》