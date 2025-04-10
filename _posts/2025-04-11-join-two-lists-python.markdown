---
title: "在Python中合并两个列表"
description: "在Python编程中，合并两个列表是一项常见的操作。无论是在数据处理、算法实现还是日常的脚本编写中，我们经常需要将两个不同的列表组合成一个新的列表。本文将详细介绍在Python中合并两个列表的基础概念、多种使用方法、常见实践场景以及最佳实践，帮助你更好地掌握这一操作。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，合并两个列表是一项常见的操作。无论是在数据处理、算法实现还是日常的脚本编写中，我们经常需要将两个不同的列表组合成一个新的列表。本文将详细介绍在Python中合并两个列表的基础概念、多种使用方法、常见实践场景以及最佳实践，帮助你更好地掌握这一操作。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 方法一：使用 `+` 运算符
    - 方法二：使用 `extend()` 方法
    - 方法三：使用 `append()` 方法
    - 方法四：使用列表推导式
    - 方法五：使用 `itertools.chain()` 方法
3. 常见实践
    - 数据合并
    - 列表拼接用于循环操作
4. 最佳实践
    - 根据性能选择方法
    - 代码可读性和简洁性
5. 小结
6. 参考资料

## 基础概念
在Python中，列表是一种有序的可变数据类型，可以包含各种不同类型的元素。合并两个列表，简单来说，就是将两个列表中的元素组合到一个新的列表中。新列表包含了原来两个列表中的所有元素，并且保持元素在原始列表中的顺序。

## 使用方法

### 方法一：使用 `+` 运算符
这是最直观和常用的方法之一。`+` 运算符可以直接将两个列表连接起来，生成一个新的列表。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list1 + list2
print(result)  
```

### 方法二：使用 `extend()` 方法
`extend()` 方法会将一个列表中的所有元素添加到另一个列表的末尾。它会修改调用该方法的原始列表，而不是返回一个新的列表。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)
print(list1)  
```

### 方法三：使用 `append()` 方法
`append()` 方法用于将一个元素添加到列表的末尾。如果要合并两个列表，可以遍历其中一个列表，将每个元素逐个 `append` 到另一个列表中。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
for element in list2:
    list1.append(element)
print(list1)  
```

### 方法四：使用列表推导式
列表推导式是一种简洁的创建列表的方式。可以通过列表推导式将两个列表合并。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = [element for sublist in [list1, list2] for element in sublist]
print(result)  
```

### 方法五：使用 `itertools.chain()` 方法
`itertools.chain()` 方法可以将多个可迭代对象连接成一个迭代器。如果需要合并多个列表或者处理大型列表，这个方法会很有用。

```python
import itertools

list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list(itertools.chain(list1, list2))
print(result)  
```

## 常见实践

### 数据合并
在数据处理场景中，经常需要将从不同数据源获取到的数据列表合并成一个完整的数据集。例如，从两个文件中读取数据到两个列表，然后合并这两个列表进行进一步的分析。

```python
file1_data = [1, 2, 3]
file2_data = [4, 5, 6]
combined_data = file1_data + file2_data
# 后续可以对 combined_data 进行数据分析操作
```

### 列表拼接用于循环操作
有时候，我们需要将多个相关的列表合并成一个列表，以便在循环中统一处理。

```python
list1 = ['a', 'b', 'c']
list2 = ['d', 'e', 'f']
combined_list = list1 + list2
for char in combined_list:
    print(char)  
```

## 最佳实践

### 根据性能选择方法
- 如果只是简单地合并两个小列表，使用 `+` 运算符是最简洁和高效的，因为它的实现相对简单。
- 当需要在原始列表上进行操作，并且性能要求较高时，`extend()` 方法是一个不错的选择，因为它直接修改原始列表，避免了创建新列表的开销。
- 对于大型列表或者需要合并多个列表的情况，`itertools.chain()` 方法性能更好，因为它是一个迭代器，不会一次性将所有元素加载到内存中。

### 代码可读性和简洁性
在选择合并列表的方法时，也要考虑代码的可读性和简洁性。例如，使用 `+` 运算符和 `extend()` 方法通常代码更简洁易懂，而列表推导式虽然强大，但对于复杂的情况可能会降低代码的可读性。

## 小结
在Python中合并两个列表有多种方法，每种方法都有其特点和适用场景。`+` 运算符简单直观，适合快速合并小列表；`extend()` 方法用于在原始列表上添加元素；`append()` 方法适用于逐个添加元素的场景；列表推导式提供了一种灵活的方式；`itertools.chain()` 方法在处理大型数据或多个列表时性能更优。在实际编程中，应根据具体需求选择最合适的方法，同时兼顾性能和代码的可读性。

## 参考资料
- [Python官方文档 - 列表操作](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python官方文档 - itertools模块](https://docs.python.org/3/library/itertools.html){: rel="nofollow"}