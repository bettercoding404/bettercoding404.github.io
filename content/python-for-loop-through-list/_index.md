---
title: "Python 中遍历列表的 for 循环"
description: "在 Python 编程中，列表（list）是一种非常常用的数据结构，它可以存储多个元素，并且这些元素可以是不同的数据类型。而 `for` 循环则是用于遍历可迭代对象（如列表）的重要工具。通过 `for` 循环遍历列表，我们可以对列表中的每个元素执行相同或不同的操作，这极大地提高了代码的效率和可维护性。本文将深入探讨 Python 中使用 `for` 循环遍历列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（list）是一种非常常用的数据结构，它可以存储多个元素，并且这些元素可以是不同的数据类型。而 `for` 循环则是用于遍历可迭代对象（如列表）的重要工具。通过 `for` 循环遍历列表，我们可以对列表中的每个元素执行相同或不同的操作，这极大地提高了代码的效率和可维护性。本文将深入探讨 Python 中使用 `for` 循环遍历列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本的 for 循环遍历列表
    - 遍历列表并获取索引
3. 常见实践
    - 对列表元素进行计算
    - 筛选列表元素
    - 嵌套列表的遍历
4. 最佳实践
    - 避免在循环中修改列表
    - 使用 enumerate 函数获取索引和值
    - 使用列表推导式简化代码
5. 小结
6. 参考资料

## 基础概念
`for` 循环是 Python 中的一种迭代控制结构，用于重复执行一段代码块。当使用 `for` 循环遍历列表时，它会依次从列表中取出每个元素，并将该元素赋值给一个临时变量（在循环体中使用），然后执行循环体中的代码。每一次循环迭代，这个临时变量都会被赋值为列表中的下一个元素，直到遍历完整个列表。

## 使用方法
### 基本的 for 循环遍历列表
```python
fruits = ['apple', 'banana', 'cherry']
for fruit in fruits:
    print(fruit)
```
在上述代码中，`fruits` 是一个包含三个水果名称的列表。`for fruit in fruits` 这一行代码定义了一个 `for` 循环，`fruit` 是一个临时变量，它会依次被赋值为 `fruits` 列表中的每个元素。在每次循环中，`print(fruit)` 语句会将当前的水果名称打印出来。

### 遍历列表并获取索引
有时候，我们不仅需要获取列表中的元素值，还需要知道元素所在的索引位置。在 Python 中，可以使用 `enumerate` 函数来实现这一点。
```python
fruits = ['apple', 'banana', 'cherry']
for index, fruit in enumerate(fruits):
    print(f"Index {index}: {fruit}")
```
`enumerate` 函数会返回一个包含索引和元素的元组，在循环中，我们使用 `index` 和 `fruit` 分别接收元组中的索引和元素值。这样就可以在遍历列表的同时获取每个元素的索引和值，并打印出来。

## 常见实践
### 对列表元素进行计算
假设我们有一个包含数字的列表，想要计算列表中所有数字的总和。
```python
numbers = [1, 2, 3, 4, 5]
total = 0
for number in numbers:
    total += number
print(f"The sum is: {total}")
```
在这个例子中，我们初始化了一个变量 `total` 为 0，然后使用 `for` 循环遍历 `numbers` 列表。在每次循环中，将当前的数字加到 `total` 变量中，最后打印出总和。

### 筛选列表元素
我们可以根据某些条件筛选出列表中的特定元素。例如，从一个包含数字的列表中筛选出所有偶数。
```python
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_numbers = []
for number in numbers:
    if number % 2 == 0:
        even_numbers.append(number)
print(f"Even numbers: {even_numbers}")
```
在这个代码中，我们遍历 `numbers` 列表，使用 `if` 语句判断每个数字是否为偶数。如果是偶数，就将其添加到 `even_numbers` 列表中。最后打印出筛选出的偶数列表。

### 嵌套列表的遍历
如果列表中的元素又是一个列表，即嵌套列表，我们需要使用多层 `for` 循环来遍历。
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
在这个例子中，外层 `for` 循环遍历 `matrix` 列表中的每一行（即每个子列表），内层 `for` 循环遍历当前行中的每个元素，并将其打印出来。

## 最佳实践
### 避免在循环中修改列表
在循环中直接修改列表可能会导致意外的结果。例如，当我们尝试删除列表中的某些元素时：
```python
numbers = [1, 2, 3, 4, 5]
for number in numbers:
    if number % 2 == 0:
        numbers.remove(number)
print(numbers)
```
这段代码的预期结果可能是删除所有偶数，但实际上，由于在循环过程中修改了列表的长度，导致某些元素被跳过。正确的做法是创建一个新的列表，将需要保留的元素添加到新列表中。
```python
numbers = [1, 2, 3, 4, 5]
new_numbers = []
for number in numbers:
    if number % 2 != 0:
        new_numbers.append(number)
print(new_numbers)
```

### 使用 enumerate 函数获取索引和值
如前面所述，`enumerate` 函数是获取列表元素索引和值的最佳方式，它的语法简洁明了，并且易于理解。相比手动维护索引变量，使用 `enumerate` 函数可以减少错误的发生。

### 使用列表推导式简化代码
对于一些简单的列表操作，如筛选元素或对元素进行计算，可以使用列表推导式来简化代码。例如，筛选偶数的操作可以写成：
```python
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
even_numbers = [number for number in numbers if number % 2 == 0]
print(f"Even numbers: {even_numbers}")
```
列表推导式的语法更加紧凑，使代码更加简洁和易读。

## 小结
通过本文的介绍，我们详细了解了 Python 中使用 `for` 循环遍历列表的基础概念、多种使用方法以及常见实践和最佳实践。掌握这些知识，能够帮助我们更加高效地处理列表数据，编写出更简洁、易读且健壮的代码。在实际编程中，根据具体需求选择合适的遍历方式和技巧，能够提高开发效率，减少错误的发生。

## 参考资料
- [Python 官方文档 - for 循环](https://docs.python.org/3/tutorial/controlflow.html#for-statements)
- [Python 官方文档 - 列表](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)