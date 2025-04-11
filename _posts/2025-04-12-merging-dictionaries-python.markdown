---
title: "Python 中合并字典的全面指南"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它用于存储键值对（key-value pairs）。在实际开发中，我们常常会遇到需要将多个字典合并成一个字典的需求。本文将深入探讨在 Python 中合并字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要操作。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它用于存储键值对（key-value pairs）。在实际开发中，我们常常会遇到需要将多个字典合并成一个字典的需求。本文将深入探讨在 Python 中合并字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要操作。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `update()` 方法
    - 使用字典解包（Dictionary Unpacking）
    - 使用 `collections.ChainMap`
3. 常见实践
    - 合并具有相同键的字典
    - 合并多个字典
4. 最佳实践
    - 性能考量
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
字典是 Python 中的一种无序数据结构，它通过键来访问对应的值。每个键值对之间用逗号分隔，整个字典用花括号 `{}` 包围。例如：
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'c': 3, 'd': 4}
```
合并字典就是将两个或多个字典中的键值对组合到一个新的字典中。如果不同字典中有相同的键，那么在合并后的字典中，后出现的键值对会覆盖先出现的键值对。

## 使用方法

### 使用 `update()` 方法
`update()` 方法是 Python 字典的内置方法，用于将一个字典的所有键值对添加到另一个字典中。如果有重复的键，会用新字典中的值覆盖旧字典中的值。

示例代码：
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

dict1.update(dict2)
print(dict1)  
```
输出结果：
```
{'a': 1, 'b': 3, 'c': 4}
```
在这个例子中，`dict1` 调用 `update()` 方法并传入 `dict2`，`dict2` 中的键值对被添加到 `dict1` 中，`dict1` 中原本的 `'b': 2` 被 `dict2` 中的 `'b': 3` 覆盖。

### 使用字典解包（Dictionary Unpacking）
从 Python 3.5 开始，可以使用字典解包来合并字典。字典解包允许我们在创建新字典时展开一个或多个字典的键值对。

示例代码：
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

new_dict = {**dict1, **dict2}
print(new_dict)  
```
输出结果：
```
{'a': 1, 'b': 3, 'c': 4}
```
这里通过 `{**dict1, **dict2}` 创建了一个新的字典 `new_dict`，`dict1` 和 `dict2` 的键值对被合并到了一起，同样，重复的键 `'b'` 以 `dict2` 中的值为准。

### 使用 `collections.ChainMap`
`collections.ChainMap` 是 Python 标准库中 `collections` 模块提供的一个类，它用于将多个字典或其他映射对象组合成一个单一的映射视图。与前面两种方法不同，`ChainMap` 并不会创建一个新的字典，而是将多个字典链接在一起，在查找键时会按照顺序依次在各个字典中查找。

示例代码：
```python
from collections import ChainMap

dict1 = {'a': 1, 'b': 2}
dict2 = {'b': 3, 'c': 4}

chain_map = ChainMap(dict1, dict2)
print(chain_map)  
print(chain_map['b'])  
```
输出结果：
```
ChainMap({'a': 1, 'b': 2}, {'b': 3, 'c': 4})
2
```
在这个例子中，创建了一个 `ChainMap` 对象 `chain_map`，它包含了 `dict1` 和 `dict2`。当访问 `chain_map['b']` 时，会先在 `dict1` 中查找，找到 `'b': 2`，所以返回 2。如果 `dict1` 中没有该键，才会继续在 `dict2` 中查找。

## 常见实践

### 合并具有相同键的字典
有时候我们需要合并具有相同键的字典，并且希望对相同键的值进行特定的处理，比如相加。

示例代码：
```python
dict1 = {'a': 1, 'b': 2}
dict2 = {'a': 3, 'b': 4}

result = {}
for key in set(list(dict1.keys()) + list(dict2.keys())):
    value1 = dict1.get(key, 0)
    value2 = dict2.get(key, 0)
    result[key] = value1 + value2

print(result)  
```
输出结果：
```
{'a': 4, 'b': 6}
```
在这个例子中，通过遍历两个字典的键，获取对应键的值并相加，将结果存储在新字典 `result` 中。

### 合并多个字典
当需要合并多个字典时，可以使用字典解包的方式进行简洁的操作。

示例代码：
```python
dict1 = {'a': 1}
dict2 = {'b': 2}
dict3 = {'c': 3}

new_dict = {**dict1, **dict2, **dict3}
print(new_dict)  
```
输出结果：
```
{'a': 1, 'b': 2, 'c': 3}
```
通过将多个字典进行解包，一次性合并成一个新字典。

## 最佳实践

### 性能考量
- **`update()` 方法**：`update()` 方法会直接修改原始字典，对于小字典来说，性能较好。但如果字典很大，频繁调用 `update()` 可能会有一定的性能开销，因为它需要不断调整字典的内部结构。
- **字典解包**：字典解包在语法上更简洁，对于创建新字典非常方便。在性能方面，与 `update()` 方法在大多数情况下相差不大，但在处理大量数据时，由于它会创建新的字典对象，可能会占用更多的内存。
- **`collections.ChainMap`**：`ChainMap` 不会创建新的字典，只是将多个字典链接在一起，因此在处理大量字典时，内存使用效率更高。但由于它是按顺序查找键，查找性能可能会稍低于直接操作单个字典。

### 代码可读性
- **字典解包**：字典解包的语法简洁明了，在代码中能够直观地表达合并字典的意图，尤其适用于简单的合并操作，能提高代码的可读性。
- **`update()` 方法**：`update()` 方法虽然是修改原始字典，但在一些复杂的逻辑中，使用它可以避免创建过多的中间变量，也能使代码逻辑更加清晰。
- **`collections.ChainMap`**：`ChainMap` 适用于需要保留多个字典原始结构，并且需要在多个字典中按顺序查找键的场景，在这种情况下，使用 `ChainMap` 能使代码更符合逻辑，提高可读性。

## 小结
在 Python 中合并字典有多种方法，每种方法都有其特点和适用场景。`update()` 方法适用于直接修改原始字典；字典解包语法简洁，适合创建新的合并字典；`collections.ChainMap` 则在处理多个字典链接和内存效率方面有优势。在实际开发中，需要根据具体的需求，综合考虑性能和代码可读性等因素，选择最合适的方法来合并字典。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/zh-cn/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}
- [Python 官方文档 - collections.ChainMap](https://docs.python.org/zh-cn/3/library/collections.html#collections.ChainMap){: rel="nofollow"}