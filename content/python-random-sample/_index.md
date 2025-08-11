---
title: "Python random sample：随机抽样的强大工具"
description: "在数据分析、机器学习以及各种模拟场景中，我们常常需要从一组数据中随机抽取样本。Python 的 `random.sample()` 函数为我们提供了一种简单而有效的方式来实现这一需求。它能够从给定的序列或集合中随机选择指定数量的唯一元素，确保样本的随机性和独立性。本文将深入探讨 `random.sample()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一实用工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在数据分析、机器学习以及各种模拟场景中，我们常常需要从一组数据中随机抽取样本。Python 的 `random.sample()` 函数为我们提供了一种简单而有效的方式来实现这一需求。它能够从给定的序列或集合中随机选择指定数量的唯一元素，确保样本的随机性和独立性。本文将深入探讨 `random.sample()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一实用工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **从列表中抽样**
    - **从集合中抽样**
    - **从字符串中抽样**
3. **常见实践**
    - **数据预处理中的随机抽样**
    - **模拟实验中的随机选择**
4. **最佳实践**
    - **设置随机种子以确保可重复性**
    - **处理大样本时的性能优化**
5. **小结**
6. **参考资料**

## 基础概念
`random.sample()` 是 Python 标准库中 `random` 模块的一个函数。它的作用是从一个总体（可以是列表、集合、字符串等序列类型）中随机抽取指定数量的样本，且抽取的样本元素是唯一的。这意味着不会有重复的元素出现在抽取的样本中。例如，从一个包含 10 个元素的列表中抽取 3 个样本，这 3 个样本中的元素各不相同。

## 使用方法
### 从列表中抽样
```python
import random

# 定义一个列表
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 从列表中随机抽取 3 个元素
sample_list = random.sample(my_list, 3)
print(sample_list)
```
### 从集合中抽样
```python
import random

# 定义一个集合
my_set = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

# 从集合中随机抽取 4 个元素
sample_set = random.sample(list(my_set), 4)
print(sample_set)
```
注意，由于集合是无序的，在使用 `random.sample()` 时需要先将集合转换为列表。

### 从字符串中抽样
```python
import random

# 定义一个字符串
my_string = "abcdefghij"

# 从字符串中随机抽取 5 个字符
sample_string = ''.join(random.sample(my_string, 5))
print(sample_string)
```
这里使用 `''.join()` 将抽取的字符列表转换为字符串。

## 常见实践
### 数据预处理中的随机抽样
在进行数据分析或机器学习时，我们通常需要将数据集划分为训练集、验证集和测试集。`random.sample()` 可以帮助我们随机地从数据集中抽取样本用于不同的集合。
```python
import random

# 假设这是我们的数据集
data = list(range(100))

# 随机抽取 70 个样本作为训练集
train_set = random.sample(data, 70)

# 从剩下的数据中抽取 15 个样本作为验证集
remaining_data = [x for x in data if x not in train_set]
val_set = random.sample(remaining_data, 15)

# 剩下的数据作为测试集
test_set = [x for x in remaining_data if x not in val_set]

print("训练集大小:", len(train_set))
print("验证集大小:", len(val_set))
print("测试集大小:", len(test_set))
```
### 模拟实验中的随机选择
在模拟实验中，我们可能需要从一组选项中随机选择一些进行模拟。例如，从多个城市中随机选择几个进行交通流量模拟。
```python
import random

# 城市列表
cities = ["北京", "上海", "广州", "深圳", "成都", "杭州", "武汉", "南京"]

# 随机选择 3 个城市进行模拟
selected_cities = random.sample(cities, 3)
print("选择的城市:", selected_cities)
```

## 最佳实践
### 设置随机种子以确保可重复性
在进行实验或开发时，有时需要确保每次运行代码时得到的随机样本是相同的，以便于调试和比较结果。我们可以通过设置随机种子来实现这一点。
```python
import random

# 设置随机种子
random.seed(42)

my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
sample1 = random.sample(my_list, 3)
print(sample1)

# 再次设置相同的随机种子
random.seed(42)
sample2 = random.sample(my_list, 3)
print(sample2)
```
### 处理大样本时的性能优化
当总体非常大时，直接使用 `random.sample()` 可能会消耗大量内存和时间。一种优化方法是使用迭代器来逐步生成样本，而不是一次性加载所有数据。例如，可以使用 `itertools.islice()` 和 `random.sample()` 结合的方式。
```python
import random
import itertools

# 假设这是一个非常大的数据集
large_data = iter(range(1000000))

# 随机抽取 100 个样本
sample = list(itertools.islice(random.sample(large_data, 100), 100))
print(len(sample))
```

## 小结
`random.sample()` 是 Python 中一个功能强大且实用的函数，在数据处理、模拟实验等多个领域都有广泛的应用。通过理解其基础概念和掌握正确的使用方法，我们能够轻松地从各种序列类型中获取随机且唯一的样本。同时，遵循最佳实践可以提高代码的可重复性和性能，为我们的开发和研究工作带来便利。

## 参考资料
- 《Python 数据分析实战》
- 《Python 机器学习基础教程》