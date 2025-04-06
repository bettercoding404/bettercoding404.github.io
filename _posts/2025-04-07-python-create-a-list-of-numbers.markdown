---
title: "Python 创建数字列表：基础、用法与最佳实践"
description: "在 Python 编程中，列表是一种极为常用的数据结构，它可以存储各种类型的数据，数字列表便是其中常见的一种。创建数字列表在数据处理、算法实现、数学计算等众多领域都有着广泛的应用。本文将深入探讨如何在 Python 中创建数字列表，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一重要的编程技巧。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 编程中，列表是一种极为常用的数据结构，它可以存储各种类型的数据，数字列表便是其中常见的一种。创建数字列表在数据处理、算法实现、数学计算等众多领域都有着广泛的应用。本文将深入探讨如何在 Python 中创建数字列表，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一重要的编程技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用方括号直接创建
    - 使用 `range()` 函数创建
    - 使用列表推导式创建
3. 常见实践
    - 数字列表的数学运算
    - 数据筛选与过滤
    - 数据可视化准备
4. 最佳实践
    - 代码可读性与可维护性
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表是一个有序的可变序列，用方括号 `[]` 表示。数字列表就是列表中元素全为数字的列表，这些数字可以是整数、浮点数等。例如，`[1, 2, 3]` 是一个包含三个整数的列表，`[1.5, 2.7, 3.14]` 是一个包含三个浮点数的列表。列表中的元素可以通过索引来访问，索引从 0 开始。

## 使用方法

### 使用方括号直接创建
这是创建数字列表最直接、最简单的方法。只需在方括号内依次列出数字，用逗号分隔即可。

```python
# 创建一个包含整数的列表
int_list = [1, 2, 3, 4, 5]
print(int_list)

# 创建一个包含浮点数的列表
float_list = [1.1, 2.2, 3.3, 4.4, 5.5]
print(float_list)

# 创建一个包含混合数字类型的列表
mixed_list = [1, 2.5, 3, 4.7, 5]
print(mixed_list)
```

### 使用 `range()` 函数创建
`range()` 函数用于生成一个整数序列，它有三种使用形式：
- `range(stop)`：生成从 0 到 `stop - 1` 的整数序列。
- `range(start, stop)`：生成从 `start` 到 `stop - 1` 的整数序列。
- `range(start, stop, step)`：生成从 `start` 到 `stop - 1`，步长为 `step` 的整数序列。

要将 `range()` 生成的序列转换为列表，可以使用 `list()` 函数。

```python
# 使用 range(stop) 创建列表
list1 = list(range(5))
print(list1)  # 输出: [0, 1, 2, 3, 4]

# 使用 range(start, stop) 创建列表
list2 = list(range(3, 8))
print(list2)  # 输出: [3, 4, 5, 6, 7]

# 使用 range(start, stop, step) 创建列表
list3 = list(range(1, 10, 2))
print(list3)  # 输出: [1, 3, 5, 7, 9]
```

### 使用列表推导式创建
列表推导式是一种简洁的语法，用于根据现有列表或其他可迭代对象创建新列表。它的基本语法是 `[expression for item in iterable if condition]`，其中 `expression` 是对 `item` 进行操作的表达式，`if condition` 是可选的过滤条件。

```python
# 创建一个平方数列表
squares = [i ** 2 for i in range(1, 6)]
print(squares)  # 输出: [1, 4, 9, 16, 25]

# 创建一个偶数列表
evens = [i for i in range(1, 11) if i % 2 == 0]
print(evens)  # 输出: [2, 4, 6, 8, 10]
```

## 常见实践

### 数字列表的数学运算
数字列表常用于各种数学计算，例如求和、求平均值、求最大值和最小值等。

```python
numbers = [1, 2, 3, 4, 5]

# 计算列表元素的和
sum_numbers = sum(numbers)
print("Sum:", sum_numbers)  # 输出: Sum: 15

# 计算列表元素的平均值
average = sum(numbers) / len(numbers)
print("Average:", average)  # 输出: Average: 3.0

# 求列表中的最大值和最小值
max_number = max(numbers)
min_number = min(numbers)
print("Max:", max_number)  # 输出: Max: 5
print("Min:", min_number)  # 输出: Min: 1
```

### 数据筛选与过滤
可以根据特定条件从数字列表中筛选出符合要求的数据。

```python
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 筛选出大于 5 的数字
filtered_numbers = [num for num in numbers if num > 5]
print(filtered_numbers)  # 输出: [6, 7, 8, 9, 10]

# 筛选出能被 3 整除的数字
divisible_by_3 = [num for num in numbers if num % 3 == 0]
print(divisible_by_3)  # 输出: [3, 6, 9]
```

### 数据可视化准备
在进行数据可视化时，数字列表常常是数据的来源。例如，使用 `matplotlib` 库绘制折线图。

```python
import matplotlib.pyplot as plt

# 创建数据列表
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

# 绘制折线图
plt.plot(x, y)
plt.xlabel('X-axis')
plt.ylabel('Y-axis')
plt.title('Simple Line Plot')
plt.show()
```

## 最佳实践

### 代码可读性与可维护性
- 使用有意义的变量名，例如 `numbers` 比 `nums` 更能清晰表达列表的含义。
- 合理使用注释，解释复杂的列表创建逻辑或特定操作的目的。
- 将长的列表推导式拆分成多行，提高代码的可读性。

```python
# 良好的变量命名和注释
# 创建一个包含 1 到 10 的平方数的列表
squares_of_1_to_10 = [i ** 2 for i in range(1, 11)]

# 长列表推导式拆分
even_numbers = [
    num
    for num in range(1, 100)
    if num % 2 == 0
]
```

### 性能优化
- 对于大型数字列表，使用生成器表达式代替列表推导式可以节省内存。生成器表达式使用圆括号 `()` 而不是方括号 `[]`，它按需生成数据，而不是一次性生成所有数据。
- 在对列表进行频繁的添加和删除操作时，考虑使用 `collections.deque` 替代普通列表，因为 `deque` 在两端进行操作时具有更好的性能。

```python
# 使用生成器表达式
even_generator = (i for i in range(1, 100) if i % 2 == 0)
for num in even_generator:
    print(num)

from collections import deque

# 使用 deque
my_deque = deque([1, 2, 3])
my_deque.append(4)
my_deque.popleft()
print(my_deque)  # 输出: deque([2, 3, 4])
```

## 小结
本文详细介绍了在 Python 中创建数字列表的多种方法，包括直接使用方括号创建、利用 `range()` 函数创建以及使用列表推导式创建。同时，通过实际示例展示了数字列表在常见实践场景中的应用，如数学运算、数据筛选和数据可视化准备。此外，还给出了一些最佳实践建议，旨在提高代码的可读性、可维护性和性能。希望读者通过阅读本文，能够熟练掌握创建和使用数字列表的技巧，在 Python 编程中更加得心应手。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - range() 函数](https://docs.python.org/3/library/stdtypes.html#range){: rel="nofollow"}
- [Python 官方文档 - 列表推导式](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions){: rel="nofollow"}