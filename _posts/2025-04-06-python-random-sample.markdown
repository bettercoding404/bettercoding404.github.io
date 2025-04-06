---
title: "Python `random.sample`：随机抽样的强大工具"
description: "在数据处理和算法开发过程中，我们常常需要从一组数据中随机抽取一部分样本。Python 的 `random.sample` 函数提供了一种简单而有效的方式来实现这一需求。它能够从序列（如列表、元组）或集合中无放回地随机抽取指定数量的元素。本文将深入探讨 `random.sample` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地在项目中运用这一功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据处理和算法开发过程中，我们常常需要从一组数据中随机抽取一部分样本。Python 的 `random.sample` 函数提供了一种简单而有效的方式来实现这一需求。它能够从序列（如列表、元组）或集合中无放回地随机抽取指定数量的元素。本文将深入探讨 `random.sample` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地在项目中运用这一功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
    - 从列表中抽样
    - 从集合中抽样
    - 用于数据划分
4. 最佳实践
    - 确保可重复性
    - 处理大样本
5. 小结
6. 参考资料

## 基础概念
`random.sample` 是 Python 标准库 `random` 模块中的一个函数。它的作用是从给定的总体中随机抽取指定数量的样本，且每个样本在抽取过程中不会被重复选中（无放回抽样）。这一特性使得抽取的样本更具随机性和代表性，在统计学、机器学习等多个领域都有广泛应用。

## 使用方法
`random.sample` 函数的基本语法如下：
```python
random.sample(population, k)
```
- `population`：表示总体，可以是序列（如列表、元组）或集合。
- `k`：表示要抽取的样本数量，必须是一个非负整数，且不能大于总体的元素数量。

例如，要从一个列表 `[1, 2, 3, 4, 5]` 中随机抽取 2 个元素：
```python
import random

population = [1, 2, 3, 4, 5]
sample = random.sample(population, 2)
print(sample)
```
上述代码中，`random.sample` 函数从 `population` 列表中随机抽取了 2 个元素，并将结果存储在 `sample` 变量中，然后打印出来。每次运行代码，输出的结果可能会不同，因为抽取是随机的。

## 常见实践
### 从列表中抽样
列表是 Python 中最常用的数据结构之一，`random.sample` 可以方便地从列表中抽取样本。例如，有一个包含学生名字的列表，我们想随机抽取几个学生进行问卷调查：
```python
import random

students = ["Alice", "Bob", "Charlie", "David", "Eve", "Frank"]
selected_students = random.sample(students, 3)
print(selected_students)
```
这段代码从 `students` 列表中随机抽取了 3 个学生的名字并打印出来。

### 从集合中抽样
集合也是一种常用的数据结构，`random.sample` 同样适用于集合。例如，有一个包含数字的集合，我们想随机抽取部分数字：
```python
import random

numbers = {10, 20, 30, 40, 50}
selected_numbers = random.sample(numbers, 2)
print(selected_numbers)
```
在这个例子中，`random.sample` 从 `numbers` 集合中随机抽取了 2 个数字。

### 用于数据划分
在机器学习中，经常需要将数据集划分为训练集、验证集和测试集。`random.sample` 可以帮助我们实现这一目的。以下是一个简单的示例，假设我们有一个包含数据点的列表，要将其划分为 80% 的训练集和 20% 的测试集：
```python
import random

data = list(range(100))  # 生成包含 100 个数据点的列表
test_size = int(len(data) * 0.2)
test_set = random.sample(data, test_size)
train_set = [x for x in data if x not in test_set]

print("训练集大小:", len(train_set))
print("测试集大小:", len(test_set))
```
在这个例子中，首先计算出测试集的大小，然后使用 `random.sample` 抽取测试集，最后通过列表推导式得到训练集。

## 最佳实践
### 确保可重复性
在某些情况下，我们希望每次运行代码时得到的随机样本是相同的，以便进行调试和验证。可以通过设置随机种子来实现这一点。例如：
```python
import random

random.seed(42)  # 设置随机种子为 42
population = [1, 2, 3, 4, 5]
sample = random.sample(population, 2)
print(sample)
```
只要随机种子相同，无论何时运行代码，抽取的样本都是一样的。

### 处理大样本
当总体数量非常大时，直接使用 `random.sample` 可能会消耗大量内存。对于这种情况，可以考虑使用迭代器或生成器的方式逐步处理数据，而不是一次性加载所有数据。例如，可以使用 `itertools.islice` 结合 `random.sample` 来处理大文件中的数据抽样：
```python
import random
import itertools

def sample_large_file(file_path, sample_size):
    with open(file_path) as f:
        lines = itertools.islice(f, sample_size)
        return random.sample(list(lines), sample_size)

file_path = "large_file.txt"
sample = sample_large_file(file_path, 10)
print(sample)
```
这个函数通过 `itertools.islice` 从大文件中读取指定数量的行，然后再进行随机抽样，避免了一次性加载整个文件。

## 小结
Python 的 `random.sample` 函数是一个功能强大且实用的随机抽样工具。通过掌握其基础概念和使用方法，以及在不同场景下的常见实践和最佳实践，我们能够更加高效地处理数据抽样问题，无论是在日常的数据处理任务中，还是在复杂的机器学习项目里。希望本文能帮助你更好地理解和运用 `random.sample`，为你的编程工作带来便利。

## 参考资料
- 《Python 数据分析实战》
- 《Python 机器学习基础教程》