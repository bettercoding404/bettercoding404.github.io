---
title: "在 Python 中展示字典的键列表"
description: "在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。很多时候，我们需要获取字典中的所有键，这篇博客将详细介绍如何在 Python 中展示字典的键列表，以及相关的基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，字典（dictionary）是一种非常重要的数据结构，它以键值对（key-value pairs）的形式存储数据。很多时候，我们需要获取字典中的所有键，这篇博客将详细介绍如何在 Python 中展示字典的键列表，以及相关的基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `keys()` 方法
    - 转换为列表
3. 常见实践
    - 遍历字典键
    - 检查键是否存在
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
字典是 Python 中的一种无序可变容器，用于存储键值对。每个键都是唯一的，通过键可以快速访问对应的值。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
```
在这个字典中，`'name'`、`'age'` 和 `'city'` 是键，`'Alice'`、`30` 和 `'New York'` 分别是对应键的值。

## 使用方法
### 使用 `keys()` 方法
在 Python 中，字典对象有一个 `keys()` 方法，用于返回一个包含所有键的可迭代对象。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys = my_dict.keys()
print(keys)
```
输出结果：
```
dict_keys(['name', 'age', 'city'])
```
这里返回的 `dict_keys` 对象是一个可迭代对象，它不是一个真正的列表，但可以像迭代列表一样迭代它。例如：
```python
for key in my_dict.keys():
    print(key)
```
输出结果：
```
name
age
city
```

### 转换为列表
如果需要将键转换为真正的列表，可以使用 `list()` 函数。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys_list = list(my_dict.keys())
print(keys_list)
```
输出结果：
```
['name', 'age', 'city']
```
这样就得到了一个包含字典所有键的列表。

## 常见实践
### 遍历字典键
遍历字典的键是一个常见的操作，除了上面使用 `for` 循环遍历 `keys()` 方法返回的可迭代对象外，还可以直接遍历字典，因为字典本身也是可迭代的，默认迭代的就是键。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
for key in my_dict:
    print(key)
```
输出结果与前面相同：
```
name
age
city
```

### 检查键是否存在
在处理字典时，经常需要检查某个键是否存在于字典中。可以使用 `in` 关键字来实现：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
if 'name' in my_dict:
    print("键 'name' 存在于字典中")
else:
    print("键 'name' 不存在于字典中")
```
输出结果：
```
键 'name' 存在于字典中
```

## 最佳实践
### 性能优化
如果只是需要遍历字典的键，直接遍历字典比使用 `keys()` 方法稍微快一点，因为 `keys()` 方法会创建一个额外的可迭代对象。例如：
```python
import timeit

my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}

def loop_with_keys():
    for key in my_dict.keys():
        pass

def loop_directly():
    for key in my_dict:
        pass

print(timeit.timeit(loop_with_keys, number = 1000000))
print(timeit.timeit(loop_directly, number = 1000000))
```
运行这段代码会发现，`loop_directly` 函数的执行时间更短。

### 代码可读性
虽然直接遍历字典性能稍好，但在某些情况下，使用 `keys()` 方法可以使代码更具可读性，特别是当代码的意图是明确地操作键的时候。例如：
```python
my_dict = {'name': 'Alice', 'age': 30, 'city': 'New York'}
keys = my_dict.keys()
# 对键进行一些复杂操作，这里只是示例
new_keys = [key.upper() for key in keys]
print(new_keys)
```
在这个例子中，使用 `keys()` 方法可以使代码更清晰地表达我们是在处理字典的键。

## 小结
在 Python 中展示字典的键列表有多种方法，通过 `keys()` 方法可以获取包含所有键的可迭代对象，使用 `list()` 函数可以将其转换为真正的列表。在实际应用中，需要根据具体需求选择合适的方法，同时要考虑性能和代码可读性等因素。希望这篇博客能帮助你更好地理解和使用这一功能。

## 参考资料
- [Python 官方文档 - 字典](https://docs.python.org/3/tutorial/datastructures.html#dictionaries){: rel="nofollow"}
- [Python 教程 - 字典操作](https://www.runoob.com/python3/python3-dictionary.html){: rel="nofollow"}