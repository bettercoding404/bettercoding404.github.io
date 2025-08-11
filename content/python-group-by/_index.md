---
title: "Python Group By：数据分组与聚合的强大工具"
description: "在数据分析和处理过程中，我们常常需要按照某些特定的条件对数据进行分组，然后对每个分组执行一些计算或操作。Python 提供了多种实现 `group by` 功能的方法，这些方法能帮助我们高效地处理和分析数据。本文将深入探讨 Python 中 `group by` 的相关概念、使用方法、常见实践以及最佳实践，助您更好地掌握这一强大的数据处理技术。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在数据分析和处理过程中，我们常常需要按照某些特定的条件对数据进行分组，然后对每个分组执行一些计算或操作。Python 提供了多种实现 `group by` 功能的方法，这些方法能帮助我们高效地处理和分析数据。本文将深入探讨 Python 中 `group by` 的相关概念、使用方法、常见实践以及最佳实践，助您更好地掌握这一强大的数据处理技术。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `collections.defaultdict` 实现 `group by`
    - 使用 `pandas` 库实现 `group by`
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
`group by` 操作的核心思想是根据一个或多个键对数据集进行分组，然后对每个分组的数据执行特定的计算或操作。在 Python 中，`group by` 并不是一个内置的单一函数，而是通过不同的数据结构和库来实现类似数据库中 `GROUP BY` 语句的功能。通过分组，我们可以将数据按照特定的逻辑进行归类，以便进行更有针对性的分析和处理。

## 使用方法
### 使用 `collections.defaultdict` 实现 `group by`
`collections.defaultdict` 是 Python 标准库中的一个工具，它可以简化分组操作。`defaultdict` 会在访问不存在的键时自动创建一个默认值，这在分组数据时非常有用。

```python
from collections import defaultdict

data = [('apple', 10), ('banana', 5), ('apple', 15), ('banana', 8)]

grouped_data = defaultdict(list)
for key, value in data:
    grouped_data[key].append(value)

for key, values in grouped_data.items():
    print(f"{key}: {values}")
```

在上述代码中，我们使用 `defaultdict(list)` 创建了一个默认值为列表的字典。遍历数据列表时，根据键将值添加到对应的列表中，从而实现了按水果名称分组。

### 使用 `pandas` 库实现 `group by`
`pandas` 是 Python 中用于数据处理和分析的强大库，提供了非常便捷的 `groupby` 方法。

```python
import pandas as pd

data = {
    'fruit': ['apple', 'banana', 'apple', 'banana'],
    'quantity': [10, 5, 15, 8]
}

df = pd.DataFrame(data)
grouped = df.groupby('fruit')

for fruit, group in grouped:
    print(f"Fruit: {fruit}")
    print(group)
```

在这段代码中，我们首先创建了一个 `DataFrame`，然后使用 `groupby` 方法按 `fruit` 列进行分组。`groupby` 操作返回一个可迭代的对象，我们可以遍历它来获取每个分组的数据。

## 常见实践
### 分组计数
统计每个分组中元素的数量是常见的操作之一。

```python
import pandas as pd

data = {
    'category': ['A', 'B', 'A', 'B', 'B'],
    'value': [1, 2, 3, 4, 5]
}

df = pd.DataFrame(data)
counts = df.groupby('category').size()
print(counts)
```

### 分组求和
对每个分组中的数值进行求和也是经常需要做的操作。

```python
import pandas as pd

data = {
    'category': ['A', 'B', 'A', 'B', 'B'],
    'value': [1, 2, 3, 4, 5]
}

df = pd.DataFrame(data)
sums = df.groupby('category')['value'].sum()
print(sums)
```

### 分组求均值
计算每个分组中数值的平均值同样很有用。

```python
import pandas as pd

data = {
    'category': ['A', 'B', 'A', 'B', 'B'],
    'value': [1, 2, 3, 4, 5]
}

df = pd.DataFrame(data)
means = df.groupby('category')['value'].mean()
print(means)
```

## 最佳实践
### 性能优化
- **数据类型选择**：确保数据框中的列数据类型正确。例如，将整数列存储为合适的整数类型（如 `int8`、`int16` 等），可以减少内存占用并提高计算速度。
- **避免不必要的复制**：`pandas` 中的一些操作可能会导致数据的复制，尽量使用就地操作（如 `inplace=True`）来减少额外的内存开销和提高性能。

### 代码可读性优化
- **使用有意义的变量名**：在进行 `group by` 操作时，给变量和分组对象取有意义的名字，以便代码易于理解和维护。
- **合理拆分代码**：如果 `group by` 操作涉及多个复杂的计算或步骤，可以将代码拆分成多个函数，每个函数负责一个具体的任务，这样代码结构会更清晰。

## 小结
Python 中的 `group by` 功能通过不同的方法和库为我们提供了强大的数据分组和聚合能力。`collections.defaultdict` 适用于简单的分组场景，而 `pandas` 库则在数据处理和分析中表现出色，提供了丰富的分组和聚合方法。在实际应用中，我们需要根据具体的需求选择合适的方法，并注意性能优化和代码可读性。掌握这些技巧，将能更高效地处理和分析数据，解决各种实际问题。

## 参考资料
- [Python官方文档 - collections模块](https://docs.python.org/3/library/collections.html)
- [pandas官方文档 - groupby](https://pandas.pydata.org/pandas-docs/stable/reference/groupby.html)