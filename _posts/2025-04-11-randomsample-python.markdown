---
title: "深入理解 Python 中的 random.sample 函数"
description: "在 Python 的标准库中，`random` 模块提供了生成伪随机数的工具，这在很多编程场景中都非常有用，比如模拟、测试以及数据抽样等。其中，`random.sample` 函数是一个强大的工具，用于从给定的序列中随机抽取指定数量的元素，而不重复抽取。本文将详细介绍 `random.sample` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这个函数。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的标准库中，`random` 模块提供了生成伪随机数的工具，这在很多编程场景中都非常有用，比如模拟、测试以及数据抽样等。其中，`random.sample` 函数是一个强大的工具，用于从给定的序列中随机抽取指定数量的元素，而不重复抽取。本文将详细介绍 `random.sample` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这个函数。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
3. **常见实践**
    - **简单抽样**
    - **数据划分**
4. **最佳实践**
    - **确保可重复性**
    - **处理大样本**
5. **小结**
6. **参考资料**

## 基础概念
`random.sample` 函数的作用是从一个序列（如列表、元组、字符串等）中随机选择指定数量的不同元素，并返回一个包含这些元素的新列表。这个函数的核心特点在于它不会重复选择同一个元素，确保了抽样的独立性和随机性。

## 使用方法
`random.sample` 函数的语法如下：

```python
random.sample(population, k)
```

- `population`：表示要从中抽样的序列，可以是列表、元组、字符串等。
- `k`：表示要抽取的元素数量，这个值必须小于或等于 `population` 的长度。

下面是一个简单的示例，从一个列表中随机抽取 3 个元素：

```python
import random

my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
result = random.sample(my_list, 3)
print(result)
```

在这个例子中，`random.sample` 函数从 `my_list` 中随机抽取了 3 个不同的元素，并将结果存储在 `result` 中。每次运行这段代码，输出的结果可能都不同，因为抽样是随机的。

## 常见实践

### 简单抽样
简单抽样是 `random.sample` 最常见的应用场景之一。比如，在进行数据分析时，我们可能需要从大量的数据集中随机抽取一小部分数据进行初步的探索和测试。以下是一个从字符串中随机抽取几个字符的示例：

```python
import random

my_string = "abcdefghijklmnopqrstuvwxyz"
sampled_chars = random.sample(my_string, 5)
sampled_string = ''.join(sampled_chars)
print(sampled_string)
```

这个示例中，我们从包含所有小写字母的字符串中随机抽取了 5 个字符，并将它们组合成一个新的字符串。

### 数据划分
在机器学习和数据分析中，常常需要将数据集划分为训练集、验证集和测试集。`random.sample` 可以方便地实现这一功能。下面是一个将数据集划分为训练集和测试集的示例：

```python
import random

data = list(range(100))  # 生成一个包含 100 个元素的数据集
test_size = 20
test_set = random.sample(data, test_size)
train_set = [x for x in data if x not in test_set]

print("训练集大小:", len(train_set))
print("测试集大小:", len(test_set))
```

在这个例子中，我们首先创建了一个包含 100 个元素的数据集 `data`，然后使用 `random.sample` 函数从 `data` 中随机抽取 20 个元素作为测试集，剩下的元素则作为训练集。

## 最佳实践

### 确保可重复性
在某些情况下，我们希望每次运行代码时得到的随机抽样结果是相同的，这在调试和测试时非常有用。可以通过设置随机数种子来实现这一点。例如：

```python
import random

random.seed(42)  # 设置随机数种子
my_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
result = random.sample(my_list, 3)
print(result)
```

每次运行这段代码，只要随机数种子 `42` 不变，`random.sample` 抽取的结果就会相同。

### 处理大样本
当处理非常大的数据集时，直接使用 `random.sample` 可能会占用大量内存。在这种情况下，可以考虑使用迭代器或生成器来逐步处理数据。例如，可以使用 `random.SystemRandom` 结合迭代器来实现高效的抽样：

```python
import random

# 使用 SystemRandom 提高安全性和效率
rng = random.SystemRandom()

def sample_large_data(population, k):
    seen = set()
    for i in range(k):
        while True:
            item = rng.choice(population)
            if item not in seen:
                seen.add(item)
                yield item
                break

large_list = list(range(1000000))
sampled_items = list(sample_large_data(large_list, 10))
print(sampled_items)
```

这个示例中，`sample_large_data` 函数使用 `random.SystemRandom` 并通过迭代器的方式，从一个非常大的列表中抽取指定数量的元素，避免了一次性将所有数据加载到内存中。

## 小结
`random.sample` 是 Python `random` 模块中一个非常实用的函数，它为我们提供了从序列中进行随机抽样的便捷方法。通过掌握其基础概念、使用方法以及常见实践和最佳实践，我们可以在各种编程场景中灵活运用这个函数，如数据探索、机器学习模型的训练和评估等。希望本文能帮助你更好地理解和使用 `random.sample`，提升你的 Python 编程技能。

## 参考资料
- [Python 官方文档 - random 模块](https://docs.python.org/3/library/random.html){: rel="nofollow"}
- 《Python 数据分析实战》
- 《Python 机器学习基础教程》