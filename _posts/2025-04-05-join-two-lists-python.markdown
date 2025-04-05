---
title: "在Python中合并两个列表"
description: "在Python编程中，处理列表是一项常见任务。很多时候，我们需要将两个或多个列表合并成一个列表。“join two lists python”指的就是在Python语言环境下实现将两个列表合并为一个列表的操作。掌握这一技能可以极大地提高数据处理和算法实现的效率。本文将详细介绍在Python中合并两个列表的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，处理列表是一项常见任务。很多时候，我们需要将两个或多个列表合并成一个列表。“join two lists python”指的就是在Python语言环境下实现将两个列表合并为一个列表的操作。掌握这一技能可以极大地提高数据处理和算法实现的效率。本文将详细介绍在Python中合并两个列表的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `+` 运算符
    - 使用 `extend()` 方法
    - 使用 `append()` 方法
    - 使用列表推导式
    - 使用 `itertools.chain()`
3. 常见实践
    - 合并不同类型元素的列表
    - 合并多个列表
4. 最佳实践
    - 性能考量
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在Python中，列表是一种有序的可变数据类型，可以包含各种类型的元素。合并两个列表意味着将两个独立列表中的元素组合到一个新的列表中。这个新列表包含了原来两个列表中的所有元素，并且保持元素的顺序不变。

## 使用方法

### 使用 `+` 运算符
`+` 运算符可以直接用于连接两个列表，它会返回一个新的列表，新列表包含了两个操作数列表的所有元素。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list1 + list2
print(result)  
```

### 使用 `extend()` 方法
`extend()` 方法用于在一个列表的末尾添加另一个列表的所有元素。它会修改调用该方法的原始列表，而不是返回一个新列表。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)
print(list1)  
```

### 使用 `append()` 方法
`append()` 方法用于在列表的末尾添加一个元素。我们可以通过遍历第二个列表，逐个将元素添加到第一个列表中。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
for element in list2:
    list1.append(element)
print(list1)  
```

### 使用列表推导式
列表推导式提供了一种简洁的方式来创建新列表。我们可以使用列表推导式将两个列表合并。

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = [element for sublist in [list1, list2] for element in sublist]
print(result)  
```

### 使用 `itertools.chain()`
`itertools.chain()` 函数用于将多个可迭代对象连接成一个迭代器。我们可以将这个迭代器转换为列表来实现列表的合并。

```python
import itertools

list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list(itertools.chain(list1, list2))
print(result)  
```

## 常见实践

### 合并不同类型元素的列表
在实际应用中，我们可能会遇到需要合并包含不同类型元素的列表。例如：

```python
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
result = list1 + list2
print(result)  
```

### 合并多个列表
有时候我们需要合并多个列表。可以使用上述方法的组合来实现，例如使用 `+` 运算符或 `extend()` 方法依次合并多个列表。

```python
list1 = [1, 2]
list2 = [3, 4]
list3 = [5, 6]
result = list1 + list2 + list3
print(result)  

# 或者使用 extend() 方法
list1 = [1, 2]
list2 = [3, 4]
list3 = [5, 6]
list1.extend(list2)
list1.extend(list3)
print(list1)  
```

## 最佳实践

### 性能考量
- **`+` 运算符**：使用 `+` 运算符连接列表会创建一个新的列表对象，因此在处理大型列表时可能会消耗较多的内存和时间。
- **`extend()` 方法**：`extend()` 方法直接修改原始列表，避免了创建新列表的开销，性能较好，尤其适用于需要在原列表基础上扩展的场景。
- **`itertools.chain()`**：`itertools.chain()` 函数返回一个迭代器，在处理大型列表时可以节省内存，因为它不需要一次性将所有元素存储在一个新列表中。

### 代码可读性
选择合适的方法也需要考虑代码的可读性。对于简单的列表合并操作，`+` 运算符和 `extend()` 方法通常是最直观的。而列表推导式和 `itertools.chain()` 虽然功能强大，但对于不熟悉的读者可能较难理解，在代码中使用时应根据实际情况权衡。

## 小结
在Python中合并两个列表有多种方法，每种方法都有其特点和适用场景。`+` 运算符简单直观，适用于创建新列表；`extend()` 方法适合在原列表基础上扩展；`append()` 方法逐个添加元素灵活性高；列表推导式提供了一种简洁的方式；`itertools.chain()` 函数在处理大型列表时性能较好。在实际编程中，我们需要根据性能需求和代码可读性来选择最合适的方法。

## 参考资料
- [Python官方文档 - 列表操作](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python官方文档 - itertools模块](https://docs.python.org/3/library/itertools.html){: rel="nofollow"}