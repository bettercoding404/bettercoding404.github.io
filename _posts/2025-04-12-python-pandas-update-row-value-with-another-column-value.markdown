---
title: "Python Pandas：用另一列的值更新行值"
description: "在数据处理和分析中，我们常常会遇到需要用某一列的值去更新另一列的情况。Python 的 Pandas 库提供了强大且灵活的工具来完成这类操作。理解如何用另一列的值更新行值对于数据清洗、特征工程以及数据转换等任务至关重要。本文将详细介绍这一操作的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在数据处理和分析中，我们常常会遇到需要用某一列的值去更新另一列的情况。Python 的 Pandas 库提供了强大且灵活的工具来完成这类操作。理解如何用另一列的值更新行值对于数据清洗、特征工程以及数据转换等任务至关重要。本文将详细介绍这一操作的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用索引更新
    - 使用条件筛选更新
3. **常见实践**
    - 数据清洗中的应用
    - 特征工程中的应用
4. **最佳实践**
    - 性能优化
    - 代码可读性优化
5. **小结**
6. **参考资料**

## 基础概念
在 Pandas 中，DataFrame 是一个二维的表格型数据结构，由行和列组成。每一列可以看作是一个 Series。当我们想要用另一列的值更新某一行的值时，就是在修改 DataFrame 中特定位置的数据。这一操作可以基于索引（行标签）或者基于某些条件来确定要更新的行。

## 使用方法

### 使用索引更新
假设我们有一个简单的 DataFrame：
```python
import pandas as pd

data = {
    'A': [1, 2, 3],
    'B': [4, 5, 6]
}
df = pd.DataFrame(data)
print(df)
```
输出：
```
   A  B
0  1  4
1  2  5
2  3  6
```

如果我们想把第一行（索引为 0）中 `A` 列的值用 `B` 列的值更新，可以这样做：
```python
df.at[0, 'A'] = df.at[0, 'B']
print(df)
```
输出：
```
   A  B
0  4  4
1  2  5
2  3  6
```

`at` 方法用于获取和设置 DataFrame 中单个值，这里通过指定行索引和列名来更新值。

### 使用条件筛选更新
假设我们有一个包含学生成绩的 DataFrame，我们想把所有成绩小于 60 分的学生的成绩用另一列（比如平时成绩列）的值更新。
```python
data = {
    'exam_score': [55, 70, 48, 85],
    'usual_score': [60, 75, 50, 90]
}
df = pd.DataFrame(data)
print(df)
```
输出：
```
   exam_score  usual_score
0          55           60
1          70           75
2          48           50
3          85           90
```

我们可以使用布尔索引来筛选出成绩小于 60 分的行，然后进行更新：
```python
df.loc[df['exam_score'] < 60, 'exam_score'] = df.loc[df['exam_score'] < 60, 'usual_score']
print(df)
```
输出：
```
   exam_score  usual_score
0          60           60
1          70           75
2          50           50
3          85           90
```

`loc` 方法用于通过标签（行标签和列标签）来选择数据，这里通过条件筛选出行，然后同时选择要更新的列进行值的更新。

## 常见实践

### 数据清洗中的应用
在数据清洗过程中，我们可能会遇到某些列中存在缺失值或者无效值。例如，在一个包含用户年龄和出生日期的 DataFrame 中，年龄列可能存在一些错误的值（比如负数）。我们可以用出生日期重新计算年龄，并更新到年龄列。
```python
import datetime

data = {
    'age': [-5, 25, 30, -10],
    'birth_date': ['1990-01-01', '1998-05-10', '1993-07-15', '1995-11-20']
}
df = pd.DataFrame(data)
df['birth_date'] = pd.to_datetime(df['birth_date'])

now = datetime.datetime.now()
df['new_age'] = (now - df['birth_date']).dt.days // 365

df.loc[df['age'] < 0, 'age'] = df.loc[df['age'] < 0, 'new_age']
df = df.drop('new_age', axis=1)
print(df)
```

### 特征工程中的应用
在特征工程中，我们可能需要根据现有特征创建新的特征或者更新现有特征。例如，在一个包含商品价格和折扣率的 DataFrame 中，我们可以计算出实际支付价格并更新到价格列。
```python
data = {
    'price': [100, 200, 300],
    'discount_rate': [0.1, 0.2, 0.3]
}
df = pd.DataFrame(data)

df['price'] = df['price'] * (1 - df['discount_rate'])
print(df)
```

## 最佳实践

### 性能优化
当处理大规模数据时，性能是一个关键问题。使用 `at` 和 `loc` 方法在小数据量时表现良好，但在大数据量时，`apply` 方法或者向量化操作可能更高效。例如，对于上述计算实际支付价格的操作，使用向量化操作：
```python
data = {
    'price': [100, 200, 300],
    'discount_rate': [0.1, 0.2, 0.3]
}
df = pd.DataFrame(data)

df['price'] = df['price'].mul(1 - df['discount_rate'])
print(df)
```

### 代码可读性优化
为了提高代码的可读性，建议将复杂的条件筛选和更新操作分开写。例如，在更新学生成绩的例子中，可以这样写：
```python
condition = df['exam_score'] < 60
df.loc[condition, 'exam_score'] = df.loc[condition, 'usual_score']
```

## 小结
本文详细介绍了在 Python Pandas 中用另一列的值更新行值的方法。我们了解了基础概念，学习了使用索引和条件筛选进行更新的方法，探讨了在数据清洗和特征工程中的常见实践，以及性能优化和代码可读性优化的最佳实践。通过掌握这些技巧，读者能够更加高效地处理和分析数据。

## 参考资料
- [Pandas 官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- [Python for Data Analysis](https://www.oreilly.com/library/view/python-for-data/9781491957653/){: rel="nofollow"}