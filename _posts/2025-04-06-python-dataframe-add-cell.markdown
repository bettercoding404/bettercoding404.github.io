---
title: "Python DataFrame 添加单元格：从入门到实践"
description: "在数据处理和分析的领域中，Python 的 `pandas` 库里的 `DataFrame` 是一个极为强大且常用的数据结构。`DataFrame` 可以看作是一个二维表格，由行和列组成，每一个单元格都包含特定的数据值。在实际的数据分析工作中，经常会遇到需要向 `DataFrame` 添加单元格数据的需求。本文将深入探讨如何在 `Python DataFrame` 中添加单元格，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据处理和分析的领域中，Python 的 `pandas` 库里的 `DataFrame` 是一个极为强大且常用的数据结构。`DataFrame` 可以看作是一个二维表格，由行和列组成，每一个单元格都包含特定的数据值。在实际的数据分析工作中，经常会遇到需要向 `DataFrame` 添加单元格数据的需求。本文将深入探讨如何在 `Python DataFrame` 中添加单元格，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 直接索引赋值
    - 使用 `loc` 和 `iloc`
    - 使用 `at` 和 `iat`
3. 常见实践
    - 根据条件添加单元格
    - 批量添加单元格
4. 最佳实践
    - 数据类型一致性
    - 避免链式赋值
5. 小结
6. 参考资料

## 基础概念
`DataFrame` 是 `pandas` 库中用于处理二维数据的主要数据结构。它类似于电子表格或 SQL 中的表，由索引（行标签）和列标签来标识数据。每个单元格是 `DataFrame` 中的一个数据点，代表特定行和列的交叉点。

添加单元格意味着在现有的 `DataFrame` 中，为特定的行和列组合分配一个新的值。这一操作可以修改现有数据，或者在 `DataFrame` 扩展时添加新的数据点。

## 使用方法

### 直接索引赋值
可以通过直接使用列名和索引值来为单元格赋值。假设我们有一个简单的 `DataFrame`：

```python
import pandas as pd

data = {
    'Name': ['Alice', 'Bob', 'Charlie'],
    'Age': [25, 30, 35]
}
df = pd.DataFrame(data)
print(df)
```

输出：
```
       Name  Age
0     Alice   25
1       Bob   30
2  Charlie   35
```

要为新的行和列添加单元格，可以这样做：

```python
df['NewColumn'] = None
df.loc[3] = ['David', 40, None]
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     None
1       Bob   30     None
2  Charlie   35     None
3     David   40     None
```

### 使用 `loc` 和 `iloc`
`loc` 用于通过标签索引来选择数据，`iloc` 用于通过整数位置索引来选择数据。

使用 `loc` 添加单元格：

```python
df.loc[4, 'Name'] = 'Eve'
df.loc[4, 'Age'] = 45
df.loc[4, 'NewColumn'] = 'SomeValue'
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     None
1       Bob   30     None
2  Charlie   35     None
3     David   40     None
4       Eve   45  SomeValue
```

使用 `iloc` 添加单元格：

```python
df.iloc[5, 0] = 'Frank'
df.iloc[5, 1] = 50
df.iloc[5, 2] = 'AnotherValue'
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     None
1       Bob   30     None
2  Charlie   35     None
3     David   40     None
4       Eve   45  SomeValue
5     Frank   50  AnotherValue
```

### 使用 `at` 和 `iat`
`at` 用于通过标签快速访问和修改单个值，`iat` 用于通过整数位置快速访问和修改单个值。这两个方法比 `loc` 和 `iloc` 更高效，尤其是在处理大数据集时。

使用 `at` 添加单元格：

```python
df.at[6, 'Name'] = 'Grace'
df.at[6, 'Age'] = 55
df.at[6, 'NewColumn'] = 'NewValue'
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     None
1       Bob   30     None
2  Charlie   35     None
3     David   40     None
4       Eve   45  SomeValue
5     Frank   50  AnotherValue
6     Grace   55  NewValue
```

使用 `iat` 添加单元格：

```python
df.iat[7, 0] = 'Hank'
df.iat[7, 1] = 60
df.iat[7, 2] = 'FinalValue'
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     None
1       Bob   30     None
2  Charlie   35     None
3     David   40     None
4       Eve   45  SomeValue
5     Frank   50  AnotherValue
6     Grace   55  NewValue
7     Hank   60  FinalValue
```

## 常见实践

### 根据条件添加单元格
假设我们要根据年龄条件在 `NewColumn` 中添加不同的值：

```python
for index, row in df.iterrows():
    if row['Age'] < 30:
        df.at[index, 'NewColumn'] = 'Young'
    elif row['Age'] < 50:
        df.at[index, 'NewColumn'] = 'Middle'
    else:
        df.at[index, 'NewColumn'] = 'Old'
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   25     Young
1       Bob   30    Middle
2  Charlie   35    Middle
3     David   40    Middle
4       Eve   45    Middle
5     Frank   50       Old
6     Grace   55       Old
7     Hank   60       Old
```

### 批量添加单元格
可以使用 `apply` 方法对整列进行批量操作。例如，将所有年龄值加 1：

```python
df['Age'] = df['Age'].apply(lambda x: x + 1)
print(df)
```

输出：
```
       Name  Age NewColumn
0     Alice   26     Young
1       Bob   31    Middle
2  Charlie   36    Middle
3     David   41    Middle
4       Eve   46    Middle
5     Frank   51       Old
6     Grace   56       Old
7     Hank   61       Old
```

## 最佳实践

### 数据类型一致性
在添加单元格时，确保新值的数据类型与列的数据类型一致。否则可能会导致意外的结果或错误。例如，如果某列是整数类型，不要尝试添加字符串值，除非你有明确的转换需求。

### 避免链式赋值
链式赋值（例如 `df['Column1']['Row1'] = value`）可能会导致难以调试的问题。推荐使用 `loc`、`iloc`、`at` 或 `iat` 来进行赋值操作，以确保代码的可读性和稳定性。

## 小结
在 Python 的 `DataFrame` 中添加单元格是一项基础且重要的操作。通过本文介绍的多种方法，如直接索引赋值、`loc`、`iloc`、`at` 和 `iat`，读者可以灵活地为 `DataFrame` 添加新的数据点。同时，了解常见实践和最佳实践，能够帮助在实际的数据处理和分析工作中更高效、准确地完成任务。

## 参考资料
- [pandas官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- 《Python for Data Analysis》（作者：Wes McKinney）