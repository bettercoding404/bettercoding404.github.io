---
title: "Python 写入 CSV 文件：从基础到最佳实践"
description: "在数据处理和存储的领域中，CSV（逗号分隔值）文件是一种广泛使用的简单文件格式，用于存储表格数据。Python 作为一种强大的编程语言，提供了丰富的库和方法来处理 CSV 文件的写入操作。掌握 Python 写入 CSV 文件的技巧，对于数据分析师、开发者以及任何需要处理结构化数据的人来说都是至关重要的。本文将深入探讨 Python 写入 CSV 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一技术。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在数据处理和存储的领域中，CSV（逗号分隔值）文件是一种广泛使用的简单文件格式，用于存储表格数据。Python 作为一种强大的编程语言，提供了丰富的库和方法来处理 CSV 文件的写入操作。掌握 Python 写入 CSV 文件的技巧，对于数据分析师、开发者以及任何需要处理结构化数据的人来说都是至关重要的。本文将深入探讨 Python 写入 CSV 文件的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一技术。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 CSV 文件**
    - **Python 处理 CSV 文件的库**
2. **使用方法**
    - **使用 `csv` 模块写入 CSV 文件**
        - **基本写入**
        - **写入带表头的数据**
        - **使用不同分隔符写入**
    - **使用 `pandas` 库写入 CSV 文件**
        - **从 DataFrame 写入**
        - **设置参数写入**
3. **常见实践**
    - **处理 Unicode 字符**
    - **追加数据到现有 CSV 文件**
    - **写入大数据集**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
    - **代码可读性和可维护性**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 CSV 文件
CSV 文件是一种纯文本文件，它以特定的格式来存储表格数据。每一行代表表格中的一条记录，而每行中的字段（列）则使用特定的分隔符（通常是逗号）分隔开来。例如，一个简单的 CSV 文件可能如下所示：

```
姓名,年龄,城市
张三,25,北京
李四,30,上海
```

### Python 处理 CSV 文件的库
Python 有多个库可以用于处理 CSV 文件，其中最常用的是内置的 `csv` 模块和第三方库 `pandas`。

- **`csv` 模块**：Python 标准库的一部分，提供了基本的功能来读取和写入 CSV 文件。它非常适合处理简单的 CSV 文件操作。
- **`pandas` 库**：一个功能强大的数据处理和分析库，对于处理大型数据集和复杂的数据操作非常有用。它提供了方便的方法来将 DataFrame 对象写入 CSV 文件。

## 使用方法
### 使用 `csv` 模块写入 CSV 文件
#### 基本写入
下面是一个使用 `csv` 模块写入简单 CSV 文件的示例：

```python
import csv

# 要写入的数据
data = [
    ['苹果', 5, 2.5],
    ['香蕉', 10, 1.5],
    ['橙子', 8, 3.0]
]

# 打开文件并写入数据
with open('fruits.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    for row in data:
        writer.writerow(row)
```

在这个示例中：
1. 首先导入 `csv` 模块。
2. 定义一个包含数据的列表 `data`，每个内部列表代表 CSV 文件中的一行。
3. 使用 `open` 函数以写入模式打开一个名为 `fruits.csv` 的文件，并使用 `with` 语句确保文件在操作完成后正确关闭。
4. 创建一个 `csv.writer` 对象 `writer`，用于写入数据。
5. 使用 `writer.writerow` 方法逐行写入数据。

#### 写入带表头的数据
如果要写入带表头的数据，可以在写入数据行之前先写入表头行：

```python
import csv

# 表头
headers = ['水果', '数量', '价格']

# 要写入的数据
data = [
    ['苹果', 5, 2.5],
    ['香蕉', 10, 1.5],
    ['橙子', 8, 3.0]
]

# 打开文件并写入数据
with open('fruits.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(headers)
    for row in data:
        writer.writerow(row)
```

#### 使用不同分隔符写入
默认情况下，`csv.writer` 使用逗号作为分隔符。如果需要使用其他分隔符，可以在创建 `csv.writer` 对象时指定 `delimiter` 参数：

```python
import csv

# 要写入的数据
data = [
    ['苹果', 5, 2.5],
    ['香蕉', 10, 1.5],
    ['橙子', 8, 3.0]
]

# 打开文件并写入数据，使用制表符作为分隔符
with open('fruits.tsv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter='\t')
    for row in data:
        writer.writerow(row)
```

### 使用 `pandas` 库写入 CSV 文件
#### 从 DataFrame 写入
`pandas` 库的 `DataFrame` 是一个非常强大的数据结构，用于处理表格数据。下面是将 `DataFrame` 对象写入 CSV 文件的示例：

```python
import pandas as pd

# 创建 DataFrame
data = {
    '水果': ['苹果', '香蕉', '橙子'],
    '数量': [5, 10, 8],
    '价格': [2.5, 1.5, 3.0]
}
df = pd.DataFrame(data)

# 写入 CSV 文件
df.to_csv('fruits_pandas.csv', index=False)
```

在这个示例中：
1. 导入 `pandas` 库并简称为 `pd`。
2. 创建一个包含数据的字典 `data`，并使用 `pd.DataFrame` 将其转换为 `DataFrame` 对象 `df`。
3. 使用 `df.to_csv` 方法将 `DataFrame` 写入名为 `fruits_pandas.csv` 的文件，`index=False` 参数表示不写入索引列。

#### 设置参数写入
`df.to_csv` 方法有许多参数可以设置，例如分隔符、编码、是否包含表头等等。下面是一个设置分隔符和编码的示例：

