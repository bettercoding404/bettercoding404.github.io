---
title: "在 Python 中遍历字典：基础、方法与最佳实践"
description: "在 Python 编程中，字典（dictionary）是一种非常强大且常用的数据结构，它用于存储键值对（key-value pairs）。遍历字典（iterating through dictionary）是一项基本操作，通过它我们可以访问字典中的每一个键值对、键或者值，以进行各种数据处理和分析。本文将深入探讨在 Python 中遍历字典的基础概念、不同的使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常强大且常用的数据结构，它用于存储键值对（key-value pairs）。遍历字典（iterating through dictionary）是一项基本操作，通过它我们可以访问字典中的每一个键值对、键或者值，以进行各种数据处理和分析。本文将深入探讨在 Python 中遍历字典的基础概念、不同的使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **遍历字典的方法**
    - 遍历键
    - 遍历值
    - 遍历键值对
3. **常见实践**
    - 打印字典内容
    - 数据处理
4. **最佳实践**
    - 选择合适的遍历方式
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
字典是 Python 中的一种无序数据结构，它使用键来索引值。每个键值对之间用逗号分隔，整个字典用花括号 `{}` 括起来。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```
在这个字典中，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 是对应的值。遍历字典就是按照一定的顺序逐个访问字典中的键、值或者键值对。

## 遍历字典的方法

### 遍历键
可以使用 `for` 循环直接遍历字典，默认情况下，遍历的是字典的键。
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict:
    print(key)
```
输出：
```
name
age
city
```
也可以使用字典的 `keys()` 方法来明确地遍历键，效果是一样的：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict.keys():
    print(key)
```

### 遍历值
使用字典的 `values()` 方法可以遍历字典中的值。
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for value in my_dict.values():
    print(value)
```
输出：
```
Alice
30
New York
```

### 遍历键值对
使用字典的 `items()` 方法可以同时遍历键和值，返回的是一个元组，第一个元素是键，第二个元素是值。
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key, value in my_dict.items():
    print(f"{key}: {value}")
```
输出：
```
name: Alice
age: 30
city: New York
```

## 常见实践

### 打印字典内容
遍历字典最常见的用途之一就是打印字典的内容。上面的代码示例已经展示了如何通过遍历键、值或者键值对来打印字典的不同信息。

### 数据处理
可以根据键或值进行数据处理。例如，将字典中所有的值乘以 2：
```python
my_dict = {'a': 1, 'b': 2, 'c': 3}
new_dict = {}
for key, value in my_dict.items():
    new_dict[key] = value * 2
print(new_dict)
```
输出：
```
{'a': 2, 'b': 4, 'c': 6}
```

## 最佳实践

### 选择合适的遍历方式
根据具体需求选择最合适的遍历方式。如果只需要键，直接使用 `for key in my_dict` 或者 `for key in my_dict.keys()` 即可；如果只关心值，使用 `for value in my_dict.values()`；如果需要同时处理键和值，则使用 `for key, value in my_dict.items()`。

### 性能优化
在处理大型字典时，性能是需要考虑的因素。虽然 `keys()`、`values()` 和 `items()` 方法在 Python 中已经进行了优化，但如果需要多次遍历字典，尽量避免重复调用这些方法，可以将结果保存到变量中。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys = list(my_dict.keys())
for key in keys:
    print(key)
```
另外，在 Python 3 中，`keys()`、`values()` 和 `items()` 方法返回的是视图对象（view objects），它们是动态的，反映字典的实时变化。如果需要一个静态的列表，可以使用 `list()` 函数将其转换为列表。

## 小结
遍历字典是 Python 编程中一项基础且重要的操作。通过不同的方法，我们可以灵活地访问字典中的键、值或者键值对，以满足各种数据处理的需求。在实际应用中，选择合适的遍历方式和注意性能优化能够提高代码的效率和可读性。希望本文的内容能够帮助你更好地掌握在 Python 中遍历字典的技巧。

## 参考资料
- [Python 官方文档 - Dictionaries](https://docs.python.org/3/tutorial/datastructures.html#dictionaries)
- [Python Documentation - Iteration](https://docs.python.org/3/reference/datamodel.html#objects-values-and-types)