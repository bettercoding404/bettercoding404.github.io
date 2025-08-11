---
title: "深入探索 Python Pandas 中逐行读取 CSV 文件的方法"
description: "在数据处理任务中，CSV（逗号分隔值）文件是一种常见的数据存储格式。Python 的 Pandas 库为处理 CSV 文件提供了强大的功能。其中，逐行读取 CSV 文件在某些特定场景下非常有用，比如处理大文件时避免一次性加载过多数据到内存，或者需要对每一行数据进行特定的处理逻辑。本文将详细介绍 Python Pandas 中逐行读取 CSV 文件的相关知识，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在数据处理任务中，CSV（逗号分隔值）文件是一种常见的数据存储格式。Python 的 Pandas 库为处理 CSV 文件提供了强大的功能。其中，逐行读取 CSV 文件在某些特定场景下非常有用，比如处理大文件时避免一次性加载过多数据到内存，或者需要对每一行数据进行特定的处理逻辑。本文将详细介绍 Python Pandas 中逐行读取 CSV 文件的相关知识，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `iterrows` 方法
    - 使用 `itertuples` 方法
    - 使用 `read_csv` 的 `chunksize` 参数
3. 常见实践
    - 数据清洗
    - 数据转换
    - 数据过滤
4. 最佳实践
    - 性能优化
    - 内存管理
5. 小结
6. 参考资料

## 基础概念
Pandas 是 Python 中用于数据处理和分析的核心库。`read_csv` 是 Pandas 中用于读取 CSV 文件的函数，它可以将 CSV 文件的数据加载到 DataFrame（一种二维表格结构）中。而 “逐行读取 CSV 文件” 意味着我们不是一次性将整个 CSV 文件读入内存，而是按行依次处理数据。这样做的好处在于，对于大型 CSV 文件，能够有效减少内存占用，提高处理效率。

## 使用方法

### 使用 `iterrows` 方法
`iterrows` 方法允许我们按行迭代 DataFrame。在读取 CSV 文件后，通过调用 `iterrows`，可以逐行获取每一行的索引和数据。

```python
import pandas as pd

# 读取 CSV 文件
df = pd.read_csv('example.csv')

# 逐行迭代
for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"Row Data: {row}")
```

在上述代码中，`index` 是每一行的索引，`row` 是包含该行所有数据的 Series 对象。可以通过 `row['column_name']` 来访问特定列的数据。

### 使用 `itertuples` 方法
`itertuples` 方法同样用于逐行迭代 DataFrame，但它返回的是一个命名元组。相比 `iterrows`，`itertuples` 的性能通常更好。

```python
import pandas as pd

df = pd.read_csv('example.csv')

for row in df.itertuples():
    print(row)
```

返回的命名元组可以通过属性名访问列数据，例如 `row.column_name`。

### 使用 `read_csv` 的 `chunksize` 参数
`chunksize` 参数允许我们将 CSV 文件分块读取。每次读取一个指定大小的数据块，而不是一次性读取整个文件。

```python
import pandas as pd

chunksize = 1000
for chunk in pd.read_csv('example.csv', chunksize=chunksize):
    for index, row in chunk.iterrows():
        print(row)
```

在这个例子中，每次读取 `chunksize` 大小的数据块，然后对每个数据块中的行进行处理。

## 常见实践

### 数据清洗
逐行读取可以方便地处理数据清洗任务。例如，检查某一列中的数据是否符合特定格式，不符合的进行修正。

```python
import pandas as pd

df = pd.read_csv('data_with_errors.csv')

for index, row in df.iterrows():
    value = row['column_to_check']
    if not isinstance(value, int):
        try:
            df.at[index, 'column_to_check'] = int(value)
        except ValueError:
            df.at[index, 'column_to_check'] = None

df.to_csv('cleaned_data.csv', index=False)
```

### 数据转换
对每一行的数据进行转换操作。比如将日期列从一种格式转换为另一种格式。

```python
import pandas as pd
from datetime import datetime

df = pd.read_csv('data_with_dates.csv')

for index, row in df.iterrows():
    date_str = row['date_column']
    try:
        new_date = datetime.strptime(date_str, '%Y-%m-%d').strftime('%d-%m-%Y')
        df.at[index, 'date_column'] = new_date
    except ValueError:
        pass

df.to_csv('transformed_data.csv', index=False)
```

### 数据过滤
根据特定条件过滤行。例如，只保留某一列值大于特定阈值的行。

```python
import pandas as pd

df = pd.read_csv('data_to_filter.csv')

filtered_df = pd.DataFrame()

for index, row in df.iterrows():
    if row['column_to_filter'] > 100:
        filtered_df = filtered_df.append(row)

filtered_df.to_csv('filtered_data.csv', index=False)
```

## 最佳实践

### 性能优化
- 使用 `itertuples` 而非 `iterrows`，因为 `itertuples` 性能更高，特别是在处理大数据集时。
- 尽量减少在迭代过程中的函数调用，将复杂逻辑提取到外部函数并缓存结果。

### 内存管理
- 使用 `chunksize` 参数分块读取数据，避免一次性加载整个大文件到内存。
- 在处理完每一块数据后，及时释放不再使用的内存，例如使用 `del` 关键字删除不再需要的变量。

## 小结
在 Python Pandas 中，逐行读取 CSV 文件是一种强大的数据处理技术。通过 `iterrows`、`itertuples` 和 `chunksize` 等方法，我们可以灵活地处理 CSV 文件中的每一行数据。在实际应用中，这些方法在数据清洗、转换和过滤等任务中发挥着重要作用。同时，遵循最佳实践能够提高性能并有效管理内存，使我们能够更高效地处理大规模数据。

## 参考资料
- [Pandas 官方文档](https://pandas.pydata.org/docs/)
- 《Python for Data Analysis》（作者：Wes McKinney） 