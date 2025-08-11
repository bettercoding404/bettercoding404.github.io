---
title: "Python 中扁平化列表（flatten a list）"
description: "在 Python 编程中，处理数据结构时常常会遇到嵌套列表的情况。有时我们需要将这些嵌套的列表 “扁平化”，即将多层嵌套的列表转换为单层列表。这在数据处理、算法实现等多个场景下都非常有用。本文将详细介绍在 Python 中如何实现列表扁平化操作，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，处理数据结构时常常会遇到嵌套列表的情况。有时我们需要将这些嵌套的列表 “扁平化”，即将多层嵌套的列表转换为单层列表。这在数据处理、算法实现等多个场景下都非常有用。本文将详细介绍在 Python 中如何实现列表扁平化操作，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用循环实现**
    - **使用列表推导式**
    - **使用 itertools.chain()**
    - **使用递归函数**
3. **常见实践**
    - **处理不同层次的嵌套列表**
    - **处理包含不同类型元素的嵌套列表**
4. **最佳实践**
    - **性能考量**
    - **代码可读性与简洁性**
5. **小结**
6. **参考资料**

## 基础概念
“扁平化列表（flatten a list）” 指的是将一个嵌套的列表结构转换为一维列表。例如，给定一个嵌套列表 `[[1, 2], [3, 4], [5, 6]]`，扁平化后将得到 `[1, 2, 3, 4, 5, 6]`。这一操作可以简化数据处理流程，方便进行后续的计算、统计等操作。

## 使用方法

### 使用循环实现
最直观的方法是使用多层循环来遍历嵌套列表，并将元素添加到新的列表中。

```python
nested_list = [[1, 2], [3, 4], [5, 6]]
flattened_list = []

for sublist in nested_list:
    for element in sublist:
        flattened_list.append(element)

print(flattened_list)  
```

### 使用列表推导式
列表推导式提供了一种更简洁的方式来实现相同的功能。

```python
nested_list = [[1, 2], [3, 4], [5, 6]]
flattened_list = [element for sublist in nested_list for element in sublist]
print(flattened_list)  
```

### 使用 itertools.chain()
`itertools.chain()` 函数可以将多个可迭代对象连接成一个迭代器。结合 `list()` 函数可以实现列表扁平化。

```python
from itertools import chain

nested_list = [[1, 2], [3, 4], [5, 6]]
flattened_list = list(chain(*nested_list))
print(flattened_list)  
```

### 使用递归函数
当列表的嵌套层次不确定时，递归函数是一个很好的解决方案。

```python
def flatten(lst):
    result = []
    for element in lst:
        if isinstance(element, list):
            result.extend(flatten(element))
        else:
            result.append(element)
    return result

nested_list = [[1, [2, 3]], 4, [5, 6]]
flattened_list = flatten(nested_list)
print(flattened_list)  
```

## 常见实践

### 处理不同层次的嵌套列表
实际应用中，列表的嵌套层次可能不同。递归函数在处理这种情况时非常有效。

```python
def flatten(lst):
    result = []
    for element in lst:
        if isinstance(element, list):
            result.extend(flatten(element))
        else:
            result.append(element)
    return result

nested_list = [[1, [2, [3, 4]]], 5, [6, 7]]
flattened_list = flatten(nested_list)
print(flattened_list)  
```

### 处理包含不同类型元素的嵌套列表
有时嵌套列表中可能包含不同类型的元素，我们需要确保在扁平化过程中正确处理这些元素。

```python
def flatten(lst):
    result = []
    for element in lst:
        if isinstance(element, list):
            result.extend(flatten(element))
        else:
            result.append(element)
    return result

nested_list = [[1, 'a', [2, 'b']], 3, 'c']
flattened_list = flatten(nested_list)
print(flattened_list)  
```

## 最佳实践

### 性能考量
在处理大规模数据时，性能是一个重要的考量因素。`itertools.chain()` 通常比使用循环或列表推导式具有更好的性能，因为它是基于迭代器的，不需要创建中间数据结构。

### 代码可读性与简洁性
列表推导式在简单的嵌套列表扁平化中表现出很好的可读性和简洁性。但对于复杂的嵌套结构，递归函数虽然代码量稍多，但逻辑更清晰。在选择实现方法时，需要综合考虑代码的可读性和维护性。

## 小结
在 Python 中，实现列表扁平化有多种方法，每种方法都有其适用的场景。循环和列表推导式适用于简单的嵌套结构，`itertools.chain()` 在性能上有优势，而递归函数则能处理复杂的不确定嵌套层次的列表。在实际编程中，需要根据具体需求选择最合适的方法，同时兼顾性能、可读性和维护性。

## 参考资料
- [Python 官方文档 - itertools](https://docs.python.org/3/library/itertools.html)
- [Python 列表推导式官方文档](https://docs.python.org/3/tutorial/datastructures.html#list-comprehensions)