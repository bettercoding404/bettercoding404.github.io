---
title: "Python 中 DataFrame 聚合操作详解"
description: "在数据分析领域，Python 的 `pandas` 库无疑是处理数据的强大工具。其中，DataFrame 作为 `pandas` 库的核心数据结构之一，提供了丰富的功能来处理和分析表格型数据。聚合操作（aggregation）是 DataFrame 数据处理中常用的功能，它允许我们对数据进行汇总和计算，例如求平均值、总和、计数等。掌握 DataFrame 聚合操作，能帮助我们更高效地从大量数据中提取有价值的信息。本文将深入探讨 Python 中 DataFrame 聚合操作的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在数据分析领域，Python 的 `pandas` 库无疑是处理数据的强大工具。其中，DataFrame 作为 `pandas` 库的核心数据结构之一，提供了丰富的功能来处理和分析表格型数据。聚合操作（aggregation）是 DataFrame 数据处理中常用的功能，它允许我们对数据进行汇总和计算，例如求平均值、总和、计数等。掌握 DataFrame 聚合操作，能帮助我们更高效地从大量数据中提取有价值的信息。本文将深入探讨 Python 中 DataFrame 聚合操作的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 简单聚合函数
    - 按列聚合
    - 分组聚合
3. 常见实践
    - 计算统计指标
    - 分组后多指标聚合
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
DataFrame 聚合操作是指对 DataFrame 中的数据按照一定的规则进行汇总计算，将多个数据值合并为一个或多个汇总值。常见的聚合操作包括求和、求平均值、计数、求最大值、求最小值等。聚合操作通常会改变 DataFrame 的形状，从原始的多行多列数据转换为包含汇总信息的较少行数或列数的数据结构。

## 使用方法

### 简单聚合函数
`pandas` 提供了一系列简单的聚合函数，可以直接应用于 DataFrame。以下是一些常见的简单聚合函数示例：

```python
import pandas as pd

# 创建一个示例 DataFrame
data = {
    'col1': [1, 2, 3, 4, 5],
    'col2': [5, 4, 3, 2, 1]
}
df = pd.DataFrame(data)

# 计算每列的总和
total = df.sum()
print("每列总和:\n", total)

# 计算每列的平均值
mean = df.mean()
print("\n每列平均值:\n", mean)

# 计算每列的最大值
max_value = df.max()
print("\n每列最大值:\n", max_value)
```

### 按列聚合
我们可以选择特定的列进行聚合操作。例如，只计算 `col1` 列的总和：

```python
col1_total = df['col1'].sum()
print("col1 总和:", col1_total)
```

### 分组聚合
分组聚合是更强大的功能，它允许我们按照某一列或多列的值对数据进行分组，然后对每个分组分别进行聚合操作。例如，假设有一个包含学生成绩的数据表，我们想按班级计算平均成绩：

```python
student_data = {
    'class': ['A', 'A', 'B', 'B', 'B'],
   'score': [80, 90, 70, 75, 85]
}
student_df = pd.DataFrame(student_data)

grouped_mean = student_df.groupby('class').mean()
print("按班级分组后的平均成绩:\n", grouped_mean)
```

## 常见实践

### 计算统计指标
在数据分析中，我们常常需要计算多个统计指标。例如，计算每个班级成绩的总和、平均值、最大值和最小值：

```python
grouped_stats = student_df.groupby('class').agg({
   'score': ['sum','mean','max','min']
})
print("按班级分组后的统计指标:\n", grouped_stats)
```

### 分组后多指标聚合
有时候，我们希望对不同的列应用不同的聚合函数。例如，对 `class` 列计数，对 `score` 列求平均值：

```python
grouped_multi_agg = student_df.groupby('class').agg({
    'class': 'count',
   'score':'mean'
})
print("分组后多指标聚合:\n", grouped_multi_agg)
```

## 最佳实践

### 性能优化
当处理大规模数据时，性能优化非常重要。可以使用 `transform` 方法来避免数据的重复计算。例如，我们想在原 DataFrame 中添加一列，显示每个学生成绩与班级平均成绩的差值：

```python
student_df['score_diff'] = student_df['score'] - student_df.groupby('class')['score'].transform('mean')
print("添加成绩差值列后的 DataFrame:\n", student_df)
```

### 代码可读性优化
为了提高代码的可读性，可以将复杂的聚合操作封装成函数。例如：

```python
def custom_aggregation(group):
    return {
       'score_sum': group['score'].sum(),
       'score_mean': group['score'].mean()
    }

custom_grouped = student_df.groupby('class').apply(custom_aggregation).unstack()
print("使用自定义函数进行聚合:\n", custom_grouped)
```

## 小结
本文详细介绍了 Python 中 DataFrame 聚合操作的相关内容，从基础概念到各种使用方法，再到常见实践和最佳实践。通过掌握这些知识，读者能够更加熟练地运用 DataFrame 聚合操作进行数据分析，从复杂的数据中快速提取有价值的信息。无论是简单的统计计算还是复杂的分组聚合，都可以通过合适的方法高效实现。

## 参考资料
- [pandas 官方文档](https://pandas.pydata.org/docs/){: rel="nofollow"}
- 《利用 Python 进行数据分析》（美）Wes McKinney 著，唐学韬 译 