---
title: "Python 列表排序：基础、应用与最佳实践"
description: "在 Python 编程中，列表（list）是一种非常常用的数据结构。对列表进行排序是一项常见的操作，无论是处理数据集合、组织信息还是进行算法设计，都可能会用到。本文将深入探讨在 Python 中对列表进行排序的相关知识，包括基础概念、不同的使用方法、常见实践场景以及最佳实践技巧，帮助读者全面掌握这一重要技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，列表（list）是一种非常常用的数据结构。对列表进行排序是一项常见的操作，无论是处理数据集合、组织信息还是进行算法设计，都可能会用到。本文将深入探讨在 Python 中对列表进行排序的相关知识，包括基础概念、不同的使用方法、常见实践场景以及最佳实践技巧，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 列表内置的 `sort()` 方法
    - 内置函数 `sorted()`
3. **常见实践**
    - 对数字列表排序
    - 对字符串列表排序
    - 对自定义对象列表排序
4. **最佳实践**
    - 性能优化
    - 代码可读性优化
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，列表是一个有序的可变序列，可以包含不同类型的元素。排序操作就是将列表中的元素按照特定的顺序进行排列，常见的顺序有升序（从小到大）和降序（从大到小）。Python 提供了多种方式来实现列表排序，每种方式都有其特点和适用场景。

## 使用方法

### 列表内置的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接在原列表上进行排序，不会返回一个新的列表。

**语法**：
```python
list.sort(key=None, reverse=False)
```
- `key`：一个可选参数，用于指定一个函数，该函数将应用于列表中的每个元素，以确定排序的依据。默认为 `None`，表示直接比较元素本身。
- `reverse`：一个布尔值，默认为 `False`，表示升序排序；如果设置为 `True`，则表示降序排序。

**示例**：
```python
# 对数字列表进行升序排序
nums = [5, 2, 8, 1, 9]
nums.sort()
print(nums)  # 输出: [1, 2, 5, 8, 9]

# 对数字列表进行降序排序
nums.sort(reverse=True)
print(nums)  # 输出: [9, 8, 5, 2, 1]

# 对字符串列表按照字符串长度进行排序
strings = ["apple", "banana", "cherry", "date"]
strings.sort(key=len)
print(strings)  # 输出: ["date", "apple", "cherry", "banana"]
```

### 内置函数 `sorted()`
`sorted()` 是 Python 的一个内置函数，它会返回一个新的已排序列表，而原列表保持不变。

**语法**：
```python
sorted(iterable, key=None, reverse=False)
```
参数与 `sort()` 方法类似。

**示例**：
```python
# 对数字列表进行升序排序
nums = [5, 2, 8, 1, 9]
new_nums = sorted(nums)
print(nums)  # 输出: [5, 2, 8, 1, 9]（原列表不变）
print(new_nums)  # 输出: [1, 2, 5, 8, 9]

# 对数字列表进行降序排序
new_nums = sorted(nums, reverse=True)
print(new_nums)  # 输出: [9, 8, 5, 2, 1]

# 对字典列表按照字典中的某个键进行排序
students = [
    {"name": "Alice", "age": 20},
    {"name": "Bob", "age": 18},
    {"name": "Charlie", "age": 22}
]
sorted_students = sorted(students, key=lambda student: student["age"])
print(sorted_students) 
# 输出: [{"name": "Bob", "age": 18}, {"name": "Alice", "age": 20}, {"name": "Charlie", "age": 22}]
```

## 常见实践

### 对数字列表排序
这是最常见的排序场景之一。无论是整数列表还是浮点数列表，都可以直接使用 `sort()` 方法或 `sorted()` 函数进行排序。

```python
int_list = [34, 12, 78, 56, 90]
float_list = [3.14, 1.618, 2.718, 0.577]

# 使用 sort() 方法
int_list.sort()
float_list.sort()
print(int_list)  # 输出: [12, 34, 56, 78, 90]
print(float_list)  # 输出: [0.577, 1.618, 2.718, 3.14]

# 使用 sorted() 函数
new_int_list = sorted(int_list)
new_float_list = sorted(float_list)
print(new_int_list)  # 输出: [12, 34, 56, 78, 90]
print(new_float_list)  # 输出: [0.577, 1.618, 2.718, 3.14]
```

### 对字符串列表排序
字符串列表的排序默认按照字典序进行。如果需要按照其他规则排序，可以通过 `key` 参数指定排序依据。

```python
words = ["banana", "apple", "cherry", "date"]

# 默认字典序排序
words.sort()
print(words)  # 输出: ['apple', 'banana', 'cherry', 'date']

# 按照字符串长度排序
words.sort(key=len)
print(words)  # 输出: ['date', 'apple', 'cherry', 'banana']
```

### 对自定义对象列表排序
当列表中包含自定义对象时，需要通过 `key` 参数指定一个函数，该函数从每个对象中提取一个用于比较的键。

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

people = [Person("Alice", 20), Person("Bob", 18), Person("Charlie", 22)]

# 按照年龄排序
people.sort(key=lambda person: person.age)
print(people) 
# 输出: [Person(Bob, 18), Person(Alice, 20), Person(Charlie, 22)]
```

## 最佳实践

### 性能优化
- 如果需要对列表进行多次排序，且原列表不需要保留，使用 `sort()` 方法会更高效，因为它直接在原列表上操作，避免了创建新列表的开销。
- 对于大型列表，使用内置的排序函数和方法通常比自己实现排序算法更高效，因为它们经过了优化。

### 代码可读性优化
- 使用 `key` 参数时，尽量使用简单的 lambda 函数或定义一个具有描述性名称的函数，以提高代码的可读性。
- 在对复杂数据结构进行排序时，将排序逻辑封装在一个函数中，使主代码更加简洁明了。

```python
def get_age(person):
    return person.age

people = [Person("Alice", 20), Person("Bob", 18), Person("Charlie", 22)]
people.sort(key=get_age)
print(people) 
# 输出: [Person(Bob, 18), Person(Alice, 20), Person(Charlie, 22)]
```

## 小结
在 Python 中对列表进行排序有多种方式，`sort()` 方法直接在原列表上排序，`sorted()` 函数返回一个新的已排序列表。了解不同的使用方法和适用场景，以及在常见实践中的应用和最佳实践技巧，能够帮助开发者更高效地处理列表排序问题，提高代码的质量和性能。

## 参考资料
- [Python 官方文档 - 列表排序](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists)
- [Python 官方文档 - sorted() 函数](https://docs.python.org/3/library/functions.html#sorted)