---
title: "深入理解 Python Pandas 中按行读取 CSV 文件"
description: "在数据处理领域，Python 的 Pandas 库是一个强大且广泛使用的工具。当处理 CSV（逗号分隔值）文件时，我们常常需要对文件中的每一行数据进行特定的操作。“python pandas read csv for each row” 这一主题聚焦于如何使用 Pandas 逐行读取 CSV 文件内容，并进行各种处理，从而满足不同的数据处理需求。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在数据处理领域，Python 的 Pandas 库是一个强大且广泛使用的工具。当处理 CSV（逗号分隔值）文件时，我们常常需要对文件中的每一行数据进行特定的操作。“python pandas read csv for each row” 这一主题聚焦于如何使用 Pandas 逐行读取 CSV 文件内容，并进行各种处理，从而满足不同的数据处理需求。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
Pandas 是一个用于数据处理和分析的 Python 库。`read_csv` 函数是 Pandas 中用于读取 CSV 文件的核心方法，它可以将 CSV 文件内容加载到 DataFrame（一种二维表格结构的数据类型）中。而 “按行读取” 意味着我们可以逐行访问 DataFrame 中的数据，对每一行执行各种计算、转换或其他操作。

## 使用方法
### 基本读取
首先，我们需要导入 Pandas 库，并使用 `read_csv` 读取 CSV 文件。

```python
import pandas as pd

# 读取 CSV 文件到 DataFrame
df = pd.read_csv('example.csv')
```

### 逐行遍历
有几种方法可以逐行遍历 DataFrame。

#### 方法一：使用 iterrows()
`iterrows()` 方法会返回一个生成器，生成每一行的索引和数据（以 Series 形式）。

```python
for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"Row Data: {row}")
    print("-" * 30)
```

#### 方法二：使用 itertuples()
`itertuples()` 方法同样返回一个生成器，但它返回的是命名元组，访问速度通常比 `iterrows()` 更快。

```python
for row in df.itertuples():
    print(row)
    print("-" * 30)
```

## 常见实践
### 数据清洗
在读取每一行时，可以检查和处理缺失值或异常值。

```python
for index, row in df.iterrows():
    if pd.isnull(row['column_name']):
        df.at[index, 'column_name'] = 0  # 用 0 填充缺失值
    elif row['column_name'] < 0:
        df.at[index, 'column_name'] = 0  # 将负值设为 0
```

### 计算新列
可以基于现有列的值计算新的列。

```python
df['new_column'] = 0
for index, row in df.iterrows():
    df.at[index, 'new_column'] = row['column1'] + row['column2']
```

## 最佳实践
### 避免频繁修改 DataFrame
虽然在上面的例子中我们在遍历过程中修改了 DataFrame，但这种做法在处理大数据集时效率较低。更好的方法是创建新的列表，存储处理后的数据，最后再将其转换为新的列。

```python
new_column_data = []
for index, row in df.iterrows():
    new_value = row['column1'] + row['column2']
    new_column_data.append(new_value)

df['new_column'] = new_column_data
```

### 使用向量化操作
只要可能，尽量使用 Pandas 的向量化操作，而不是逐行遍历。例如，计算新列可以这样做：

```python
df['new_column'] = df['column1'] + df['column2']
```

向量化操作利用了底层的优化，执行速度更快。

## 小结
通过本文，我们深入探讨了 “python pandas read csv for each row” 的相关内容。了解了基础概念，掌握了逐行读取 CSV 文件并遍历 DataFrame 的不同方法。同时，我们看到了常见实践场景以及如何遵循最佳实践来提高代码效率和性能。在实际的数据处理工作中，根据具体需求选择合适的方法和实践，能够更高效地完成任务。

## 参考资料
- [Pandas 官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- 《Python for Data Analysis》（Wes McKinney 著）