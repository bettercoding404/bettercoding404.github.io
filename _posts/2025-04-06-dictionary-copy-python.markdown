---
title: "Python 字典复制：深入理解与高效实践"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，用于存储键值对。当我们需要对字典进行复制操作时，有多种方式可供选择。正确理解和使用字典复制方法对于编写高效、稳定的代码至关重要。本文将详细介绍 Python 中字典复制的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技术点。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，用于存储键值对。当我们需要对字典进行复制操作时，有多种方式可供选择。正确理解和使用字典复制方法对于编写高效、稳定的代码至关重要。本文将详细介绍 Python 中字典复制的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一关键技术点。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 浅复制（Shallow Copy）
    - 深复制（Deep Copy）
3. 常见实践
    - 简单数据结构下的复制
    - 复杂嵌套结构下的复制
4. 最佳实践
    - 何时使用浅复制
    - 何时使用深复制
5. 小结
6. 参考资料

## 基础概念
在 Python 中，字典的复制并非简单地将一个字典对象赋给另一个变量。直接赋值操作（例如 `new_dict = old_dict`）只是创建了一个指向同一字典对象的新引用，而不是真正的复制。这意味着对 `new_dict` 所做的任何修改都会影响到 `old_dict`，反之亦然。

为了获得一个真正独立的字典副本，我们需要使用复制方法，其中主要包括浅复制和深复制。

### 浅复制（Shallow Copy）
浅复制会创建一个新的字典对象，新字典中的键值对与原始字典中的键值对相同，但对于嵌套的对象（如列表、字典等），浅复制只会复制引用，而不会递归地复制嵌套对象本身。

### 深复制（Deep Copy）
深复制不仅会创建一个新的字典对象，还会递归地复制字典中所有嵌套的对象，确保新字典与原始字典在内存中完全独立，对新字典的任何修改都不会影响到原始字典，反之亦然。

## 使用方法

### 浅复制（Shallow Copy）
在 Python 中，可以使用以下几种方式进行字典的浅复制：

#### 方法一：使用字典的 `copy()` 方法
```python
original_dict = {'a': 1, 'b': [2, 3], 'c': {'d': 4}}
shallow_copied_dict = original_dict.copy()

# 修改浅复制字典中的顶级键值对
shallow_copied_dict['a'] = 100

# 修改浅复制字典中嵌套列表的值
shallow_copied_dict['b'][0] = 200

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)
```
#### 方法二：使用 `dict()` 构造函数
```python
original_dict = {'a': 1, 'b': [2, 3], 'c': {'d': 4}}
shallow_copied_dict = dict(original_dict)

# 修改浅复制字典中的顶级键值对
shallow_copied_dict['a'] = 100

# 修改浅复制字典中嵌套列表的值
shallow_copied_dict['b'][0] = 200

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)
```
#### 方法三：使用 `copy` 模块中的 `copy()` 函数
```python
import copy

original_dict = {'a': 1, 'b': [2, 3], 'c': {'d': 4}}
shallow_copied_dict = copy.copy(original_dict)

# 修改浅复制字典中的顶级键值对
shallow_copied_dict['a'] = 100

# 修改浅复制字典中嵌套列表的值
shallow_copied_dict['b'][0] = 200

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)
```

### 深复制（Deep Copy）
使用 `copy` 模块中的 `deepcopy()` 函数进行深复制：
```python
import copy

original_dict = {'a': 1, 'b': [2, 3], 'c': {'d': 4}}
deep_copied_dict = copy.deepcopy(original_dict)

# 修改深复制字典中的顶级键值对
deep_copied_dict['a'] = 100

# 修改深复制字典中嵌套列表的值
deep_copied_dict['b'][0] = 200

print("Original Dict:", original_dict)
print("Deep Copied Dict:", deep_copied_dict)
```

## 常见实践

### 简单数据结构下的复制
当字典中只包含基本数据类型（如整数、字符串、浮点数等）时，浅复制和深复制的效果基本相同，因为基本数据类型是不可变的。在这种情况下，使用浅复制即可，因为它的性能更高。
```python
original_dict = {'a': 1, 'b': 'hello', 'c': 3.14}
shallow_copied_dict = original_dict.copy()
deep_copied_dict = copy.deepcopy(original_dict)

shallow_copied_dict['a'] = 100
deep_copied_dict['b'] = 'world'

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)
print("Deep Copied Dict:", deep_copied_dict)
```

### 复杂嵌套结构下的复制
当字典中包含嵌套的可变数据结构（如列表、字典）时，浅复制和深复制的区别就变得明显了。如果需要确保新字典与原始字典完全独立，避免意外的修改影响到原始数据，应使用深复制。
```python
original_dict = {'a': 1, 'b': [2, [3, 4]], 'c': {'d': 5}}
shallow_copied_dict = original_dict.copy()
deep_copied_dict = copy.deepcopy(original_dict)

shallow_copied_dict['b'][0] = 20
deep_copied_dict['b'][1][0] = 30

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)
print("Deep Copied Dict:", deep_copied_dict)
```

## 最佳实践

### 何时使用浅复制
- 当字典中的值都是不可变数据类型时，浅复制就足够了，因为不可变数据类型的值不会被意外修改。
- 当性能是关键因素，且对字典中嵌套对象的修改不会影响到原始数据时，浅复制是一个不错的选择。例如，在处理大量数据时，浅复制可以减少内存开销和复制时间。

### 何时使用深复制
- 当字典中包含嵌套的可变数据结构，并且需要确保新字典与原始字典在内存中完全独立时，必须使用深复制。这在多线程编程或复杂数据处理场景中尤为重要，以避免数据的意外共享和修改。
- 如果不确定字典中是否包含可变数据结构，或者对数据的独立性要求较高，使用深复制可以确保数据的安全性。

## 小结
本文详细介绍了 Python 中字典复制的相关知识，包括浅复制和深复制的概念、使用方法、常见实践以及最佳实践。理解浅复制和深复制的区别，并根据具体需求选择合适的复制方式，对于编写健壮、高效的 Python 代码至关重要。希望读者通过本文的学习，能够在实际编程中灵活运用字典复制技术，解决遇到的各种问题。

## 参考资料
- [Python 官方文档 - copy 模块](https://docs.python.org/3/library/copy.html){: rel="nofollow"}
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}