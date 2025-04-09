---
title: "Python 中列表排序：sort a list"
description: "在 Python 编程中，对列表进行排序是一项常见且重要的操作。无论是处理数据集合、分析信息还是优化算法，能够有效地对列表元素进行排序都能极大地提升程序的效率和可读性。本文将深入探讨 Python 中对列表进行排序的相关知识，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在 Python 编程中，对列表进行排序是一项常见且重要的操作。无论是处理数据集合、分析信息还是优化算法，能够有效地对列表元素进行排序都能极大地提升程序的效率和可读性。本文将深入探讨 Python 中对列表进行排序的相关知识，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 列表的 `sort()` 方法
    - `sorted()` 函数
3. **常见实践**
    - 对数字列表排序
    - 对字符串列表排序
    - 对自定义对象列表排序
4. **最佳实践**
    - 性能优化
    - 代码可读性提升
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，列表（list）是一种有序的可变数据类型，可以包含不同类型的元素。排序（sorting）是将列表中的元素按照一定的规则进行重新排列，常见的排序规则有升序（从小到大）和降序（从大到小）。Python 提供了多种方式来对列表进行排序，主要有列表对象自身的 `sort()` 方法和内置的 `sorted()` 函数。

## 使用方法
### 列表的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接在原列表上进行排序操作，不会返回一个新的列表。

**语法**：
```python
list.sort(key=None, reverse=False)
```
- `key`：一个可选参数，用于指定一个函数，该函数会被应用到每个元素上，以确定排序的依据。默认值为 `None`，表示直接比较元素本身。
- `reverse`：一个布尔值，默认为 `False`，表示升序排序；如果设置为 `True`，则表示降序排序。

**示例**：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

my_list.sort(reverse=True)
print(my_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

### `sorted()` 函数
`sorted()` 函数是 Python 的内置函数，它会返回一个新的已排序列表，而原列表不会被修改。

**语法**：
```python
sorted(iterable, key=None, reverse=False)
```
参数与 `sort()` 方法类似：
- `iterable`：需要排序的可迭代对象，如列表、元组等。
- `key` 和 `reverse` 含义与 `sort()` 方法中的相同。

**示例**：
```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_sorted_list = sorted(my_list)
print(new_sorted_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
print(my_list)  # 输出: [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]，原列表未改变

new_reverse_sorted_list = sorted(my_list, reverse=True)
print(new_reverse_sorted_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

## 常见实践
### 对数字列表排序
数字列表排序是最常见的场景之一。可以直接使用 `sort()` 方法或 `sorted()` 函数进行排序。

**示例**：
```python
number_list = [10, 5, 8, 15, 3]

# 使用 sort() 方法
number_list.sort()
print(number_list)  # 输出: [3, 5, 8, 10, 15]

# 使用 sorted() 函数
new_number_list = [10, 5, 8, 15, 3]
sorted_number_list = sorted(new_number_list)
print(sorted_number_list)  # 输出: [3, 5, 8, 10, 15]
```

### 对字符串列表排序
对字符串列表排序时，默认按照字典序（字母顺序）进行排序。

**示例**：
```python
string_list = ["banana", "apple", "cherry", "date"]
sorted_string_list = sorted(string_list)
print(sorted_string_list)  # 输出: ['apple', 'banana', 'cherry', 'date']

# 按字符串长度排序
def sort_by_length(s):
    return len(s)

string_list = ["banana", "apple", "cherry", "date"]
sorted_by_length = sorted(string_list, key=sort_by_length)
print(sorted_by_length)  # 输出: ['date', 'apple', 'cherry', 'banana']
```

### 对自定义对象列表排序
当列表中包含自定义对象时，需要指定 `key` 函数来告诉 Python 如何比较这些对象。

**示例**：
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]

# 按年龄排序
def get_age(person):
    return person.age

sorted_people = sorted(people, key=get_age)
print(sorted_people)  # 输出: [Person(Bob, 20), Person(Alice, 25), Person(Charlie, 30)]
```

## 最佳实践
### 性能优化
- 对于大型列表，`sort()` 方法通常比 `sorted()` 函数更快，因为 `sort()` 方法直接在原列表上操作，避免了创建新列表的开销。
- 如果需要对多个相同的列表进行排序，并且希望保持原列表不变，可以先使用 `sort()` 方法对其中一个列表进行排序，然后将排序结果复制到其他列表中。

### 代码可读性提升
- 使用有意义的 `key` 函数名称，例如 `get_age`，而不是使用匿名函数（lambda 函数），除非函数逻辑非常简单。这样可以使代码更易读和维护。
- 在对复杂对象进行排序时，将 `key` 函数定义在类的外部，并且使用描述性的名称，这样可以将排序逻辑与类的定义分开，提高代码的模块化程度。

## 小结
本文详细介绍了 Python 中对列表进行排序的方法，包括列表的 `sort()` 方法和 `sorted()` 函数的使用。通过常见实践示例展示了如何对不同类型的列表进行排序，并且提供了一些最佳实践来优化性能和提升代码可读性。掌握这些知识将有助于在 Python 编程中更高效地处理和操作列表数据。

## 参考资料
- [Python 官方文档 - 列表排序](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》