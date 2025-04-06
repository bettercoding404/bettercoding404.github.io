---
title: "Python 中使用 Lambda 进行排序：基础与实践"
description: "在 Python 编程中，排序是一项常见的任务。`lambda` 表达式为排序操作提供了一种简洁而强大的方式来定义自定义排序规则。本文将深入探讨如何在 Python 中使用 `lambda` 表达式进行排序，从基础概念到常见实践以及最佳实践，帮助你更好地掌握这一技巧，提升代码效率与可读性。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，排序是一项常见的任务。`lambda` 表达式为排序操作提供了一种简洁而强大的方式来定义自定义排序规则。本文将深入探讨如何在 Python 中使用 `lambda` 表达式进行排序，从基础概念到常见实践以及最佳实践，帮助你更好地掌握这一技巧，提升代码效率与可读性。

<!-- more -->
## 目录
1. **基础概念**
    - **什么是 Lambda 表达式**
    - **排序函数简介**
2. **使用方法**
    - **对列表进行排序**
    - **对字典列表进行排序**
3. **常见实践**
    - **按多个条件排序**
    - **反向排序**
4. **最佳实践**
    - **提高性能**
    - **保持代码可读性**
5. **小结**
6. **参考资料**

## 基础概念
### 什么是 Lambda 表达式
在 Python 中，`lambda` 表达式是一种匿名函数，它可以在需要函数对象的任何地方使用。`lambda` 表达式的语法如下：
```python
lambda arguments: expression
```
其中，`arguments` 是函数的参数，`expression` 是一个表达式，其值将作为函数的返回值。例如：
```python
add = lambda x, y: x + y
result = add(3, 5)
print(result)  # 输出 8
```

### 排序函数简介
Python 中有两个常用的排序函数：`sorted()` 和列表的 `sort()` 方法。

- `sorted()` 函数返回一个新的已排序列表，原列表保持不变。语法：`sorted(iterable, key=None, reverse=False)`
- 列表的 `sort()` 方法会直接对列表进行排序，无返回值。语法：`list.sort(key=None, reverse=False)`

其中，`key` 参数是一个函数，用于指定排序的依据。`lambda` 表达式常被用作 `key` 函数。

## 使用方法
### 对列表进行排序
假设我们有一个整数列表，要根据每个元素的绝对值进行排序。
```python
nums = [3, -5, 2, -7, 1]
sorted_nums = sorted(nums, key=lambda x: abs(x))
print(sorted_nums)  # 输出 [1, 2, 3, -5, -7]
```
在这个例子中，`lambda x: abs(x)` 作为 `key` 函数，它告诉 `sorted()` 函数根据每个元素的绝对值进行排序。

### 对字典列表进行排序
假设有一个字典列表，每个字典包含 `name` 和 `age` 两个键，我们要根据 `age` 对列表进行排序。
```python
people = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 20},
    {'name': 'Charlie', 'age': 30}
]
sorted_people = sorted(people, key=lambda person: person['age'])
print(sorted_people)  
# 输出 [{'name': 'Bob', 'age': 20}, {'name': 'Alice', 'age': 25}, {'name': 'Charlie', 'age': 30}]
```
这里 `lambda person: person['age']` 定义了排序的依据是字典中的 `age` 值。

## 常见实践
### 按多个条件排序
有时候我们需要根据多个条件进行排序。例如，先按 `age` 排序，如果 `age` 相同，再按 `name` 排序。
```python
people = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 20},
    {'name': 'Charlie', 'age': 25},
    {'name': 'David', 'age': 30}
]
sorted_people = sorted(people, key=lambda person: (person['age'], person['name']))
print(sorted_people)  
# 输出 [{'name': 'Bob', 'age': 20}, {'name': 'Alice', 'age': 25}, {'name': 'Charlie', 'age': 25}, {'name': 'David', 'age': 30}]
```
在这个 `lambda` 表达式中，我们返回一个元组 `(person['age'], person['name'])`，这样排序时会先比较 `age`，如果 `age` 相同，再比较 `name`。

### 反向排序
要进行反向排序，只需将 `reverse` 参数设置为 `True`。例如，对上述按 `age` 排序的结果进行反向排序：
```python
sorted_people = sorted(people, key=lambda person: person['age'], reverse=True)
print(sorted_people)  
# 输出 [{'name': 'David', 'age': 30}, {'name': 'Alice', 'age': 25}, {'name': 'Charlie', 'age': 25}, {'name': 'Bob', 'age': 20}]
```

## 最佳实践
### 提高性能
当处理大型数据集时，性能至关重要。避免在 `lambda` 表达式中进行复杂的计算，因为每次排序时都会调用 `key` 函数。如果需要复杂计算，可以提前将结果存储在新的变量或数据结构中，然后在 `lambda` 表达式中使用这些预计算的值。

### 保持代码可读性
虽然 `lambda` 表达式很简洁，但过于复杂的 `lambda` 表达式会降低代码的可读性。如果 `lambda` 表达式的逻辑变得复杂，考虑将其提取为一个具名函数，这样代码的意图会更加清晰。

## 小结
通过本文，我们学习了在 Python 中使用 `lambda` 表达式进行排序的相关知识。我们了解了 `lambda` 表达式的基础概念，掌握了对列表和字典列表进行排序的方法，以及按多个条件排序和反向排序的常见实践。同时，我们还探讨了在使用 `lambda` 表达式进行排序时的最佳实践，包括提高性能和保持代码可读性。希望这些内容能帮助你在实际编程中更高效地使用 `lambda` 表达式进行排序操作。

## 参考资料
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - Lambda 表达式](https://docs.python.org/3/tutorial/controlflow.html#lambda-expressions){: rel="nofollow"}