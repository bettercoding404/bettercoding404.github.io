---
title: "深入理解 Python 中的 dictionary.get 方法"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它允许我们以键值对的形式存储和访问数据。`dictionary.get` 方法是字典对象的一个内置方法，用于从字典中获取指定键的值。这个方法在处理字典数据时非常实用，尤其是在需要处理可能不存在的键时，能帮助我们避免常见的错误。本文将详细介绍 `dictionary.get` 方法的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这个方法来处理字典数据。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它允许我们以键值对的形式存储和访问数据。`dictionary.get` 方法是字典对象的一个内置方法，用于从字典中获取指定键的值。这个方法在处理字典数据时非常实用，尤其是在需要处理可能不存在的键时，能帮助我们避免常见的错误。本文将详细介绍 `dictionary.get` 方法的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地运用这个方法来处理字典数据。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
字典是 Python 中的一种无序的数据集合，它使用键值对（key-value pairs）来存储数据。每个键都是唯一的，通过键可以快速地访问对应的值。例如：

```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```

在这个字典中，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 分别是对应的值。

`dictionary.get` 方法用于从字典中获取指定键的值。它的语法如下：

```python
dictionary.get(key, default=None)
```

- `key`：要获取值的键。
- `default`（可选）：如果键不存在时返回的默认值。如果不提供这个参数，默认返回 `None`。

## 使用方法
### 获取存在的键的值
当键存在于字典中时，`dictionary.get` 方法会返回对应的值。例如：

```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
name = my_dict.get('name')
print(name)  
```

在这个例子中，`my_dict.get('name')` 返回了键 `'name'` 对应的值 `'Alice'`。

### 获取不存在的键的值
当键不存在于字典中时，`dictionary.get` 方法会返回默认值。如果没有提供默认值，就返回 `None`。例如：

```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
country = my_dict.get('country')
print(country)  
```

在这个例子中，字典 `my_dict` 中没有 `'country'` 这个键，所以 `my_dict.get('country')` 返回 `None`。

如果我们希望在键不存在时返回一个自定义的默认值，可以提供 `default` 参数。例如：

```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
country = my_dict.get('country', 'Unknown')
print(country)  
```

在这个例子中，`my_dict.get('country', 'Unknown')` 在键 `'country'` 不存在时返回了我们自定义的默认值 `'Unknown'`。

## 常见实践
### 安全地访问字典中的值
在处理字典数据时，我们经常需要访问一些可能不存在的键的值。使用 `dictionary.get` 方法可以避免因为键不存在而导致的 `KeyError` 异常。例如：

```python
data = {'user': {'info': {'email': 'alice@example.com'}}}

# 使用传统方式访问可能会导致 KeyError
# email = data['user']['info']['email']

# 使用 dictionary.get 方法安全地访问
email = data.get('user', {}).get('info', {}).get('email')
print(email)  
```

在这个例子中，如果 `data` 字典中没有 `'user'` 键，或者 `'user'` 字典中没有 `'info'` 键，使用传统的方式访问 `email` 会导致 `KeyError` 异常。而使用 `dictionary.get` 方法，即使某些键不存在，也不会引发异常，而是返回 `None`。

### 统计字典中某个值的出现次数
我们可以使用 `dictionary.get` 方法来统计某个值在字典中出现的次数。例如，统计一个列表中每个元素出现的次数：

```python
my_list = [1, 2, 2, 3, 3, 3]
count_dict = {}

for num in my_list:
    count_dict[num] = count_dict.get(num, 0) + 1

print(count_dict)  
```

在这个例子中，`count_dict.get(num, 0)` 首先获取 `num` 键对应的值，如果键不存在则返回默认值 `0`，然后将这个值加 `1`，并重新赋值给 `count_dict[num]`，从而实现了对每个元素出现次数的统计。

## 最佳实践
### 避免过度使用默认值
虽然 `dictionary.get` 方法提供了默认值的功能，但过度使用默认值可能会使代码逻辑变得复杂。尽量在字典初始化时确保必要的键存在，或者在使用 `dictionary.get` 方法时，只在确实需要处理可能不存在的键时才使用默认值。

### 结合条件判断
在使用 `dictionary.get` 方法时，可以结合条件判断来处理不同的情况。例如：

```python
my_dict = {'name': 'Alice', 'age': 30}

value = my_dict.get('age')
if value is not None:
    print(f"Age is {value}")
else:
    print("Age not found")
```

这样可以根据获取到的值进行不同的操作，使代码更加健壮。

### 链式调用时的可读性
在进行链式调用 `dictionary.get` 方法时，要注意代码的可读性。可以适当添加注释或者将复杂的链式调用拆分成多个步骤，以提高代码的可维护性。例如：

```python
# 原始链式调用
email = data.get('user', {}).get('info', {}).get('email')

# 拆分步骤，提高可读性
user_info = data.get('user', {})
info_dict = user_info.get('info', {})
email = info_dict.get('email')
```

## 小结
`dictionary.get` 方法是 Python 中处理字典数据的一个非常有用的工具。它允许我们安全地获取字典中指定键的值，并且可以在键不存在时返回默认值，避免了常见的 `KeyError` 异常。通过了解其基础概念、使用方法、常见实践以及最佳实践，我们能够更加高效地运用这个方法来处理各种与字典相关的编程任务，提高代码的质量和健壮性。

## 参考资料
- [Python 官方文档 - 字典对象](https://docs.python.org/3/library/stdtypes.html#dict)
- 《Python 核心编程》
- [Real Python - Working with Dictionaries in Python](https://realpython.com/python-dicts/)