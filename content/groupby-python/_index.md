---
title: "深入理解 Python 中的 groupby 函数"
description: "在数据分析和处理任务中，将数据按照某些特征进行分组并对每组数据执行特定操作是非常常见的需求。Python 的 `groupby` 函数提供了一种简洁而强大的方式来实现这一功能。无论是处理简单的列表数据，还是复杂的表格数据结构，`groupby` 都能发挥重要作用。本文将详细介绍 `groupby` 的基础概念、使用方法、常见实践以及最佳实践，帮助你在实际项目中更好地运用它。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在数据分析和处理任务中，将数据按照某些特征进行分组并对每组数据执行特定操作是非常常见的需求。Python 的 `groupby` 函数提供了一种简洁而强大的方式来实现这一功能。无论是处理简单的列表数据，还是复杂的表格数据结构，`groupby` 都能发挥重要作用。本文将详细介绍 `groupby` 的基础概念、使用方法、常见实践以及最佳实践，帮助你在实际项目中更好地运用它。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 对列表进行分组
    - 对字典进行分组
    - 结合迭代器使用
3. 常见实践
    - 分组求和
    - 分组计数
    - 分组获取最大值
4. 最佳实践
    - 性能优化
    - 代码可读性提升
5. 小结
6. 参考资料

## 基础概念
`groupby` 是 Python 标准库中 `itertools` 模块的一个函数。它的作用是将可迭代对象中相邻的、具有相同键值的元素分组在一起。这里的“相邻”是一个关键概念，`groupby` 并不会对整个可迭代对象进行全面的排序和分组，而是基于元素的顺序，依次检查相邻元素是否具有相同的分组键。

`groupby` 函数的基本语法如下：
```python
itertools.groupby(iterable, key=None)
```
其中，`iterable` 是要分组的可迭代对象，比如列表、元组、字典等；`key` 是一个可选参数，用于指定分组的依据。如果不提供 `key`，则默认以元素自身作为分组键。函数返回一个迭代器，每个元素是一个元组，元组的第一个元素是分组键，第二个元素是一个迭代器，包含该组的所有元素。

## 使用方法

### 对列表进行分组
假设我们有一个包含数字的列表，想要按照数字的奇偶性进行分组：
```python
from itertools import groupby

numbers = [1, 3, 5, 2, 4, 6]
grouped_numbers = groupby(numbers, key=lambda x: x % 2)

for key, group in grouped_numbers:
    print(f"Key: {key}")
    print(list(group))
```
在这个例子中，我们使用 `lambda` 函数作为 `key`，将数字按照除以 2 的余数进行分组。输出结果如下：
```
Key: 1
[1, 3, 5]
Key: 0
[2, 4, 6]
```

### 对字典进行分组
对于字典数据，我们可以按照字典的某个键值进行分组。例如，有一个包含人员信息的字典列表，我们想按照年龄进行分组：
```python
from itertools import groupby

people = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 30},
    {'name': 'Charlie', 'age': 25}
]

grouped_people = groupby(sorted(people, key=lambda x: x['age']), key=lambda x: x['age'])

for key, group in grouped_people:
    print(f"Age: {key}")
    for person in group:
        print(person)
```
这里需要注意的是，在使用 `groupby` 之前，我们先对 `people` 列表进行了排序，因为 `groupby` 是基于相邻元素进行分组的。输出结果如下：
```
Age: 25
{'name': 'Alice', 'age': 25}
{'name': 'Charlie', 'age': 25}
Age: 30
{'name': 'Bob', 'age': 30}
```

### 结合迭代器使用
`groupby` 返回的是一个迭代器，我们可以利用迭代器的特性来高效地处理分组数据。例如，我们可以使用 `next` 函数来获取下一组数据：
```python
from itertools import groupby

numbers = [1, 1, 2, 2, 3]
grouped_iter = groupby(numbers)

first_key, first_group = next(grouped_iter)
print(f"First Key: {first_key}")
print(list(first_group))
```
输出结果：
```
First Key: 1
[1, 1]
```

## 常见实践

### 分组求和
在数据分析中，经常需要对分组后的数据进行求和操作。例如，有一个包含销售记录的列表，每个记录包含产品名称和销售金额，我们想计算每个产品的总销售额：
```python
from itertools import groupby

sales = [
    ('Apple', 100),
    ('Banana', 200),
    ('Apple', 150),
    ('Banana', 100)
]

grouped_sales = groupby(sorted(sales, key=lambda x: x[0]), key=lambda x: x[0])

total_sales = {}
for key, group in grouped_sales:
    total_sales[key] = sum([sale[1] for sale in group])

print(total_sales)
```
输出结果：
```
{'Apple': 250, 'Banana': 300}
```

### 分组计数
统计每个分组中元素的个数也是常见需求。比如，有一个包含班级学生成绩的列表，我们想统计每个班级的学生人数：
```python
from itertools import groupby

students = [
    ('Class A', 85),
    ('Class B', 90),
    ('Class A', 78),
    ('Class B', 92)
]

grouped_students = groupby(sorted(students, key=lambda x: x[0]), key=lambda x: x[0])

class_count = {}
for key, group in grouped_students:
    class_count[key] = len(list(group))

print(class_count)
```
输出结果：
```
{'Class A': 2, 'Class B': 2}
```

### 分组获取最大值
有时我们需要在每个分组中找到最大值。例如，有一个包含不同地区气温记录的列表，我们想找到每个地区的最高气温：
```python
from itertools import groupby

temperatures = [
    ('North', 20),
    ('South', 30),
    ('North', 25),
    ('South', 35)
]

grouped_temperatures = groupby(sorted(temperatures, key=lambda x: x[0]), key=lambda x: x[0])

max_temperatures = {}
for key, group in grouped_temperatures:
    max_temperatures[key] = max([temp[1] for temp in group])

print(max_temperatures)
```
输出结果：
```
{'North': 25, 'South': 35}
```

## 最佳实践

### 性能优化
在处理大规模数据时，性能是一个重要问题。由于 `groupby` 是基于相邻元素分组的，所以在使用前确保数据已经按照分组键排序可以提高效率。另外，尽量使用迭代器而不是将分组结果转换为列表，以减少内存占用。例如：
```python
from itertools import groupby

# 大规模数据列表
large_numbers = list(range(1000000))

# 分组操作，使用迭代器处理
grouped_iter = groupby(large_numbers, key=lambda x: x % 100)
for key, group in grouped_iter:
    # 对每组数据进行处理，无需将组数据转换为列表
    sum_value = sum(group)
    print(f"Key: {key}, Sum: {sum_value}")
```

### 代码可读性提升
为了使代码更易读，避免使用过于复杂的 `lambda` 函数作为分组键。可以定义一个单独的函数来作为分组键，这样代码的意图更加清晰。例如：
```python
from itertools import groupby

def get_age(person):
    return person['age']

people = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 30},
    {'name': 'Charlie', 'age': 25}
]

grouped_people = groupby(sorted(people, key=get_age), key=get_age)

for key, group in grouped_people:
    print(f"Age: {key}")
    for person in group:
        print(person)
```

## 小结
`groupby` 函数是 Python 中进行数据分组操作的强大工具。通过理解其基础概念和使用方法，以及掌握常见实践和最佳实践，我们能够更加高效地处理各种数据分组需求。无论是简单的数据统计，还是复杂的数据分析任务，`groupby` 都能帮助我们快速实现目标。在实际应用中，要注意数据的排序和迭代器的使用，以提高性能和代码可读性。

## 参考资料
- 《Python 数据分析实战》