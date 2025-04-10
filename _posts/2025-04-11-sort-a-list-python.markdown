---
title: "Python 列表排序：深入解析与最佳实践"
description: "在 Python 编程中，列表（list）是一种非常常用且灵活的数据结构。对列表进行排序是一个常见的需求，无论是对数值列表进行从小到大的排序，还是对字符串列表按字母顺序排列，亦或是对自定义对象列表依据特定规则排序。Python 提供了多种方式来实现列表排序，本文将详细介绍这些方法，帮助你更好地掌握和运用列表排序功能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，列表（list）是一种非常常用且灵活的数据结构。对列表进行排序是一个常见的需求，无论是对数值列表进行从小到大的排序，还是对字符串列表按字母顺序排列，亦或是对自定义对象列表依据特定规则排序。Python 提供了多种方式来实现列表排序，本文将详细介绍这些方法，帮助你更好地掌握和运用列表排序功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 列表的 `sort()` 方法
    - `sorted()` 函数
3. 常见实践
    - 数值列表排序
    - 字符串列表排序
    - 自定义对象列表排序
4. 最佳实践
    - 性能优化
    - 稳定性考量
5. 小结
6. 参考资料

## 基础概念
在 Python 中，列表是一个有序的可变序列，它可以包含不同类型的元素。排序操作就是将列表中的元素按照一定的顺序进行重新排列，常见的顺序有升序（从小到大）和降序（从大到小）。

Python 有两种主要的排序方式：一种是列表对象自身的 `sort()` 方法，它会直接修改原始列表；另一种是内置的 `sorted()` 函数，它会返回一个新的已排序列表，而原始列表保持不变。

## 使用方法
### 列表的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接在原始列表上进行排序操作。其语法如下：

```python
list.sort(key=None, reverse=False)
```

- `key` 参数：用于指定一个函数，该函数将应用于列表中的每个元素，作为排序的依据。默认为 `None`，即直接比较元素本身。
- `reverse` 参数：是一个布尔值，默认为 `False`，表示升序排序；如果设置为 `True`，则表示降序排序。

示例：

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

my_list.sort(reverse=True)
print(my_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

### `sorted()` 函数
`sorted()` 是 Python 的一个内置函数，它接受一个可迭代对象（如列表、元组等）作为参数，并返回一个新的已排序列表。其语法如下：

```python
sorted(iterable, key=None, reverse=False)
```

参数含义与 `sort()` 方法中的参数相同。

示例：

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list)
print(new_list)  # 输出: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

new_list = sorted(my_list, reverse=True)
print(new_list)  # 输出: [9, 6, 5, 5, 5, 4, 3, 3, 2, 1, 1]
```

## 常见实践
### 数值列表排序
对数值列表进行排序是最常见的操作之一。可以直接使用 `sort()` 方法或 `sorted()` 函数，无需额外设置 `key` 参数。

```python
numbers = [10, 5, 20, 15, 30]
sorted_numbers = sorted(numbers)
print(sorted_numbers)  # 输出: [5, 10, 15, 20, 30]

numbers.sort(reverse=True)
print(numbers)  # 输出: [30, 20, 15, 10, 5]
```

### 字符串列表排序
字符串列表可以按照字母顺序进行排序。同样可以直接使用 `sort()` 方法或 `sorted()` 函数。

```python
words = ["banana", "apple", "cherry", "date"]
sorted_words = sorted(words)
print(sorted_words)  # 输出: ['apple', 'banana', 'cherry', 'date']

words.sort(reverse=True)
print(words)  # 输出: ['date', 'cherry', 'banana', 'apple']
```

### 自定义对象列表排序
当列表中包含自定义对象时，需要通过 `key` 参数指定排序依据。例如，定义一个 `Person` 类，根据年龄对 `Person` 对象列表进行排序。

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"


people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]

sorted_people = sorted(people, key=lambda person: person.age)
print(sorted_people)  # 输出: [Person(Bob, 20), Person(Alice, 25), Person(Charlie, 30)]
```

## 最佳实践
### 性能优化
- 对于小型列表，`sort()` 方法和 `sorted()` 函数的性能差异不大。但对于大型列表，`sort()` 方法由于直接在原始列表上操作，避免了创建新列表的开销，性能会更好。
- 如果需要多次对同一列表进行排序，建议使用 `sort()` 方法，而不是每次都使用 `sorted()` 函数创建新列表。

### 稳定性考量
排序算法的稳定性是指相等元素在排序前后的相对顺序是否保持不变。Python 的 `sort()` 方法和 `sorted()` 函数使用的排序算法是稳定的。在一些场景下，稳定性非常重要，例如对学生成绩列表排序，先按总分排序，再按语文成绩排序时，保持总分相同的学生的相对顺序不变。

```python
students = [
    ("Alice", 85, 90),
    ("Bob", 80, 85),
    ("Charlie", 85, 88)
]

# 先按总分排序，再按语文成绩排序
students.sort(key=lambda student: student[1], reverse=True)
students.sort(key=lambda student: student[2], reverse=True)
print(students)
```

## 小结
本文详细介绍了 Python 中对列表进行排序的方法，包括列表的 `sort()` 方法和 `sorted()` 函数的使用，以及在数值列表、字符串列表和自定义对象列表排序中的常见实践。同时，还讨论了排序操作中的最佳实践，如性能优化和稳定性考量。通过掌握这些知识，你可以更加高效地处理列表排序需求，编写出更优质的 Python 代码。

## 参考资料
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - sorted()](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}