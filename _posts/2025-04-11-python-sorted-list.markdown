---
title: "深入理解Python中的`sorted()`与有序列表"
description: "在Python编程中，处理有序数据是一项常见任务。`sorted()`函数作为Python的内置函数，为我们提供了强大而灵活的列表排序功能。掌握`sorted()`函数以及有序列表的相关知识，对于提高代码效率和数据处理能力至关重要。本文将深入探讨Python中`sorted list`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一特性解决实际问题。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，处理有序数据是一项常见任务。`sorted()`函数作为Python的内置函数，为我们提供了强大而灵活的列表排序功能。掌握`sorted()`函数以及有序列表的相关知识，对于提高代码效率和数据处理能力至关重要。本文将深入探讨Python中`sorted list`的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一特性解决实际问题。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 对简单列表排序
    - 按特定规则排序
    - 反向排序
3. **常见实践**
    - 对字典列表排序
    - 对复杂对象列表排序
4. **最佳实践**
    - 性能优化
    - 代码可读性优化
5. **小结**
6. **参考资料**

## 基础概念
在Python中，`sorted()`是一个内置函数，用于对可迭代对象（如列表、元组、集合等）进行排序，并返回一个新的已排序列表。原始的可迭代对象不会被修改。列表本身也有一个`sort()`方法，它会直接在原列表上进行排序，返回值为`None`。

## 使用方法

### 对简单列表排序
以下是对整数列表和字符串列表进行排序的示例：

```python
# 整数列表排序
int_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_int_list = sorted(int_list)
print(sorted_int_list)

# 字符串列表排序
str_list = ["banana", "apple", "cherry", "date"]
sorted_str_list = sorted(str_list)
print(sorted_str_list)
```

### 按特定规则排序
`sorted()`函数接受一个`key`参数，该参数是一个函数，用于指定排序的规则。例如，我们可以按字符串的长度对字符串列表进行排序：

```python
str_list = ["banana", "apple", "cherry", "date"]
sorted_by_length = sorted(str_list, key=len)
print(sorted_by_length)
```

### 反向排序
可以通过设置`reverse=True`参数来实现反向排序：

```python
int_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_reverse_int_list = sorted(int_list, reverse=True)
print(sorted_reverse_int_list)
```

## 常见实践

### 对字典列表排序
假设我们有一个包含字典的列表，每个字典代表一个人，包含`name`和`age`字段，我们可以按年龄对这些人进行排序：

```python
people = [
    {"name": "Alice", "age": 25},
    {"name": "Bob", "age": 20},
    {"name": "Charlie", "age": 30}
]

sorted_people = sorted(people, key=lambda person: person["age"])
print(sorted_people)
```

### 对复杂对象列表排序
如果有一个自定义类的对象列表，我们可以通过定义类的`__lt__`方法（小于比较方法）来实现排序，或者在`sorted()`中使用`key`参数指定排序规则。

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __lt__(self, other):
        return self.age < other.age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

persons = [
    Person("Alice", 25),
    Person("Bob", 20),
    Person("Charlie", 30)
]

sorted_persons = sorted(persons)
print(sorted_persons)
```

## 最佳实践

### 性能优化
- **就地排序**：如果不需要保留原始列表，使用列表的`sort()`方法会比`sorted()`更高效，因为`sort()`是就地排序，不会创建新的列表对象。
- **使用合适的数据结构**：在某些情况下，使用`heapq`模块中的数据结构（如堆）进行排序可能更高效，特别是对于大规模数据。

### 代码可读性优化
- **使用具名函数代替匿名函数**：当`key`函数比较复杂时，使用具名函数可以提高代码的可读性。
```python
def get_age(person):
    return person["age"]

people = [
    {"name": "Alice", "age": 25},
    {"name": "Bob", "age": 20},
    {"name": "Charlie", "age": 30}
]

sorted_people = sorted(people, key=get_age)
print(sorted_people)
```

## 小结
通过本文，我们详细了解了Python中`sorted()`函数的基础概念、使用方法、常见实践以及最佳实践。掌握这些知识，能够帮助我们更加灵活和高效地处理有序数据，提高代码的质量和性能。无论是简单的列表排序，还是复杂对象列表的排序，`sorted()`函数都为我们提供了强大的工具。

## 参考资料
- [Python官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}
- 《Python Cookbook》
- [Real Python - Sorting in Python](https://realpython.com/python-sort/){: rel="nofollow"}