```python
import pandas as pd

# 创建 DataFrame
data = {
    '水果': ['苹果', '香蕉', '橙子'],
    '数量': [5, 10, 8],
    '价格': [2.5, 1.5, 3.0]
}
df = pd.DataFrame(data)

# 写入 CSV 文件，设置分隔符为分号，编码为 UTF-8
df.to_csv('fruits_pandas.csv', sep=';', encoding='utf-8', index=False)
```

## 常见实践
### 处理 Unicode 字符
在处理包含 Unicode 字符的数据时，需要确保正确的编码设置。对于 `csv` 模块，可以在打开文件时指定编码，例如：

```python
import csv

# 要写入的数据，包含 Unicode 字符
data = [
    ['苹果', 5, 2.5],
    ['香蕉', 10, 1.5],
    ['橙子', 8, 3.0],
    ['芒果', 3, 4.0]
]

# 打开文件并写入数据，指定编码为 UTF-8
with open('fruits_unicode.csv', 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    for row in data:
        writer.writerow(row)
```

对于 `pandas` 库，`to_csv` 方法有一个 `encoding` 参数可以设置编码：

```python
import pandas as pd

# 创建包含 Unicode 字符的 DataFrame
data = {
    '水果': ['苹果', '香蕉', '橙子', '芒果'],
    '数量': [5, 10, 8, 3],
    '价格': [2.5, 1.5, 3.0, 4.0]
}
df = pd.DataFrame(data)

# 写入 CSV 文件，设置编码为 UTF-8
df.to_csv('fruits_unicode_pandas.csv', encoding='utf-8', index=False)
```

### 追加数据到现有 CSV 文件
使用 `csv` 模块追加数据到现有 CSV 文件，可以将文件打开模式设置为 `'a'`（追加模式）：

```python
import csv

# 要追加的数据
new_data = [
    ['草莓', 12, 5.0]
]

# 打开文件并追加数据
with open('fruits.csv', 'a', newline='') as csvfile:
    writer = csv.writer(csvfile)
    for row in new_data:
        writer.writerow(row)
```

使用 `pandas` 库追加数据到现有 CSV 文件，可以先读取现有文件到 `DataFrame`，然后添加新数据，再重新写入文件：

```python
import pandas as pd

# 读取现有 CSV 文件到 DataFrame
df = pd.read_csv('fruits.csv')

# 要追加的数据
new_data = {
    '水果': ['草莓'],
    '数量': [12],
    '价格': [5.0]
}
new_df = pd.DataFrame(new_data)

# 合并 DataFrame
combined_df = pd.concat([df, new_df], ignore_index=True)

# 重新写入 CSV 文件
combined_df.to_csv('fruits.csv', index=False)
```

### 写入大数据集
当处理大数据集时，性能是一个重要的考虑因素。对于 `csv` 模块，可以使用 `writerows` 方法一次性写入多行数据，而不是逐行写入：

```python
import csv

# 生成大量数据
data = []
for i in range(100000):
    data.append([f'数据{i}', i, i * 1.5])

# 打开文件并写入数据
with open('big_data.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(data)
```

对于 `pandas` 库，`to_csv` 方法本身已经针对大数据集进行了优化。可以通过设置 `chunksize` 参数来分块写入数据，以减少内存占用：

```python
import pandas as pd

# 生成大量数据
data = {
    '数据': [f'数据{i}' for i in range(100000)],
    '编号': list(range(100000)),
    '值': [i * 1.5 for i in range(100000)]
}
df = pd.DataFrame(data)

# 分块写入 CSV 文件
df.to_csv('big_data_pandas.csv', index=False, chunksize=1000)
```

## 最佳实践
### 错误处理
在写入 CSV 文件时，可能会遇到各种错误，例如文件权限问题、磁盘空间不足等。因此，应该进行适当的错误处理。例如，使用 `try-except` 块来捕获异常：

```python
import csv

# 要写入的数据
data = [
    ['苹果', 5, 2.5],
    ['香蕉', 10, 1.5],
    ['橙子', 8, 3.0]
]

try:
    with open('fruits.csv', 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        for row in data:
            writer.writerow(row)
except IOError as e:
    print(f"写入文件时发生错误: {e}")
```

### 性能优化
除了前面提到的写入大数据集的优化方法外，还可以考虑以下性能优化措施：
- **减少不必要的操作**：避免在写入循环中进行过多的计算或其他操作，尽量将这些操作提前完成。
- **使用适当的数据结构**：选择合适的数据结构来存储数据，以提高写入效率。例如，`pandas` 的 `DataFrame` 在处理大型数据集时通常比普通列表更高效。

### 代码可读性和可维护性
为了使代码更易于理解和维护，可以采取以下措施：
- **添加注释**：在关键代码段添加注释，解释代码的功能和意图。
- **函数封装**：将重复的代码封装成函数，提高代码的复用性。
- **合理命名**：给变量、函数和文件起一个有意义的名字，便于理解代码的逻辑。

## 小结
本文深入探讨了 Python 写入 CSV 文件的相关知识，包括基础概念、使用 `csv` 模块和 `pandas` 库的使用方法、常见实践以及最佳实践。通过掌握这些内容，读者可以更加灵活、高效地处理 CSV 文件的写入操作，无论是简单的数据记录还是复杂的大数据集处理都能应对自如。在实际应用中，根据具体需求选择合适的方法和库，并注意错误处理、性能优化和代码质量，将有助于编写更加健壮和高效的代码。

## 参考资料
- [Python 官方文档 - csv 模块](https://docs.python.org/3/library/csv.html)
- [pandas 官方文档 - to_csv 方法](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.to_csv.html)
- 《Python 数据分析实战》
- 《利用 Python 进行数据分析》