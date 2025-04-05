---
title: "Python 写入 CSV 文件：从基础到最佳实践"
description: "在数据处理和分析的领域中，CSV（逗号分隔值）文件是一种广泛使用的文件格式，用于存储表格数据。Python 作为一种强大且灵活的编程语言，提供了丰富的库和方法来处理 CSV 文件。本文将深入探讨如何使用 Python 写入 CSV 文件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的数据处理技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据处理和分析的领域中，CSV（逗号分隔值）文件是一种广泛使用的文件格式，用于存储表格数据。Python 作为一种强大且灵活的编程语言，提供了丰富的库和方法来处理 CSV 文件。本文将深入探讨如何使用 Python 写入 CSV 文件，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的数据处理技能。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 CSV 文件**
    - **Python 处理 CSV 文件的库**
2. **使用方法**
    - **使用 `csv` 模块写入 CSV 文件**
        - **写入简单数据**
        - **写入字典数据**
    - **使用 `pandas` 库写入 CSV 文件**
3. **常见实践**
    - **处理特殊字符和编码**
    - **追加数据到 CSV 文件**
    - **处理缺失值**
4. **最佳实践**
    - **提高写入效率**
    - **数据验证和清洗**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 CSV 文件
CSV 文件是一种纯文本文件，它以逗号作为分隔符来区分不同的数据字段。每行数据代表表格中的一行记录，字段之间用逗号隔开。例如，一个简单的 CSV 文件可能如下所示：

```
姓名,年龄,城市
张三,25,北京
李四,30,上海
```

### Python 处理 CSV 文件的库
Python 有多个库可以用于处理 CSV 文件，其中最常用的是内置的 `csv` 模块和第三方库 `pandas`。
- **`csv` 模块**：Python 标准库的一部分，提供了简单而灵活的方式来读写 CSV 文件。它适用于处理基本的 CSV 文件操作，性能较为不错。
- **`pandas` 库**：一个功能强大的数据处理和分析库，提供了丰富的函数和方法来处理各种格式的数据，包括 CSV 文件。`pandas` 在数据处理和分析方面具有更高的灵活性和效率，适合处理大规模数据集和复杂的数据操作。

## 使用方法
### 使用 `csv` 模块写入 CSV 文件
#### 写入简单数据
要使用 `csv` 模块写入 CSV 文件，首先需要导入 `csv` 模块，然后创建一个 CSV 写入器对象。以下是一个简单的示例：

```python
import csv

# 数据
data = [
    ['姓名', '年龄', '城市'],
    ['张三', 25, '北京'],
    ['李四', 30, '上海']
]

# 打开文件并写入数据
with open('example.csv', 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    for row in data:
        writer.writerow(row)
```

在上述代码中：
- `import csv` 导入了 `csv` 模块。
- `open('example.csv', 'w', newline='', encoding='utf-8')` 打开一个名为 `example.csv` 的文件，以写入模式（`'w'`）打开，`newline=''` 用于避免在 Windows 系统下写入文件时出现额外的空行，`encoding='utf-8'` 设置文件编码为 UTF-8。
- `csv.writer(csvfile)` 创建一个 CSV 写入器对象。
- `writer.writerow(row)` 将每一行数据写入 CSV 文件。

#### 写入字典数据
如果数据是以字典的形式存在，可以使用 `csv.DictWriter` 来写入 CSV 文件。以下是一个示例：

```python
import csv

# 数据
data = [
    {'姓名': '张三', '年龄': 25, '城市': '北京'},
    {'姓名': '李四', '年龄': 30, '城市': '上海'}
]

# 打开文件并写入数据
with open('example_dict.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['姓名', '年龄', '城市']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for row in data:
        writer.writerow(row)
```

在上述代码中：
- `csv.DictWriter(csvfile, fieldnames=fieldnames)` 创建一个字典写入器对象，`fieldnames` 指定了 CSV 文件的列名。
- `writer.writeheader()` 写入 CSV 文件的表头。
- `writer.writerow(row)` 将字典数据写入 CSV 文件。

### 使用 `pandas` 库写入 CSV 文件
`pandas` 库提供了 `to_csv` 方法来将数据框（`DataFrame`）写入 CSV 文件。以下是一个示例：

