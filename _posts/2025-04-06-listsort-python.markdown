---
title: "深入理解 Python 中的 list.sort()"
description: "在 Python 编程中，列表（list）是一种非常常用的数据结构。而 `list.sort()` 方法是对列表进行排序操作的重要工具。掌握 `list.sort()` 的使用方法，可以让我们更高效地处理和分析列表中的数据。本文将详细介绍 `list.sort()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者深入理解并在实际项目中灵活运用。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，列表（list）是一种非常常用的数据结构。而 `list.sort()` 方法是对列表进行排序操作的重要工具。掌握 `list.sort()` 的使用方法，可以让我们更高效地处理和分析列表中的数据。本文将详细介绍 `list.sort()` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者深入理解并在实际项目中灵活运用。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 简单排序
    - 自定义排序
3. 常见实践
    - 数字列表排序
    - 字符串列表排序
    - 复杂对象列表排序
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
`list.sort()` 是 Python 列表对象的一个内置方法，用于对列表中的元素进行排序。该方法会直接修改原始列表，而不是返回一个新的已排序列表。这与内置函数 `sorted()` 有所不同，`sorted()` 会返回一个新的已排序列表，原始列表保持不变。

## 使用方法
### 简单排序
对列表进行简单排序非常容易，只需调用 `list.sort()` 方法即可。默认情况下，它会按照元素的自然顺序进行排序。

```python
# 数字列表排序
numbers = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
numbers.sort()
print(numbers)

# 字符串列表排序
fruits = ["banana", "apple", "cherry", "date"]
fruits.sort()
print(fruits)
```

### 自定义排序
`list.sort()` 方法还支持通过 `key` 参数来指定自定义的排序规则。`key` 参数是一个函数，它接受一个列表元素作为参数，并返回一个用于比较的值。

```python
# 根据字符串长度对列表进行排序
words = ["python", "is", "a", "powerful", "language"]
words.sort(key=len)
print(words)

# 自定义对象列表排序
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]
people.sort(key=lambda p: p.age)
print(people)
```

## 常见实践
### 数字列表排序
在处理数字列表时，`list.sort()` 可以快速对列表进行升序或降序排序。

```python
# 升序排序
nums_asc = [5, 2, 8, 1, 9]
nums_asc.sort()
print(nums_asc)

# 降序排序
nums_desc = [5, 2, 8, 1, 9]
nums_desc.sort(reverse=True)
print(nums_desc)
```

### 字符串列表排序
对于字符串列表，`list.sort()` 按照字典序进行排序。

```python
names = ["John", "Alice", "Bob", "Eve"]
names.sort()
print(names)
```

### 复杂对象列表排序
在处理包含自定义对象的列表时，通过 `key` 参数可以根据对象的特定属性进行排序。

```python
class Student:
    def __init__(self, name, grade):
        self.name = name
        self.grade = grade

    def __repr__(self):
        return f"Student({self.name}, {self.grade})"

students = [Student("Tom", 85), Student("Jerry", 90), Student("Mickey", 78)]
students.sort(key=lambda s: s.grade, reverse=True)
print(students)
```

## 最佳实践
### 性能优化
在处理大规模数据时，性能是一个重要的考虑因素。由于 `list.sort()` 是原地排序，相比于 `sorted()` 不会创建新的列表，因此在某些情况下性能更好。但如果需要保留原始列表，还是应该使用 `sorted()`。

### 代码可读性
在使用 `key` 参数时，尽量使用有意义的函数名来提高代码的可读性，避免使用过于复杂的 lambda 表达式。

```python
def get_age(person):
    return person.age

people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]
people.sort(key=get_age)
print(people)
```

## 小结
`list.sort()` 是 Python 中对列表进行排序的强大方法。通过简单排序和自定义排序，我们可以灵活地处理各种类型的列表数据。在实际应用中，需要根据具体需求选择合适的排序方式，并注意性能优化和代码可读性。

## 参考资料
- [Python 官方文档 - list.sort()](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》