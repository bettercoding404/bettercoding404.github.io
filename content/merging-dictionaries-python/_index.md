---
title: "Python 中合并字典的深度解析"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。在实际开发过程中，我们常常会遇到需要将多个字典合并成一个字典的需求。本文将深入探讨在 Python 中合并字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助你更好地运用这一技术。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。在实际开发过程中，我们常常会遇到需要将多个字典合并成一个字典的需求。本文将深入探讨在 Python 中合并字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助你更好地运用这一技术。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `update()` 方法
    - 使用字典解包（Python 3.5+）
    - 使用 `collections.ChainMap`
3. 常见实践
    - 合并具有相同键的字典
    - 合并嵌套字典
4. 最佳实践
    - 性能考量
    - 代码可读性与维护性
5. 小结
6. 参考资料

## 基础概念
字典合并，简单来说，就是将两个或多个字典中的键值对整合到一个新的字典中。如果不同字典中存在相同的键，合并时会根据不同的方法产生不同的结果。例如，某些方法会用新字典中的值覆盖旧字典中相同键的值，而有些方法则会保留所有的值。理解这些不同的行为对于正确合并字典至关重要。

## 使用方法

### 使用 `update()` 方法
`update()` 方法是 Python 字典的内置方法，用于将一个字典的所有键值对添加到另一个字典中。如果有重复的键，原字典中的值会被新字典中的值覆盖。

```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

dict1.update(dict2)
print(dict1) 
```
在上述代码中，`dict2` 的键值对被添加到 `dict1` 中，由于 `dict1` 和 `dict2` 都有键 `b`，所以 `dict1` 中 `b` 的值被 `dict2` 中的值 3 覆盖。最终输出 `{'a': 1, 'b': 3, 'c': 4}`。

### 使用字典解包（Python 3.5+）
从 Python 3.5 开始，我们可以使用字典解包的方式来合并字典。这种方法会创建一个新的字典，包含所有字典中的键值对。同样，如果有重复的键，后面字典中的值会覆盖前面字典中的值。

```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

new_dict = {**dict1, **dict2}
print(new_dict) 
```
代码中，通过 `{**dict1, **dict2}` 解包 `dict1` 和 `dict2` 并创建一个新的字典 `new_dict`。输出结果与使用 `update()` 方法类似，为 `{'a': 1, 'b': 3, 'c': 4}`。

### 使用 `collections.ChainMap`
`collections.ChainMap` 是 Python 标准库中的一个类，它可以将多个字典或映射对象组合成一个单一的视图。与前面两种方法不同，`ChainMap` 并不会创建一个新的字典，而是在内部维护一个字典列表。当访问一个键时，它会按照列表顺序依次在各个字典中查找。

```python
from collections import ChainMap

dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

chain_map = ChainMap(dict1, dict2)
print(chain_map) 
```
运行这段代码，输出 `ChainMap({'a': 1, 'b': 2}, {'b': 3, 'c': 4})`。如果访问一个键，例如 `print(chain_map['b'])`，它会首先在 `dict1` 中查找，找到则返回对应的值；如果 `dict1` 中没有，再在 `dict2` 中查找。所以这里会输出 `2`。

## 常见实践

### 合并具有相同键的字典
在实际应用中，我们可能希望合并具有相同键的字典时，将对应的值进行某种操作，而不是简单地覆盖。例如，将相同键的值相加。

```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

result = {}
for key in set(dict1.keys()) | set(dict2.keys()):
    if key in dict1 and key in dict2:
        result[key] = dict1[key] + dict2[key]
    elif key in dict1:
        result[key] = dict1[key]
    else:
        result[key] = dict2[key]

print(result) 
```
上述代码通过遍历两个字典的键，对相同键的值进行相加操作，最终输出 `{'a': 1, 'b': 5, 'c': 4}`。

### 合并嵌套字典
合并嵌套字典会更加复杂，因为不仅要处理顶级的键值对，还要递归处理嵌套的字典。

```python
dict1 = {'a': 1, 'nested': {'b': 2}}
dict2 = {'nested': {'c': 3}}

def merge_nested_dicts(dict1, dict2):
    result = dict1.copy()
    for key, value in dict2.items():
        if key in result and isinstance(result[key], dict) and isinstance(value, dict):
            result[key] = merge_nested_dicts(result[key], value)
        else:
            result[key] = value
    return result

merged_dict = merge_nested_dicts(dict1, dict2)
print(merged_dict) 
```
在这个例子中，`merge_nested_dicts` 函数递归地合并嵌套字典。输出结果为 `{'a': 1, 'nested': {'b': 2, 'c': 3}}`。

## 最佳实践

### 性能考量
如果需要合并大量字典，字典解包和 `update()` 方法可能会创建大量临时对象，导致性能下降。在这种情况下，`collections.ChainMap` 可能是更好的选择，因为它不会创建新的字典，而是直接使用原字典。

### 代码可读性与维护性
在选择合并字典的方法时，要考虑代码的可读性和维护性。字典解包的语法简洁明了，适合在简单场景下使用；而 `update()` 方法则更直观，易于理解。如果涉及复杂的合并逻辑，如嵌套字典的合并，编写一个专门的函数会使代码结构更清晰。

## 小结
本文详细介绍了在 Python 中合并字典的多种方法，包括 `update()` 方法、字典解包和 `collections.ChainMap`。同时，我们探讨了常见实践场景，如合并具有相同键的字典和嵌套字典。在实际应用中，需要根据具体需求选择合适的方法，兼顾性能、代码可读性和维护性。掌握这些技巧将有助于你在 Python 编程中更高效地处理字典数据。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/library/stdtypes.html#dict)
- [Python 官方文档 - collections.ChainMap](https://docs.python.org/3/library/collections.html#collections.ChainMap)