```python
import pandas as pd

# 数据
data = {
    '姓名': ['张三', '李四'],
    '年龄': [25, 30],
    '城市': ['北京', '上海']
}

df = pd.DataFrame(data)

# 写入 CSV 文件
df.to_csv('example_pandas.csv', index=False, encoding='utf-8')
```

在上述代码中：
- `pd.DataFrame(data)` 创建一个数据框对象。
- `df.to_csv('example_pandas.csv', index=False, encoding='utf-8')` 将数据框写入 CSV 文件，`index=False` 表示不写入数据框的索引列，`encoding='utf-8'` 设置文件编码为 UTF-8。

## 常见实践
### 处理特殊字符和编码
在处理 CSV 文件时，可能会遇到包含特殊字符的数据。为了确保正确处理这些字符，需要设置合适的编码。例如，对于包含中文字符的数据，通常使用 UTF-8 编码。在前面的示例中，我们已经通过 `encoding='utf-8'` 来设置编码。

### 追加数据到 CSV 文件
如果需要将新的数据追加到已有的 CSV 文件中，可以使用 `'a'`（追加模式）打开文件。以下是一个示例：

```python
import csv

# 新数据
new_data = [
    ['王五', 35, '广州']
]

# 打开文件并追加数据
with open('example.csv', 'a', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    for row in new_data:
        writer.writerow(row)
```

### 处理缺失值
在实际数据中，可能会存在缺失值。可以在写入 CSV 文件之前对缺失值进行处理，例如填充缺失值。以下是使用 `pandas` 库填充缺失值的示例：

```python
import pandas as pd

# 包含缺失值的数据
data = {
    '姓名': ['张三', '李四', None],
    '年龄': [25, None, 35],
    '城市': ['北京', '上海', None]
}

df = pd.DataFrame(data)

# 填充缺失值
df.fillna('未知', inplace=True)

# 写入 CSV 文件
df.to_csv('example_missing.csv', index=False, encoding='utf-8')
```

## 最佳实践
### 提高写入效率
对于大规模数据集，提高写入效率非常重要。可以使用批量写入的方式，减少文件 I/O 操作的次数。例如，在使用 `csv` 模块时，可以将多行数据一次性写入文件：

```python
import csv

# 数据
data = [
    ['姓名', '年龄', '城市'],
    ['张三', 25, '北京'],
    ['李四', 30, '上海']
]

# 打开文件并写入数据
with open('example.csv', 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(data)
```

### 数据验证和清洗
在写入 CSV 文件之前，应该对数据进行验证和清洗，确保数据的准确性和一致性。例如，可以检查数据的类型、长度等。以下是一个简单的数据验证示例：

```python
import csv

# 数据
data = [
    ['张三', 25, '北京'],
    ['李四', 'thirty', '上海']  # 错误的数据
]

# 验证和清洗数据
valid_data = []
for row in data:
    new_row = []
    for value in row:
        if isinstance(value, int):
            new_row.append(value)
        elif isinstance(value, str) and value.isdigit():
            new_row.append(int(value))
        else:
            new_row.append(value)
    valid_data.append(new_row)

# 打开文件并写入数据
with open('example_valid.csv', 'w', newline='', encoding='utf-8') as csvfile:
    writer = csv.writer(csvfile)
    for row in valid_data:
        writer.writerow(row)
```

### 错误处理
在写入 CSV 文件时，可能会遇到各种错误，如文件权限问题、磁盘空间不足等。因此，应该添加适当的错误处理代码，以提高程序的健壮性。以下是一个简单的错误处理示例：

```python
import csv

# 数据
data = [
    ['张三', 25, '北京'],
    ['李四', 30, '上海']
]

try:
    # 打开文件并写入数据
    with open('example.csv', 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        for row in data:
            writer.writerow(row)
except IOError as e:
    print(f"写入文件时发生错误: {e}")
```

## 小结
本文详细介绍了使用 Python 写入 CSV 文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。通过学习这些内容，读者可以熟练掌握如何使用 `csv` 模块和 `pandas` 库来写入 CSV 文件，并能够处理实际应用中遇到的各种问题，如特殊字符处理、追加数据、处理缺失值等。同时，遵循最佳实践可以提高代码的效率和健壮性，确保数据处理的准确性和可靠性。

## 参考资料
- [Python 官方文档 - csv 模块](https://docs.python.org/3/library/csv.html){: rel="nofollow"}
- [pandas 官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}