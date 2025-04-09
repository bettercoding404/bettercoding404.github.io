---
title: "Python 字典循环：基础、用法与最佳实践"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它用于存储键值对（key-value pairs）。能够有效地循环遍历字典是处理字典数据的关键技能之一。通过循环遍历字典，我们可以访问、操作和处理字典中的每一个键值对，这在数据处理、算法实现等众多场景中都极为有用。本文将深入探讨 Python 中循环遍历字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的编程技巧。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它用于存储键值对（key-value pairs）。能够有效地循环遍历字典是处理字典数据的关键技能之一。通过循环遍历字典，我们可以访问、操作和处理字典中的每一个键值对，这在数据处理、算法实现等众多场景中都极为有用。本文将深入探讨 Python 中循环遍历字典的基础概念、各种使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的编程技巧。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 遍历键
    - 遍历值
    - 遍历键值对
3. **常见实践**
    - 查找特定键值对
    - 修改字典值
    - 基于字典数据创建新数据结构
4. **最佳实践**
    - 性能优化
    - 代码可读性提升
5. **小结**
6. **参考资料**

## 基础概念
字典是 Python 中的一种无序可变数据结构，由键值对组成。每个键都是唯一的，通过键可以快速访问对应的值。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```
在这个字典中，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 是对应的值。

循环遍历字典就是按顺序逐个访问字典中的键、值或键值对，以便对其进行各种操作。

## 使用方法

### 遍历键
可以使用 `for` 循环直接遍历字典，默认情况下遍历的是字典的键。
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
也可以显式地使用 `keys()` 方法遍历键：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict.keys():
    print(key)
```
### 遍历值
使用 `values()` 方法可以遍历字典中的值。
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
使用 `items()` 方法可以同时遍历字典的键和值。
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

### 查找特定键值对
在处理字典数据时，经常需要查找特定的键值对。例如，查找字典中年龄为 30 的记录：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York', 'age2': 25}
for key, value in my_dict.items():
    if value == 30:
        print(f"找到键值对: {key}: {value}")
```
输出：
```
找到键值对: age: 30
```

### 修改字典值
可以在循环遍历字典时修改字典的值。例如，将字典中所有的值都加倍：
```python
my_dict = {'a': 1, 'b': 2, 'c': 3}
for key in my_dict:
    my_dict[key] = my_dict[key] * 2
print(my_dict)
```
输出：
```
{'a': 2, 'b': 4, 'c': 6}
```

### 基于字典数据创建新数据结构
可以根据字典中的数据创建新的数据结构。例如，将字典中的键和值分别存储到两个列表中：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys_list = []
values_list = []
for key, value in my_dict.items():
    keys_list.append(key)
    values_list.append(value)
print(keys_list)
print(values_list)
```
输出：
```
['name', 'age', 'city']
['Alice', 30, 'New York']
```

## 最佳实践

### 性能优化
在处理大型字典时，性能是需要考虑的因素。尽量避免在循环中进行不必要的操作。例如，不要在循环中反复调用字典的方法，而是提前获取所需的键、值或键值对列表。
```python
# 不推荐，每次循环都调用 keys() 方法
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict.keys():
    print(key)

# 推荐，提前获取键列表
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys = list(my_dict.keys())
for key in keys:
    print(key)
```

### 代码可读性提升
为了提高代码的可读性，使用有意义的变量名。在遍历键值对时，使用描述性的变量名来表示键和值。
```python
# 可读性较差
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for k, v in my_dict.items():
    print(f"{k}: {v}")

# 可读性较好
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key, value in my_dict.items():
    print(f"{key}: {value}")
```

## 小结
循环遍历字典是 Python 编程中处理字典数据的核心操作。通过掌握遍历键、值和键值对的方法，以及在不同场景下的常见实践和最佳实践，我们能够更加高效地处理字典数据，编写出更优质、更健壮的 Python 代码。希望本文的内容能够帮助读者深入理解并灵活运用 Python 中循环遍历字典的技巧。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》