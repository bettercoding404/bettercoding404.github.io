---
title: "Python 中字典（Dictionary）的复制"
description: "在 Python 编程中，字典（Dictionary）是一种非常重要的数据结构，用于存储键值对。在实际开发中，我们常常需要复制字典，以避免对原始字典的意外修改，或者在不同的逻辑部分使用相同的数据结构。理解字典复制的概念、使用方法以及最佳实践，对于编写高效、可靠的 Python 代码至关重要。本文将深入探讨 Python 中字典复制的相关知识，帮助你更好地掌握这一重要技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，字典（Dictionary）是一种非常重要的数据结构，用于存储键值对。在实际开发中，我们常常需要复制字典，以避免对原始字典的意外修改，或者在不同的逻辑部分使用相同的数据结构。理解字典复制的概念、使用方法以及最佳实践，对于编写高效、可靠的 Python 代码至关重要。本文将深入探讨 Python 中字典复制的相关知识，帮助你更好地掌握这一重要技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 浅拷贝（Shallow Copy）
    - 深拷贝（Deep Copy）
3. 常见实践
    - 在函数参数传递中的应用
    - 在数据处理中的应用
4. 最佳实践
    - 何时使用浅拷贝
    - 何时使用深拷贝
5. 小结
6. 参考资料

## 基础概念
在 Python 中，字典的复制有两种主要方式：浅拷贝（Shallow Copy）和深拷贝（Deep Copy）。

**浅拷贝**：浅拷贝会创建一个新的字典对象，新字典的键值对与原始字典相同，但新字典中的值（如果是可变对象，如列表、字典等）仍然是对原始对象的引用。这意味着，如果修改新字典中可变对象的值，原始字典中对应的值也会被修改。

**深拷贝**：深拷贝会递归地复制字典中的所有值，包括可变对象。新字典中的所有对象都是完全独立的，对新字典中任何对象的修改都不会影响到原始字典。

## 使用方法
### 浅拷贝（Shallow Copy）
在 Python 中，可以使用以下几种方法进行字典的浅拷贝：

1. **使用 `dict.copy()` 方法**：这是最常用的方法，用于创建一个字典的浅拷贝。

```python
original_dict = {'a': [1, 2, 3], 'b': 4}
shallow_copied_dict = original_dict.copy()

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)

# 修改浅拷贝字典中的可变对象
shallow_copied_dict['a'].append(4)

print("Original Dict after modification:", original_dict)
print("Shallow Copied Dict after modification:", shallow_copied_dict)
```

2. **使用字典构造函数 `dict()`**：可以通过将原始字典作为参数传递给 `dict()` 函数来创建浅拷贝。

```python
original_dict = {'a': [1, 2, 3], 'b': 4}
shallow_copied_dict = dict(original_dict)

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)

# 修改浅拷贝字典中的可变对象
shallow_copied_dict['a'].append(4)

print("Original Dict after modification:", original_dict)
print("Shallow Copied Dict after modification:", shallow_copied_dict)
```

3. **使用 `copy` 模块的 `copy()` 函数**：`copy` 模块提供了更通用的复制函数，`copy()` 函数也可以用于字典的浅拷贝。

```python
import copy

original_dict = {'a': [1, 2, 3], 'b': 4}
shallow_copied_dict = copy.copy(original_dict)

print("Original Dict:", original_dict)
print("Shallow Copied Dict:", shallow_copied_dict)

# 修改浅拷贝字典中的可变对象
shallow_copied_dict['a'].append(4)

print("Original Dict after modification:", original_dict)
print("Shallow Copied Dict after modification:", shallow_copied_dict)
```

### 深拷贝（Deep Copy）
要进行字典的深拷贝，需要使用 `copy` 模块的 `deepcopy()` 函数。

```python
import copy

original_dict = {'a': [1, 2, 3], 'b': {'c': 5}}
deep_copied_dict = copy.deepcopy(original_dict)

print("Original Dict:", original_dict)
print("Deep Copied Dict:", deep_copied_dict)

# 修改深拷贝字典中的可变对象
deep_copied_dict['a'].append(4)
deep_copied_dict['b']['c'] = 6

print("Original Dict after modification:", original_dict)
print("Deep Copied Dict after modification:", deep_copied_dict)
```

## 常见实践
### 在函数参数传递中的应用
当将字典作为参数传递给函数时，为了避免函数内部对原始字典的意外修改，可以传递字典的拷贝。

```python
def process_dict(d):
    d['new_key'] = 'new_value'
    return d

original_dict = {'a': 1, 'b': 2}
# 传递浅拷贝
result_with_shallow_copy = process_dict(original_dict.copy())
print("Original Dict after shallow copy pass:", original_dict)
print("Result with shallow copy:", result_with_shallow_copy)

# 传递深拷贝
result_with_deep_copy = process_dict(copy.deepcopy(original_dict))
print("Original Dict after deep copy pass:", original_dict)
print("Result with deep copy:", result_with_deep_copy)
```

### 在数据处理中的应用
在数据处理过程中，可能需要对字典进行复制，以保留原始数据的完整性。

```python
data = {'students': [{'name': 'Alice', 'grades': [85, 90]}, {'name': 'Bob', 'grades': [78, 82]}]}

# 对数据进行浅拷贝并处理
shallow_copied_data = data.copy()
shallow_copied_data['students'][0]['grades'].append(95)

print("Original Data:", data)
print("Shallow Copied Data:", shallow_copied_data)

# 对数据进行深拷贝并处理
deep_copied_data = copy.deepcopy(data)
deep_copied_data['students'][0]['grades'].append(95)

print("Original Data after deep copy:", data)
print("Deep Copied Data:", deep_copied_data)
```

## 最佳实践
### 何时使用浅拷贝
- 当字典中的值都是不可变对象（如整数、字符串、元组等）时，浅拷贝和深拷贝的效果是一样的，此时使用浅拷贝即可，因为浅拷贝的性能更好。
- 如果希望新字典和原始字典共享一些可变对象，并且对这些共享对象的修改是预期的，那么使用浅拷贝。

### 何时使用深拷贝
- 当字典中的值包含可变对象，并且需要确保新字典和原始字典完全独立，互不影响时，应该使用深拷贝。例如，在处理复杂的数据结构，如嵌套字典和列表时，深拷贝可以避免意外的数据修改。

## 小结
本文详细介绍了 Python 中字典复制的基础概念、使用方法、常见实践以及最佳实践。理解浅拷贝和深拷贝的区别，并根据实际需求选择合适的复制方式，对于编写健壮、可靠的 Python 代码至关重要。希望通过本文的学习，你能够更加熟练地运用字典复制技术，提升编程效率。

## 参考资料
- [Python 官方文档 - copy 模块](https://docs.python.org/3/library/copy.html){: rel="nofollow"}
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}