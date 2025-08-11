---
title: "在Python中合并列表：基础、方法与最佳实践"
description: "在Python编程中，列表是一种非常常用且强大的数据结构。很多时候，我们需要将多个列表合并成一个列表，这就是“joining lists”（合并列表）的操作。掌握如何高效地合并列表，对于编写简洁、高效的Python代码至关重要。本文将深入探讨在Python中合并列表的基础概念、各种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在Python编程中，列表是一种非常常用且强大的数据结构。很多时候，我们需要将多个列表合并成一个列表，这就是“joining lists”（合并列表）的操作。掌握如何高效地合并列表，对于编写简洁、高效的Python代码至关重要。本文将深入探讨在Python中合并列表的基础概念、各种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `+` 运算符
    - 使用 `extend()` 方法
    - 使用 `itertools.chain()`
    - 列表推导式
3. 常见实践
    - 合并多个列表
    - 动态合并列表
4. 最佳实践
    - 性能考量
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在Python中，列表是一个有序的可变序列，可以包含不同类型的元素。合并列表就是将两个或多个列表的元素组合到一个新的列表中。合并操作不会改变原始列表，除非你将合并后的结果重新赋值给原始列表之一。

## 使用方法

### 使用 `+` 运算符
这是最直观的合并列表的方法。`+` 运算符会创建一个新的列表，将两个列表的元素依次添加进去。
```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list1 + list2
print(result)  
```
### 使用 `extend()` 方法
`extend()` 方法会将一个列表的所有元素添加到另一个列表的末尾。它会修改调用该方法的列表。
```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
list1.extend(list2)
print(list1)  
```
### 使用 `itertools.chain()`
`itertools.chain()` 函数来自 `itertools` 模块，它可以接受多个可迭代对象（包括列表），并返回一个迭代器，该迭代器按顺序遍历所有可迭代对象的元素。如果需要得到一个列表，可以使用 `list()` 函数将其转换。
```python
import itertools

list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list(itertools.chain(list1, list2))
print(result)  
```
### 列表推导式
可以使用列表推导式来合并列表。这种方法在需要对元素进行一些处理时非常有用。
```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = [element for sublist in [list1, list2] for element in sublist]
print(result)  
```

## 常见实践

### 合并多个列表
假设有多个列表，需要将它们合并成一个列表。
```python
list1 = [1, 2]
list2 = [3, 4]
list3 = [5, 6]

# 使用 + 运算符
result1 = list1 + list2 + list3
print(result1)  

# 使用 extend() 方法
list1.extend(list2)
list1.extend(list3)
print(list1)  

# 使用 itertools.chain()
import itertools
result2 = list(itertools.chain(list1, list2, list3))
print(result2)  
```

### 动态合并列表
在实际应用中，可能需要动态地合并列表，例如从用户输入中获取多个列表并合并。
```python
lists = []
while True:
    user_input = input("请输入一个列表（格式：[1, 2, 3]），输入空行结束：")
    if not user_input:
        break
    try:
        new_list = eval(user_input)
        lists.append(new_list)
    except SyntaxError:
        print("输入格式不正确，请重新输入。")

merged_list = []
for sublist in lists:
    merged_list.extend(sublist)
print(merged_list)  
```

## 最佳实践

### 性能考量
- **`+` 运算符**：每次使用 `+` 运算符都会创建一个新的列表，对于大型列表，这可能会消耗大量的内存和时间。
- **`extend()` 方法**：`extend()` 方法直接修改原始列表，性能较好，尤其是在需要多次扩展同一个列表时。
- **`itertools.chain()`**：`itertools.chain()` 返回一个迭代器，不需要创建中间列表，对于处理大型数据集非常高效。

### 代码可读性
- 简单的合并操作，使用 `+` 运算符或 `extend()` 方法通常更易读。
- 如果涉及复杂的逻辑或需要处理多个可迭代对象，`itertools.chain()` 或列表推导式可能更合适，但要确保代码注释清晰，以便他人理解。

## 小结
在Python中合并列表有多种方法，每种方法都有其优缺点和适用场景。`+` 运算符简单直观，但对于大型列表性能不佳；`extend()` 方法直接修改列表，性能较好；`itertools.chain()` 适用于处理多个可迭代对象且需要高效迭代的情况；列表推导式则在需要对元素进行处理时非常有用。在实际编程中，应根据具体需求和性能要求选择合适的方法，同时注重代码的可读性和可维护性。

## 参考资料
- 《Python Cookbook》