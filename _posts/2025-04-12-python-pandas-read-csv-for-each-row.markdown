---
title: "Python Pandas：逐行读取CSV文件"
description: "在数据处理任务中，读取CSV（逗号分隔值）文件是常见的操作。Python的Pandas库提供了强大的工具来处理此类任务。`pandas.read_csv`函数能够轻松地将CSV文件读入DataFrame对象中，方便进行数据清洗、分析和可视化。而在某些场景下，我们可能需要逐行读取CSV文件，对每一行数据执行特定的操作。本文将深入探讨如何使用Pandas逐行读取CSV文件，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在数据处理任务中，读取CSV（逗号分隔值）文件是常见的操作。Python的Pandas库提供了强大的工具来处理此类任务。`pandas.read_csv`函数能够轻松地将CSV文件读入DataFrame对象中，方便进行数据清洗、分析和可视化。而在某些场景下，我们可能需要逐行读取CSV文件，对每一行数据执行特定的操作。本文将深入探讨如何使用Pandas逐行读取CSV文件，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
### CSV文件
CSV文件是一种以纯文本形式存储表格数据的文件格式，数据以逗号分隔。每行代表一条记录，每列的数据项由逗号隔开。例如：
```
姓名,年龄,城市
张三,25,北京
李四,30,上海
```

### Pandas DataFrame
Pandas的DataFrame是一个二维的表格型数据结构，它由行和列组成，可以看作是一个电子表格。`pandas.read_csv`函数通常会将CSV文件内容读入一个DataFrame对象中，方便进行各种数据操作。

### 逐行读取的需求
在某些情况下，我们可能不想一次性将整个CSV文件读入内存（特别是文件非常大时），或者需要对每一行数据进行单独的处理，比如进行数据验证、转换特定字段等操作。这时候就需要逐行读取CSV文件。

## 使用方法
### 传统的`pandas.read_csv`读取
首先，看一下常规的使用`pandas.read_csv`读取CSV文件的方法：
```python
import pandas as pd

# 读取CSV文件到DataFrame
df = pd.read_csv('data.csv')
print(df.head())
```
上述代码使用`pandas.read_csv`将名为`data.csv`的文件读入DataFrame对象`df`中，并打印出前5行数据。

### 逐行读取CSV文件
要逐行读取CSV文件，可以使用`iterrows`方法。`iterrows`是DataFrame对象的一个方法，它会生成一个迭代器，每次迭代返回一个包含行索引和该行数据的元组。
```python
import pandas as pd

df = pd.read_csv('data.csv')
for index, row in df.iterrows():
    print(f"Index: {index}")
    print(f"Row data: {row}")
```
在这个例子中，我们遍历`df.iterrows()`生成的迭代器，`index`是行索引，`row`是包含该行所有数据的Series对象。

### 使用`chunksize`参数逐块读取
另一种逐行读取（更准确地说是逐块读取）的方法是使用`chunksize`参数。当处理大文件时，将文件分成较小的块进行处理可以减少内存占用。
```python
import pandas as pd

chunk_size = 1000
for chunk in pd.read_csv('data.csv', chunksize=chunk_size):
    for index, row in chunk.iterrows():
        # 在这里对每一行进行处理
        pass
```
在上述代码中，`chunksize`设置为1000，表示每次读取1000行数据作为一个块。然后在每个块内再逐行处理数据。

## 常见实践
### 数据验证
逐行读取CSV文件可用于验证每一行的数据是否符合特定格式或条件。例如，验证年龄字段是否为正整数：
```python
import pandas as pd

df = pd.read_csv('data.csv')
for index, row in df.iterrows():
    age = row['年龄']
    if not isinstance(age, int) or age <= 0:
        print(f"Invalid age value at index {index}: {age}")
```

### 数据转换
对每一行的特定字段进行转换。比如，将城市名称统一转换为大写：
```python
import pandas as pd

df = pd.read_csv('data.csv')
for index, row in df.iterrows():
    df.at[index, '城市'] = row['城市'].upper()
print(df)
```

### 数据过滤
根据某些条件过滤行。例如，只保留年龄大于30的行：
```python
import pandas as pd

df = pd.read_csv('data.csv')
new_df = pd.DataFrame(columns=df.columns)
for index, row in df.iterrows():
    if row['年龄'] > 30:
        new_df = new_df.append(row)
print(new_df)
```

## 最佳实践
### 内存管理
在处理大文件时，使用`chunksize`参数逐块读取可以有效避免内存溢出问题。同时，在处理完每一块数据后，及时释放不再使用的内存。例如：
```python
import pandas as pd

chunk_size = 1000
for chunk in pd.read_csv('data.csv', chunksize=chunk_size):
    # 对块进行处理
    processed_chunk = chunk[chunk['年龄'] > 30]
    # 这里可以将处理后的块写入新文件或进行其他操作
    del chunk  # 释放内存
```

### 性能优化
虽然`iterrows`方便逐行处理数据，但性能相对较低。对于数值计算密集型任务，尽量使用向量化操作。例如，要对所有年龄字段加1，使用向量化操作会更快：
```python
import pandas as pd

df = pd.read_csv('data.csv')
df['年龄'] = df['年龄'] + 1
```

### 错误处理
在逐行处理数据时，添加适当的错误处理机制可以确保程序的稳定性。例如：
```python
import pandas as pd

df = pd.read_csv('data.csv')
for index, row in df.iterrows():
    try:
        # 进行数据处理操作
        age = row['年龄']
        new_age = age + 1
    except KeyError as e:
        print(f"KeyError at index {index}: {e}")
    except TypeError as e:
        print(f"TypeError at index {index}: {e}")
```

## 小结
本文详细介绍了使用Python Pandas逐行读取CSV文件的相关知识。首先介绍了CSV文件和Pandas DataFrame的基础概念，然后讲解了逐行读取的使用方法，包括`iterrows`和`chunksize`参数的使用。接着通过常见实践展示了如何在数据验证、转换和过滤等场景中应用逐行读取。最后，给出了在内存管理、性能优化和错误处理方面的最佳实践建议。希望读者通过本文能够深入理解并高效运用Python Pandas逐行读取CSV文件的技术。

## 参考资料
- [Pandas官方文档](https://pandas.pydata.org/){: rel="nofollow"}
- [Python数据分析实战（第2版）](https://book.douban.com/subject/30328124/){: rel="nofollow"}