---
title: "深入理解 Python 中的 iloc：索引与数据选取的强大工具"
description: "在 Python 的数据处理领域，特别是使用 `pandas` 库时，`iloc` 是一个极为重要的功能。它为我们提供了一种基于整数位置的索引方式，让我们能够轻松地选取 DataFrame 或 Series 中的特定行和列数据。无论是小型数据集的快速操作，还是大型数据集的复杂分析，`iloc` 都能发挥关键作用。本文将详细介绍 `iloc` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一强大工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的数据处理领域，特别是使用 `pandas` 库时，`iloc` 是一个极为重要的功能。它为我们提供了一种基于整数位置的索引方式，让我们能够轻松地选取 DataFrame 或 Series 中的特定行和列数据。无论是小型数据集的快速操作，还是大型数据集的复杂分析，`iloc` 都能发挥关键作用。本文将详细介绍 `iloc` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一强大工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **选取单行数据**
    - **选取多行数据**
    - **选取单列数据**
    - **选取多列数据**
    - **选取特定行列交叉数据**
3. **常见实践**
    - **数据预处理中的应用**
    - **数据分析中的筛选操作**
4. **最佳实践**
    - **与其他索引方法结合使用**
    - **提高代码可读性和性能**
5. **小结**
6. **参考资料**

## 基础概念
`iloc` 是 `pandas` 库中用于基于整数位置进行索引的属性。在 `pandas` 的 DataFrame 或 Series 数据结构中，每一行和每一列都有对应的整数位置索引，从 0 开始计数。`iloc` 允许我们通过这些整数位置来精确地选取数据。例如，在一个包含 10 行数据的 DataFrame 中，第一行的 `iloc` 索引是 0，第二行是 1，以此类推。这与基于标签的索引（如 `loc`）有所不同，`loc` 是通过行标签和列标签来选取数据的。

## 使用方法

### 选取单行数据
要选取 DataFrame 中的单行数据，可以使用 `iloc` 并传入行的整数位置。

```python
import pandas as pd

# 创建一个示例 DataFrame
data = {
    'Name': ['Alice', 'Bob', 'Charlie', 'David'],
    'Age': [25, 30, 35, 40],
    'City': ['New York', 'Los Angeles', 'Chicago', 'Houston']
}
df = pd.DataFrame(data)

# 选取第二行数据
row = df.iloc[1]
print(row)
```

### 选取多行数据
可以通过传入一个整数范围或整数列表来选取多行数据。

```python
# 选取第一行到第三行数据（不包括第三行）
rows_range = df.iloc[0:2]
print(rows_range)

# 选取第一行和第三行数据
rows_list = df.iloc[[0, 2]]
print(rows_list)
```

### 选取单列数据
使用 `iloc` 选取单列数据时，需要传入行的索引范围（通常为 `:` 表示所有行）和列的整数位置。

```python
# 选取第二列数据
column = df.iloc[:, 1]
print(column)
```

### 选取多列数据
通过传入列的整数位置范围或整数列表来选取多列数据。

```python
# 选取第一列和第三列数据
columns_list = df.iloc[:, [0, 2]]
print(columns_list)

# 选取第一列到第二列数据（不包括第二列）
columns_range = df.iloc[:, 0:1]
print(columns_range)
```

### 选取特定行列交叉数据
可以同时传入行和列的整数位置来选取特定行列交叉的数据。

```python
# 选取第二行第二列的数据
specific_value = df.iloc[1, 1]
print(specific_value)

# 选取第一行到第二行，第一列到第二列的数据（不包括第二行和第二列）
specific_data = df.iloc[0:1, 0:1]
print(specific_data)
```

## 常见实践

### 数据预处理中的应用
在数据预处理阶段，我们可能需要删除某些特定行或列的数据。`iloc` 可以帮助我们轻松实现这一操作。

```python
# 删除第三行数据
df = df.iloc[~df.index.isin([2])]
print(df)

# 删除第二列数据
df = df.iloc[:, ~df.columns.isin(['Age'])]
print(df)
```

### 数据分析中的筛选操作
在数据分析过程中，我们常常需要根据某些条件筛选出特定的数据子集。`iloc` 可以与条件判断结合使用。

```python
# 筛选出年龄大于 30 的行数据
mask = df['Age'] > 30
filtered_df = df.iloc[mask]
print(filtered_df)
```

## 最佳实践

### 与其他索引方法结合使用
`iloc` 可以与基于标签的索引方法 `loc` 结合使用，以充分发挥两者的优势。例如，在处理既有整数索引又有标签索引的数据时，可以先使用 `loc` 基于标签筛选出一部分数据，再使用 `iloc` 基于整数位置进行进一步的精细选取。

```python
# 先使用 loc 基于标签筛选出部分数据
sub_df = df.loc[df['City'] == 'New York']
# 再使用 iloc 选取第一行数据
result = sub_df.iloc[0]
print(result)
```

### 提高代码可读性和性能
为了提高代码的可读性和性能，尽量避免在复杂的计算中频繁使用 `iloc`。可以先将需要的数据提取出来，存储在临时变量中，再进行后续操作。另外，在使用 `iloc` 选取大量数据时，注意切片操作的范围，避免不必要的数据加载。

## 小结
`iloc` 是 Python 中 `pandas` 库提供的一个强大的基于整数位置索引的工具。通过掌握其基础概念、使用方法、常见实践以及最佳实践，我们能够更加高效地处理和分析数据。无论是简单的数据选取，还是复杂的数据预处理和分析任务，`iloc` 都能成为我们的得力助手，帮助我们在数据处理的道路上更加顺畅地前行。

## 参考资料
- [pandas 官方文档 - iloc](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.iloc.html)
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)