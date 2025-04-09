---
title: "Python 中的循环语句：while 与 for"
description: "在编程世界里，循环是一项极为重要的机制，它允许我们重复执行一段代码，直到满足特定条件。Python 提供了两种主要的循环语句：`while` 和 `for`。这两种语句各有其独特的应用场景和使用方式，掌握它们对于编写高效、简洁的 Python 代码至关重要。本文将深入探讨这两种循环语句的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在编程世界里，循环是一项极为重要的机制，它允许我们重复执行一段代码，直到满足特定条件。Python 提供了两种主要的循环语句：`while` 和 `for`。这两种语句各有其独特的应用场景和使用方式，掌握它们对于编写高效、简洁的 Python 代码至关重要。本文将深入探讨这两种循环语句的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **while 循环**
    - **基础概念**
    - **使用方法**
    - **代码示例**
2. **for 循环**
    - **基础概念**
    - **使用方法**
    - **代码示例**
3. **常见实践**
    - **遍历数据结构**
    - **计数循环**
4. **最佳实践**
    - **避免无限循环**
    - **使用 else 子句**
5. **小结**
6. **参考资料**

## while 循环

### 基础概念
`while` 循环是一种条件循环，只要指定的条件为真，就会重复执行循环体中的代码块。它会在每次循环开始时检查条件，若条件仍然为真，则继续执行循环体；一旦条件变为假，循环就会终止，程序将继续执行循环体后面的代码。

### 使用方法
`while` 循环的基本语法如下：
```python
while condition:
    # 循环体代码
```
其中，`condition` 是一个表达式，其结果为布尔值（`True` 或 `False`）。当 `condition` 为 `True` 时，循环体中的代码会被执行，然后再次检查 `condition`，如此反复，直到 `condition` 为 `False`。

### 代码示例
以下是一个简单的 `while` 循环示例，用于打印从 1 到 5 的数字：
```python
count = 1
while count <= 5:
    print(count)
    count += 1
```
在这个示例中，我们首先初始化变量 `count` 为 1。然后，在 `while` 循环中，只要 `count` 小于等于 5，就会打印 `count` 的值，并将 `count` 加 1。当 `count` 变为 6 时，条件 `count <= 5` 为 `False`，循环终止。

## for 循环

### 基础概念
`for` 循环主要用于遍历可迭代对象（如列表、元组、字符串、字典等）中的元素。它会依次取出可迭代对象中的每个元素，并将其赋值给一个临时变量，然后执行循环体中的代码。与 `while` 循环不同，`for` 循环不需要手动维护循环条件和计数器。

### 使用方法
`for` 循环的基本语法如下：
```python
for element in iterable:
    # 循环体代码
```
其中，`element` 是每次循环时从 `iterable` 中取出的元素，`iterable` 是一个可迭代对象。

### 代码示例
以下是一个使用 `for` 循环遍历列表并打印每个元素的示例：
```python
fruits = ['apple', 'banana', 'cherry']
for fruit in fruits:
    print(fruit)
```
在这个示例中，`fruits` 是一个列表，`for` 循环会依次将 `fruits` 中的每个元素赋值给 `fruit` 变量，然后打印 `fruit` 的值。

## 常见实践

### 遍历数据结构
#### 遍历列表
```python
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    print(num * 2)  # 打印每个数字的两倍
```
#### 遍历字典
```python
person = {'name': 'John', 'age': 30, 'city': 'New York'}
for key, value in person.items():
    print(f"{key}: {value}")
```

### 计数循环
有时候我们需要执行固定次数的循环，这可以使用 `range()` 函数结合 `for` 循环来实现。
```python
for i in range(5):  # 从 0 到 4 循环 5 次
    print(i)
```
`while` 循环也可以实现计数循环，但需要手动维护计数器。
```python
count = 0
while count < 5:
    print(count)
    count += 1
```

## 最佳实践

### 避免无限循环
在使用 `while` 循环时，一定要确保循环条件最终会变为 `False`，否则会导致无限循环。例如：
```python
# 错误示例，无限循环
while True:
    print("这是一个无限循环")
```
为了避免这种情况，在循环体中要确保对条件变量进行适当的更新。

### 使用 else 子句
`for` 和 `while` 循环都可以有一个可选的 `else` 子句。当循环正常结束（即没有通过 `break` 语句中断）时，`else` 子句中的代码会被执行。
```python
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    if num == 6:
        break
else:
    print("没有找到数字 6")
```

## 小结
`while` 和 `for` 循环是 Python 编程中不可或缺的工具。`while` 循环适用于需要根据条件来决定循环次数的场景，而 `for` 循环则更适合遍历可迭代对象。通过理解它们的基础概念、使用方法、常见实践以及最佳实践，我们可以编写出更高效、更健壮的 Python 代码。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- 《Python 快速上手：让繁琐工作自动化》
- 《Python 核心编程》