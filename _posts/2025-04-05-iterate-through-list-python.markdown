---
title: "在 Python 中遍历列表：基础、用法与最佳实践"
description: "在 Python 编程中，列表（list）是一种极为常用的数据结构，它可以存储多个元素，并且这些元素可以是不同的数据类型。遍历列表（iterate through list）是指依次访问列表中的每个元素，这是一个非常基础且频繁使用的操作。掌握如何高效地遍历列表对于编写简洁、高效的 Python 代码至关重要。本文将详细介绍在 Python 中遍历列表的基础概念、各种使用方法、常见实践场景以及最佳实践技巧。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

# 在 Python 中遍历列表：基础、用法与最佳实践

## 简介
在 Python 编程中，列表（list）是一种极为常用的数据结构，它可以存储多个元素，并且这些元素可以是不同的数据类型。遍历列表（iterate through list）是指依次访问列表中的每个元素，这是一个非常基础且频繁使用的操作。掌握如何高效地遍历列表对于编写简洁、高效的 Python 代码至关重要。本文将详细介绍在 Python 中遍历列表的基础概念、各种使用方法、常见实践场景以及最佳实践技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `for` 循环遍历列表
    - 使用 `while` 循环遍历列表
    - 使用 `enumerate` 函数遍历列表
    - 使用 `zip` 函数同时遍历多个列表
3. 常见实践
    - 对列表元素进行操作
    - 条件筛选列表元素
    - 嵌套列表遍历
4. 最佳实践
    - 性能优化
    - 代码可读性提升
5. 小结
6. 参考资料

## 基础概念
遍历列表，简单来说，就是按照一定顺序逐个访问列表中的元素。在 Python 中，列表是有序的可变序列，这意味着我们可以按照插入的顺序访问其中的元素，并且可以对列表进行修改、添加或删除元素等操作。遍历列表通常用于对列表中的每个元素执行相同或相似的操作，比如计算列表中所有数字的总和、对列表中的字符串进行格式化等等。

## 使用方法
### 使用 `for` 循环遍历列表
`for` 循环是 Python 中最常用的遍历列表的方式。它的语法简洁明了，能够直接迭代列表中的元素。

```python
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)
```

在上述代码中，`for` 循环依次将 `fruits` 列表中的每个元素赋值给变量 `fruit`，然后执行循环体中的 `print(fruit)` 语句，从而输出列表中的每个水果名称。

### 使用 `while` 循环遍历列表
`while` 循环也可以用于遍历列表，但这种方式相对复杂一些，需要手动管理索引。

```python
fruits = ["apple", "banana", "cherry"]
index = 0
while index < len(fruits):
    print(fruits[index])
    index += 1
```

这里通过一个 `index` 变量来记录当前访问的列表元素的索引，在 `while` 循环条件中判断 `index` 是否小于列表的长度。在每次循环中，打印当前索引对应的列表元素，并将 `index` 加 1，直到 `index` 达到列表的长度，从而完成遍历。

### 使用 `enumerate` 函数遍历列表
`enumerate` 函数用于在遍历列表时同时获取元素的索引和值。

```python
fruits = ["apple", "banana", "cherry"]
for index, fruit in enumerate(fruits):
    print(f"Index {index}: {fruit}")
```

在这段代码中，`enumerate(fruits)` 返回一个包含索引和对应元素的迭代器。`for` 循环将这个迭代器解包，分别赋值给 `index` 和 `fruit`，这样我们在遍历列表时就可以同时知道元素的索引和值。

### 使用 `zip` 函数同时遍历多个列表
`zip` 函数可以将多个列表对应位置的元素组合在一起，形成一个个元组，从而实现同时遍历多个列表。

```python
fruits = ["apple", "banana", "cherry"]
prices = [1.5, 0.5, 2.0]
for fruit, price in zip(fruits, prices):
    print(f"{fruit} costs {price} dollars")
```

这里 `zip(fruits, prices)` 将 `fruits` 和 `prices` 两个列表中对应位置的元素组合成元组，`for` 循环将这些元组解包，分别赋值给 `fruit` 和 `price`，进而可以同时处理两个列表中的元素。

## 常见实践
### 对列表元素进行操作
遍历列表的一个常见用途是对列表中的每个元素进行某种操作。例如，对列表中的所有数字进行平方运算。

```python
numbers = [1, 2, 3, 4, 5]
squared_numbers = []
for number in numbers:
    squared_numbers.append(number ** 2)
print(squared_numbers)
```

在这段代码中，我们遍历 `numbers` 列表，对每个数字进行平方运算，并将结果添加到 `squared_numbers` 列表中。

### 条件筛选列表元素
我们还可以在遍历列表时根据一定条件筛选出符合要求的元素。比如，从一个列表中筛选出所有偶数。

```python
numbers = [1, 2, 3, 4, 5]
even_numbers = []
for number in numbers:
    if number % 2 == 0:
        even_numbers.append(number)
print(even_numbers)
```

这里通过 `if` 语句判断每个数字是否为偶数，如果是，则将其添加到 `even_numbers` 列表中。

### 嵌套列表遍历
当列表中的元素又是列表时，就需要进行嵌套遍历。例如，有一个二维列表表示矩阵，我们需要遍历并打印矩阵中的每个元素。

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
for row in matrix:
    for element in row:
        print(element)
```

在这段代码中，外层 `for` 循环遍历矩阵的每一行，内层 `for` 循环遍历每一行中的每个元素，从而实现对整个二维列表的遍历。

## 最佳实践
### 性能优化
在处理大型列表时，性能是一个重要的考虑因素。例如，使用列表推导式（list comprehension）可以比传统的 `for` 循环更高效地创建新列表。

```python
# 使用 for 循环创建新列表
numbers = [1, 2, 3, 4, 5]
squared_numbers = []
for number in numbers:
    squared_numbers.append(number ** 2)

# 使用列表推导式创建新列表
squared_numbers_comprehension = [number ** 2 for number in numbers]
```

列表推导式在创建新列表时通常比 `for` 循环更快，因为它是在底层用 C 语言实现的，减少了 Python 解释器的开销。

### 代码可读性提升
编写清晰、易读的代码对于团队协作和代码维护非常重要。在遍历列表时，尽量使用有意义的变量名，避免使用过于简短或模糊的变量名。同时，合理使用注释来解释代码的目的和逻辑。

```python
# 计算员工工资总和
employee_salaries = [5000, 6000, 7000, 8000]
total_salary = 0
for salary in employee_salaries:
    total_salary += salary
print(f"Total salary: {total_salary}")
```

在这段代码中，变量名 `employee_salaries` 和 `total_salary` 都很直观地表达了其含义，并且添加了注释说明代码的功能，使代码更易于理解。

## 小结
在 Python 中遍历列表是一项基础且重要的操作，掌握不同的遍历方法和常见实践场景可以帮助我们更高效地编写代码。`for` 循环和 `while` 循环是最基本的遍历方式，`enumerate` 函数和 `zip` 函数则提供了更多灵活的遍历选项。在实际应用中，我们需要根据具体需求选择合适的方法，并注意性能优化和代码可读性的提升。希望本文能帮助读者更好地理解和运用在 Python 中遍历列表的技巧。

## 参考资料
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - `enumerate` 函数](https://docs.python.org/3/library/functions.html#enumerate){: rel="nofollow"}
- [Python 官方文档 - `zip` 函数](https://docs.python.org/3/library/functions.html#zip){: rel="nofollow"}