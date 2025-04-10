---
title: "Python Pandas：逐行读取CSV文件"
description: "在数据处理任务中，经常需要读取CSV（逗号分隔值）文件。Python的Pandas库提供了强大而便捷的工具来处理CSV文件。其中，逐行读取CSV文件是一个常见的需求，这在处理大数据集或者需要对每一行数据进行特定操作时非常有用。本文将深入探讨如何使用Pandas逐行读取CSV文件，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在数据处理任务中，经常需要读取CSV（逗号分隔值）文件。Python的Pandas库提供了强大而便捷的工具来处理CSV文件。其中，逐行读取CSV文件是一个常见的需求，这在处理大数据集或者需要对每一行数据进行特定操作时非常有用。本文将深入探讨如何使用Pandas逐行读取CSV文件，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 基本读取
    - 迭代行
3. **常见实践**
    - 数据清洗
    - 简单计算
4. **最佳实践**
    - 性能优化
    - 内存管理
5. **小结**
6. **参考资料**

## 基础概念
Pandas是Python中用于数据处理和分析的核心库。`read_csv` 函数是Pandas用于读取CSV文件的主要工具，它将CSV文件内容加载到DataFrame对象中，DataFrame是Pandas中用于存储和处理表格数据的二维数据结构。

逐行读取CSV文件意味着一次处理一行数据，而不是将整个文件一次性加载到内存中。这在处理非常大的CSV文件时可以显著减少内存使用，并且能够实时对每一行数据进行操作。

## 使用方法

### 基本读取
首先，需要安装Pandas库（如果尚未安装），可以使用以下命令：
```bash
pip install pandas
```

下面是一个基本的读取CSV文件并创建DataFrame的示例：
```python
import pandas as pd

# 读取CSV文件
df = pd.read_csv('example.csv')
print(df.head())
```
在这个示例中，`read_csv` 函数将 `example.csv` 文件的内容读取到一个DataFrame对象 `df` 中，`head()` 方法用于显示DataFrame的前几行数据。

### 迭代行
Pandas提供了几种迭代行的方法：

1. **使用 `iterrows()` 方法**
`iterrows()` 方法按行迭代DataFrame，返回每行的索引和一个包含该行数据的Series对象。
```python
import pandas as pd

df = pd.read_csv('example.csv')

for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"Row Data: {row}")
```
在这个循环中，`index` 是行索引，`row` 是包含该行数据的Series对象。

2. **使用 `itertuples()` 方法**
`itertuples()` 方法也按行迭代DataFrame，但返回的是一个命名元组，这种方式通常比 `iterrows()` 更快。
```python
import pandas as pd

df = pd.read_csv('example.csv')

for row in df.itertuples():
    print(row)
```
命名元组的第一个元素是行索引，后续元素是该行的列值。

## 常见实践

### 数据清洗
逐行读取CSV文件可以方便地进行数据清洗。例如，假设CSV文件中有一列数据包含无效值，需要进行清理：
```python
import pandas as pd

df = pd.read_csv('data_with_invalid.csv')

for index, row in df.iterrows():
    value = row['column_name']
    if pd.isnull(value) or value == '':
        df.at[index, 'column_name'] = 'default_value'

print(df.head())
```
在这个示例中，遍历每一行数据，检查指定列的值是否为无效值（空值或空字符串），如果是，则将其替换为默认值。

### 简单计算
逐行读取也适用于对每行数据进行简单计算。例如，计算每一行中两列数据的乘积：
```python
import pandas as pd

df = pd.read_csv('data_for_calculation.csv')

for index, row in df.iterrows():
    product = row['column1'] * row['column2']
    df.at[index, 'product_column'] = product

print(df.head())
```
这里，对每一行的 `column1` 和 `column2` 进行乘法运算，并将结果存储在新的 `product_column` 列中。

## 最佳实践

### 性能优化
1. **使用 `itertuples()` 而不是 `iterrows()`**：如前文所述，`itertuples()` 通常比 `iterrows()` 更快，因为它返回的是命名元组，而不是Series对象，减少了一些开销。
2. **避免在循环中修改DataFrame**：在循环中频繁修改DataFrame会降低性能。如果可能，尽量将数据收集到列表中，然后一次性添加到DataFrame中。
```python
import pandas as pd

df = pd.read_csv('data.csv')
new_column_data = []

for row in df.itertuples():
    new_value = row.column1 + row.column2
    new_column_data.append(new_value)

df['new_column'] = new_column_data
```

### 内存管理
1. **分块读取**：对于非常大的CSV文件，可以使用 `chunksize` 参数分块读取文件，而不是一次性加载整个文件。
```python
import pandas as pd

chunk_size = 1000
for chunk in pd.read_csv('large_file.csv', chunksize=chunk_size):
    # 对每个数据块进行处理
    print(chunk.shape)
```
2. **释放不再使用的内存**：如果处理过程中不再需要某些数据，可以使用 `del` 关键字释放内存。
```python
import pandas as pd

df = pd.read_csv('data.csv')
# 处理完数据后释放内存
del df
```

## 小结
通过本文，我们深入了解了使用Python Pandas逐行读取CSV文件的方法。我们学习了基本概念，掌握了使用 `iterrows()` 和 `itertuples()` 迭代行的方法，探索了数据清洗和简单计算等常见实践，以及性能优化和内存管理的最佳实践。逐行读取CSV文件在处理大数据集和对每行数据进行特定操作时非常有用，希望这些知识能帮助读者更高效地处理CSV文件和进行数据处理任务。

## 参考资料
- [Pandas官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- [Python数据分析实战（第2版）](https://book.douban.com/subject/30328116/){: rel="nofollow"}