---
title: "Python Pandas：逐行读取CSV文件"
description: "在数据处理和分析任务中，经常需要读取CSV（逗号分隔值）文件。Python的Pandas库提供了强大的功能来处理此类文件。其中，逐行读取CSV文件是一种常见需求，它允许我们对文件中的每一行数据进行单独处理，比如数据清洗、转换或执行特定的计算。本文将深入探讨如何使用Pandas逐行读取CSV文件，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在数据处理和分析任务中，经常需要读取CSV（逗号分隔值）文件。Python的Pandas库提供了强大的功能来处理此类文件。其中，逐行读取CSV文件是一种常见需求，它允许我们对文件中的每一行数据进行单独处理，比如数据清洗、转换或执行特定的计算。本文将深入探讨如何使用Pandas逐行读取CSV文件，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
Pandas是Python中用于数据处理和分析的核心库。`read_csv`函数是Pandas中用于读取CSV文件的主要方法。通常情况下，`read_csv`会将整个CSV文件读入一个DataFrame对象中，DataFrame是Pandas中用于存储和操作表格数据的二维结构。

然而，有时候我们并不想一次性将整个文件加载到内存中，或者需要对每一行数据进行独立的处理。这时候就需要逐行读取CSV文件。

## 使用方法

### 方法一：使用`iterrows`
`iterrows`方法是DataFrame对象的一个迭代器，它可以按行遍历DataFrame。首先，我们需要使用`read_csv`将CSV文件读入DataFrame，然后使用`iterrows`逐行访问数据。

```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('example.csv')

# 逐行遍历DataFrame
for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"Row Data: {row}")
```

在上述代码中：
- `index`是每一行的索引。
- `row`是一个包含该行所有列数据的Series对象。

### 方法二：使用`itertuples`
`itertuples`方法也是一个迭代器，它以命名元组的形式返回每一行数据。这种方式在访问数据时效率更高，因为命名元组的属性访问速度比字典快。

```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('example.csv')

# 逐行遍历DataFrame
for row in df.itertuples():
    print(row)
```

在这个例子中，`row`是一个命名元组，我们可以通过属性名或索引来访问其中的数据。例如，如果CSV文件有列`col1`和`col2`，可以使用`row.col1`或`row[1]`（索引从1开始）来访问相应的数据。

### 方法三：使用`chunksize`参数
`read_csv`函数有一个`chunksize`参数，它允许我们将CSV文件分块读取。通过设置合适的`chunksize`，我们可以逐块处理文件，而不是一次性加载整个文件。

```python
import pandas as pd

# 分块读取CSV文件
chunksize = 1000
for chunk in pd.read_csv('example.csv', chunksize=chunksize):
    for index, row in chunk.iterrows():
        print(f"Index: {index}")
        print(f"Row Data: {row}")
```

在这个代码中，`chunksize`设置为1000，表示每次读取1000行数据。然后在每个分块中，我们可以使用`iterrows`逐行处理数据。这种方法在处理大型CSV文件时非常有用，可以减少内存占用。

## 常见实践

### 数据清洗
在逐行读取CSV文件时，可以对每一行数据进行清洗操作。例如，去除字符串列中的空格，或者将日期列转换为合适的日期格式。

```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('example.csv')

# 逐行遍历DataFrame并清洗数据
for index, row in df.iterrows():
    # 假设第一列是字符串列，去除两端空格
    row[0] = row[0].strip()
    # 假设第二列是日期列，转换为日期格式
    try:
        row[1] = pd.to_datetime(row[1])
    except ValueError:
        pass
    # 更新DataFrame中的行
    df.loc[index] = row

print(df)
```

### 数据转换
可以对每一行数据进行转换操作，例如计算新的列值。

```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('example.csv')

# 逐行遍历DataFrame并转换数据
for index, row in df.iterrows():
    # 假设第一列和第二列是数值列，计算它们的乘积并添加新列
    new_col = row[0] * row[1]
    df.at[index, 'new_column'] = new_col

print(df)
```

### 数据过滤
根据特定条件过滤掉某些行。

```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('example.csv')

# 逐行遍历DataFrame并过滤数据
rows_to_keep = []
for index, row in df.iterrows():
    # 假设第一列是数值列，只保留大于10的行
    if row[0] > 10:
        rows_to_keep.append(index)

filtered_df = df.loc[rows_to_keep]
print(filtered_df)
```

## 最佳实践

### 内存管理
在处理大型CSV文件时，内存管理至关重要。使用`chunksize`参数分块读取文件可以有效减少内存占用。同时，及时释放不再使用的内存对象，避免内存泄漏。

### 性能优化
- 尽量使用`itertuples`而不是`iterrows`，因为`itertuples`的性能更高。
- 如果需要对数据进行复杂的计算或处理，可以考虑使用`numba`等库进行加速。

### 错误处理
在逐行处理数据时，要做好错误处理。例如，在数据转换或计算过程中可能会出现错误，使用`try - except`块捕获并处理这些错误，以确保程序的稳定性。

## 小结
本文详细介绍了使用Python Pandas逐行读取CSV文件的方法，包括基础概念、不同的使用方式（`iterrows`、`itertuples`、`chunksize`）、常见实践（数据清洗、转换、过滤）以及最佳实践（内存管理、性能优化、错误处理）。通过掌握这些知识，读者可以更加灵活和高效地处理CSV文件中的数据，满足各种数据处理和分析的需求。

## 参考资料
- [Pandas官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- [Python数据分析实战（第2版）](https://book.douban.com/subject/30328180/){: rel="nofollow"}