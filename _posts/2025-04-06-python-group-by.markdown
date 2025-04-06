---
title: "Python Group By：数据分组与聚合的强大工具"
description: "在数据分析和处理任务中，经常需要按照某些特定的条件对数据进行分组，然后对每个分组进行相应的计算或操作。Python 提供了多种方式来实现类似 SQL 中 `GROUP BY` 的功能，这些方法能帮助我们高效地处理和分析结构化数据。本文将深入探讨 Python 中实现分组操作的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据分析和处理任务中，经常需要按照某些特定的条件对数据进行分组，然后对每个分组进行相应的计算或操作。Python 提供了多种方式来实现类似 SQL 中 `GROUP BY` 的功能，这些方法能帮助我们高效地处理和分析结构化数据。本文将深入探讨 Python 中实现分组操作的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `collections.defaultdict` 实现分组
    - 使用 `pandas` 库实现分组
3. 常见实践
    - 分组计数
    - 分组求和
    - 分组求均值
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
`GROUP BY` 的核心思想是将数据按照一个或多个键进行分组，然后对每个分组执行特定的操作。在 Python 中，这通常涉及到将具有相同键值的数据聚集在一起，以便我们可以对每个分组的数据进行聚合计算，比如求和、计数、求平均值等。

## 使用方法

### 使用 `collections.defaultdict` 实现分组
`collections.defaultdict` 是 Python 标准库中一个非常实用的数据结构，它可以简化分组操作。下面是一个简单的示例，展示如何按类别对产品进行分组：

```python
from collections import defaultdict

products = [
    ("水果", "苹果"),
    ("蔬菜", "胡萝卜"),
    ("水果", "香蕉"),
    ("蔬菜", "西兰花")
]

grouped_products = defaultdict(list)
for category, product in products:
    grouped_products[category].append(product)

for category, products in grouped_products.items():
    print(f"{category}: {products}")
```

### 使用 `pandas` 库实现分组
`pandas` 是 Python 中用于数据处理和分析的强大库，它提供了简洁而高效的 `groupby` 方法。假设我们有一个包含学生成绩的数据框，想要按班级分组并计算每个班级的平均成绩：

```python
import pandas as pd

data = {
    '班级': ['A', 'B', 'A', 'B'],
    '成绩': [85, 90, 78, 92]
}

df = pd.DataFrame(data)
grouped = df.groupby('班级')
average_scores = grouped['成绩'].mean()
print(average_scores)
```

## 常见实践

### 分组计数
计算每个分组中元素的数量是常见的操作。使用 `pandas`，可以这样实现：

```python
counts = grouped['成绩'].count()
print(counts)
```

### 分组求和
对每个分组中的数值进行求和：

```python
sums = grouped['成绩'].sum()
print(sums)
```

### 分组求均值
前面已经展示过，使用 `pandas` 求分组均值非常简单：

```python
means = grouped['成绩'].mean()
print(means)
```

## 最佳实践

### 性能优化
- **大数据集处理**：当处理大数据集时，`pandas` 的 `groupby` 方法已经经过高度优化，但如果性能仍然是瓶颈，可以考虑使用 `Dask` 库。`Dask` 是一个用于并行计算的库，它提供了与 `pandas` 类似的 API，能够在多核心 CPU 或分布式计算环境中高效处理大数据。

### 代码可读性优化
- **使用函数式编程风格**：在使用 `collections.defaultdict` 进行分组时，可以使用 `functools.reduce` 等函数式编程工具来使代码更加简洁和易读。例如：

```python
from collections import defaultdict
from functools import reduce

products = [
    ("水果", "苹果"),
    ("蔬菜", "胡萝卜"),
    ("水果", "香蕉"),
    ("蔬菜", "西兰花")
]

grouped_products = reduce(lambda d, x: (d[x[0]].append(x[1]), d)[1], products, defaultdict(list))
for category, products in grouped_products.items():
    print(f"{category}: {products}")
```

## 小结
Python 提供了多种方式来实现数据的分组操作，从标准库中的 `collections.defaultdict` 到强大的 `pandas` 库。理解这些方法的基础概念和使用场景，能够帮助我们在不同的数据分析任务中选择最合适的工具。通过遵循最佳实践，我们还可以优化代码的性能和可读性，提高开发效率。

## 参考资料
- [Python 官方文档 - collections](https://docs.python.org/3/library/collections.html){: rel="nofollow"}
- [pandas 官方文档 - groupby](https://pandas.pydata.org/pandas-docs/stable/reference/groupby.html){: rel="nofollow"}
- [Dask 官方文档](https://docs.dask.org/en/latest/){: rel="nofollow"}