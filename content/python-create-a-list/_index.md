---
title: "Python 创建列表：基础、实践与最佳方法"
description: "在 Python 编程中，列表（list）是一种极为重要且常用的数据结构。它允许我们将多个元素存储在一个有序的集合中，这些元素可以是任何数据类型，包括数字、字符串、布尔值，甚至是其他列表。掌握如何创建列表是 Python 编程的基础技能之一，本文将详细介绍创建列表的基础概念、各种使用方法、常见实践场景以及最佳实践，帮助读者更好地运用这一强大的数据结构。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（list）是一种极为重要且常用的数据结构。它允许我们将多个元素存储在一个有序的集合中，这些元素可以是任何数据类型，包括数字、字符串、布尔值，甚至是其他列表。掌握如何创建列表是 Python 编程的基础技能之一，本文将详细介绍创建列表的基础概念、各种使用方法、常见实践场景以及最佳实践，帮助读者更好地运用这一强大的数据结构。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本创建方式
    - 使用 range() 函数创建列表
    - 列表推导式创建列表
3. 常见实践
    - 创建数值列表
    - 创建字符串列表
    - 创建混合类型列表
4. 最佳实践
    - 选择合适的创建方式
    - 优化列表创建性能
5. 小结
6. 参考资料

## 基础概念
列表是 Python 中一种有序的、可变的数据集合。有序意味着列表中的元素有特定的顺序，你可以通过索引来访问和操作这些元素。可变则表示你可以在列表创建后修改、添加或删除其中的元素。列表使用方括号 `[]` 来表示，元素之间用逗号分隔。例如：
```python
my_list = [1, 2, 3, 'hello', True]
```
在这个例子中，`my_list` 是一个包含整数、字符串和布尔值的列表。

## 使用方法
### 基本创建方式
创建列表最直接的方法就是在方括号内列出元素。例如：
```python
# 创建一个包含整数的列表
numbers = [1, 2, 3, 4, 5]
print(numbers) 

# 创建一个包含字符串的列表
fruits = ['apple', 'banana', 'cherry']
print(fruits) 

# 创建一个空列表
empty_list = []
print(empty_list) 
```

### 使用 range() 函数创建列表
`range()` 函数常用于生成一系列数字。你可以使用它来创建数值列表。`range()` 函数有三种形式：
- `range(stop)`：生成从 0 到 `stop - 1` 的整数序列。
- `range(start, stop)`：生成从 `start` 到 `stop - 1` 的整数序列。
- `range(start, stop, step)`：生成从 `start` 到 `stop - 1`，步长为 `step` 的整数序列。

例如：
```python
# 使用 range(stop) 创建列表
list1 = list(range(5))
print(list1) 

# 使用 range(start, stop) 创建列表
list2 = list(range(2, 7))
print(list2) 

# 使用 range(start, stop, step) 创建列表
list3 = list(range(1, 10, 2))
print(list3) 
```

### 列表推导式创建列表
列表推导式是一种简洁的语法，用于根据现有列表或其他可迭代对象创建新列表。它的基本语法是 `[expression for item in iterable if condition]`。例如：
```python
# 从现有列表创建新列表，新列表元素是原列表元素的平方
original_list = [1, 2, 3, 4]
squared_list = [num ** 2 for num in original_list]
print(squared_list) 

# 使用条件过滤元素
even_list = [num for num in range(10) if num % 2 == 0]
print(even_list) 
```

## 常见实践
### 创建数值列表
在数据分析和科学计算中，经常需要创建数值列表。例如，生成一系列用于绘图的 x 轴数据：
```python
import matplotlib.pyplot as plt

# 创建 x 轴数据
x_values = list(range(0, 101))
y_values = [x ** 2 for x in x_values]

plt.plot(x_values, y_values)
plt.show()
```

### 创建字符串列表
在文本处理任务中，字符串列表非常有用。比如，分割一个句子为单词列表：
```python
sentence = "Python is a great programming language"
word_list = sentence.split()
print(word_list) 
```

### 创建混合类型列表
有时候，我们需要在一个列表中存储不同类型的数据。例如，存储用户信息：
```python
user_info = ['John Doe', 30, True, ['Python', 'Java']]
print(user_info) 
```

## 最佳实践
### 选择合适的创建方式
根据具体需求选择最合适的创建方式。如果是简单的固定元素列表，直接使用方括号创建即可。如果需要生成数值序列，`range()` 函数结合 `list()` 是不错的选择。而对于基于现有可迭代对象进行转换或过滤创建新列表，列表推导式更为简洁高效。

### 优化列表创建性能
对于大规模数据的列表创建，性能很重要。列表推导式通常比传统的循环方式创建列表更快。另外，如果要从文件或其他数据源读取大量数据并创建列表，可以考虑使用生成器表达式（与列表推导式类似，但使用圆括号），它不会一次性将所有数据加载到内存中，而是按需生成数据。例如：
```python
# 使用生成器表达式创建一个大的数值序列
large_sequence = (num for num in range(1000000))
# 按需获取数据
for num in large_sequence:
    if num > 100:
        break
    print(num) 
```

## 小结
本文详细介绍了 Python 中创建列表的多种方法，包括基础概念、不同的创建方式（基本创建、使用 `range()` 函数、列表推导式）以及常见实践场景。同时，还给出了一些最佳实践建议，帮助读者在实际编程中更高效地使用列表。掌握这些知识将有助于读者在 Python 编程中更加得心应手地处理数据和解决问题。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- 《Python 快速上手：让繁琐工作自动化》
- 《Python 核心编程》