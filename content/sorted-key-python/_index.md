---
title: "深入理解 Python 中的 sorted() 函数之 key 参数"
description: "在 Python 编程中，`sorted()` 函数是一个非常实用的内置函数，用于对可迭代对象（如列表、元组、集合等）进行排序。而 `key` 参数则为这个排序过程提供了强大的自定义功能。通过合理使用 `key` 参数，我们可以根据各种不同的规则对数据进行排序，极大地提高了代码的灵活性和实用性。本文将详细介绍 `sorted()` 函数中 `key` 参数的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，`sorted()` 函数是一个非常实用的内置函数，用于对可迭代对象（如列表、元组、集合等）进行排序。而 `key` 参数则为这个排序过程提供了强大的自定义功能。通过合理使用 `key` 参数，我们可以根据各种不同的规则对数据进行排序，极大地提高了代码的灵活性和实用性。本文将详细介绍 `sorted()` 函数中 `key` 参数的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **对列表中的整数进行排序**
    - **根据字符串长度对列表进行排序**
    - **对字典列表按特定键排序**
3. **常见实践**
    - **按绝对值排序**
    - **忽略大小写排序字符串列表**
    - **对自定义对象列表排序**
4. **最佳实践**
    - **提高性能的技巧**
    - **保持代码简洁和可读性**
5. **小结**
6. **参考资料**

## 基础概念
`sorted()` 函数的基本语法如下：
```python
sorted(iterable, key=None, reverse=False)
```
其中，`iterable` 是要排序的可迭代对象；`key` 是一个可选参数，它接受一个函数作为参数。这个函数会应用到 `iterable` 的每个元素上，然后根据函数返回的结果进行排序；`reverse` 也是一个可选参数，默认为 `False`，如果设置为 `True`，则会按降序排序。

`key` 参数的作用是定义一个自定义的排序规则。它允许我们根据元素的某个特定属性或计算结果来进行排序，而不仅仅是基于元素本身的值。

## 使用方法

### 对列表中的整数进行排序
这是最基本的排序情况，不使用 `key` 参数时，`sorted()` 函数会直接根据元素的值进行排序。
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
sorted_list = sorted(my_list)
print(sorted_list)  
```
输出结果：
```
[1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
```

### 根据字符串长度对列表进行排序
通过设置 `key` 参数为 `len` 函数，我们可以根据字符串的长度对列表进行排序。
```python
string_list = ["apple", "banana", "cherry", "date"]
sorted_by_length = sorted(string_list, key=len)
print(sorted_by_length)  
```
输出结果：
```
["date", "apple", "cherry", "banana"]
```

### 对字典列表按特定键排序
假设有一个字典列表，我们想根据字典中的某个键对列表进行排序。
```python
students = [
    {"name": "Alice", "age": 20},
    {"name": "Bob", "age": 18},
    {"name": "Charlie", "age": 22}
]
sorted_students = sorted(students, key=lambda student: student["age"])
print(sorted_students)  
```
输出结果：
```
[{'name': 'Bob', 'age': 18}, {'name': 'Alice', 'age': 20}, {'name': 'Charlie', 'age': 22}]
```
在这个例子中，`key` 参数使用了一个 lambda 函数，它接受一个字典元素（即 `student`），并返回 `student["age"]`，也就是字典中 `"age"` 键对应的值。这样，`sorted()` 函数就会根据学生的年龄对列表进行排序。

## 常见实践

### 按绝对值排序
有时候我们需要根据元素的绝对值进行排序。
```python
number_list = [-3, 1, -4, 1, -5, 9, -2, 6, -5, 3, -5]
sorted_by_abs = sorted(number_list, key=abs)
print(sorted_by_abs)  
```
输出结果：
```
[1, 1, -2, 3, -3, -4, 5, -5, -5, 6, 9]
```
这里 `key` 参数设置为 `abs` 函数，它会计算每个元素的绝对值，然后根据绝对值进行排序。

### 忽略大小写排序字符串列表
在排序字符串列表时，如果我们希望忽略大小写，可以使用 `str.lower` 函数作为 `key` 参数。
```python
mixed_case_list = ["banana", "Apple", "cherry", "DATE"]
sorted_ignore_case = sorted(mixed_case_list, key=str.lower)
print(sorted_ignore_case)  
```
输出结果：
```
["Apple", "banana", "cherry", "DATE"]
```

### 对自定义对象列表排序
假设有一个自定义类，我们想对该类的对象列表进行排序。
```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return f"Point({self.x}, {self.y})"

points = [Point(3, 4), Point(1, 2), Point(5, 6)]
sorted_points = sorted(points, key=lambda point: point.x)
print(sorted_points)  
```
输出结果：
```
[Point(1, 2), Point(3, 4), Point(5, 6)]
```
在这个例子中，我们定义了一个 `Point` 类，然后通过设置 `key` 参数为一个 lambda 函数，根据 `Point` 对象的 `x` 属性对列表进行排序。

## 最佳实践

### 提高性能的技巧
- **尽量使用内置函数作为 `key`**：内置函数通常比自定义的 lambda 函数或普通函数执行速度更快。例如，使用 `len`、`abs` 等内置函数作为 `key` 参数可以提高排序效率。
- **缓存 `key` 函数的结果**：如果 `key` 函数的计算比较复杂且可能会被多次调用，可以考虑使用 `functools.lru_cache` 来缓存计算结果，减少重复计算。
```python
import functools

@functools.lru_cache(maxsize=None)
def complex_key_function(element):
    # 复杂的计算逻辑
    return result

my_list = [1, 2, 3, 4, 5]
sorted_list = sorted(my_list, key=complex_key_function)
```

### 保持代码简洁和可读性
- **使用有意义的函数名**：如果使用自定义函数作为 `key` 参数，给函数取一个有意义的名字，这样代码的意图会更清晰。
```python
def get_student_age(student):
    return student["age"]

students = [
    {"name": "Alice", "age": 20},
    {"name": "Bob", "age": 18},
    {"name": "Charlie", "age": 22}
]
sorted_students = sorted(students, key=get_student_age)
```
- **避免过于复杂的 `key` 函数**：如果 `key` 函数的逻辑过于复杂，会使代码难以理解和维护。可以考虑将复杂逻辑拆分成多个简单的函数，或者使用辅助变量来简化表达式。

## 小结
`sorted()` 函数的 `key` 参数为 Python 中的排序操作提供了强大的自定义功能。通过合理使用 `key` 参数，我们可以根据各种不同的规则对可迭代对象进行排序，无论是简单的数值、字符串，还是复杂的自定义对象。在实际应用中，我们要注意遵循最佳实践，提高代码的性能和可读性。希望本文能够帮助读者深入理解并高效使用 `sorted()` 函数的 `key` 参数。

## 参考资料
- [Python 官方文档 - sorted() 函数](https://docs.python.org/3/library/functions.html#sorted)
- 《Python 核心编程》
- 《Effective Python》