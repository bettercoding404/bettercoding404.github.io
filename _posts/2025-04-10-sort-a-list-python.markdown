---
title: "Python 列表排序：深入解析与最佳实践"
description: "在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、组织信息还是优化算法，掌握列表排序的技巧都至关重要。本文将全面深入地探讨在 Python 中如何对列表进行排序，涵盖基础概念、各种使用方法、常见实践场景以及最佳实践建议，帮助读者在实际编程中能够熟练且高效地运用列表排序功能。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，对列表进行排序是一项极为常见的操作。无论是处理数据集合、组织信息还是优化算法，掌握列表排序的技巧都至关重要。本文将全面深入地探讨在 Python 中如何对列表进行排序，涵盖基础概念、各种使用方法、常见实践场景以及最佳实践建议，帮助读者在实际编程中能够熟练且高效地运用列表排序功能。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是列表排序
    - 排序算法简介
2. **使用方法**
    - 列表的 `sort()` 方法
    - `sorted()` 函数
    - 自定义排序规则
3. **常见实践**
    - 数字列表排序
    - 字符串列表排序
    - 复杂对象列表排序
4. **最佳实践**
    - 性能优化
    - 代码可读性优化
5. **小结**
6. **参考资料**

## 基础概念
### 什么是列表排序
在 Python 中，列表是一种有序的可变数据类型。列表排序就是将列表中的元素按照特定的顺序进行重新排列，常见的顺序有升序（从小到大）和降序（从大到小）。排序后的列表可以更方便地进行数据查找、比较和处理。

### 排序算法简介
Python 的排序功能背后使用了高效的排序算法，如 Timsort。Timsort 是一种自适应、稳定的排序算法，结合了归并排序（Merge Sort）和插入排序（Insertion Sort）的优点，在各种数据分布情况下都能表现出色。稳定性意味着相等的元素在排序前后的相对顺序保持不变。

## 使用方法
### 列表的 `sort()` 方法
`sort()` 方法是列表对象的一个内置方法，它会直接修改原始列表，将列表中的元素按照升序排列。

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort()
print(my_list)  
```

如果要按照降序排列，可以使用 `reverse=True` 参数：

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
my_list.sort(reverse=True)
print(my_list)  
```

### `sorted()` 函数
`sorted()` 函数是 Python 的内置函数，它接受一个可迭代对象（如列表）作为参数，并返回一个新的已排序列表，原始列表不会被修改。

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list)
print(new_list)  
print(my_list)  
```

同样，也可以通过 `reverse=True` 参数实现降序排序：

```python
my_list = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
new_list = sorted(my_list, reverse=True)
print(new_list)  
```

### 自定义排序规则
有时候我们需要根据特定的规则对列表元素进行排序。可以通过 `key` 参数来指定一个函数，该函数将应用于每个元素，然后根据函数返回值进行排序。

例如，对字符串列表按照字符串长度进行排序：

```python
string_list = ["banana", "apple", "cherry", "date"]
sorted_by_length = sorted(string_list, key=len)
print(sorted_by_length)  
```

对于复杂对象列表，例如自定义类的实例列表，我们可以定义类的 `__lt__` 方法（小于比较方法）来实现排序，或者在 `sorted()` 或 `sort()` 中使用 `key` 参数指定排序依据。

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __repr__(self):
        return f"Person({self.name}, {self.age})"

people = [Person("Alice", 25), Person("Bob", 20), Person("Charlie", 30)]

# 按照年龄排序
sorted_people = sorted(people, key=lambda person: person.age)
print(sorted_people)  
```

## 常见实践
### 数字列表排序
在处理数字列表时，`sort()` 方法和 `sorted()` 函数都能轻松实现升序或降序排序。这在数据分析、统计计算等场景中经常用到。

```python
numbers = [12, 45, 6, 78, 34, 90]
sorted_numbers_asc = sorted(numbers)
sorted_numbers_desc = sorted(numbers, reverse=True)
print(sorted_numbers_asc)  
print(sorted_numbers_desc)  
```

### 字符串列表排序
对于字符串列表，默认的排序是按照字典序。可以通过 `key` 参数实现更灵活的排序，如按照字符串长度、特定字符位置等进行排序。

```python
words = ["python", "java", "c++", "javascript"]
sorted_by_length = sorted(words, key=len)
print(sorted_by_length)  
```

### 复杂对象列表排序
在面向对象编程中，经常需要对自定义类的实例列表进行排序。通过定义合适的比较方法或使用 `key` 参数，可以实现基于对象属性的排序。

```python
class Book:
    def __init__(self, title, author, year):
        self.title = title
        self.author = author
        self.year = year

    def __repr__(self):
        return f"Book('{self.title}', '{self.author}', {self.year})"

books = [Book("Python Crash Course", "Eric Matthes", 2015),
         Book("Clean Code", "Robert C. Martin", 2008),
         Book("The Mythical Man - Month", "Frederick P. Brooks Jr.", 1975)]

# 按照出版年份排序
sorted_books = sorted(books, key=lambda book: book.year)
print(sorted_books)  
```

## 最佳实践
### 性能优化
- **选择合适的排序方法**：如果只需要对列表进行一次排序并且不需要保留原始列表，`sorted()` 函数更方便。但如果需要多次对同一列表进行排序，使用 `sort()` 方法可以避免每次都创建新列表的开销。
- **利用稳定排序**：在某些情况下，稳定性很重要。例如，在对学生成绩列表排序时，先按总分排序，再按语文成绩排序，使用稳定排序算法可以保证总分相同的学生在按语文成绩排序时相对顺序不变。

### 代码可读性优化
- **使用描述性的 `key` 函数**：当使用 `key` 参数自定义排序规则时，尽量使用有意义的函数名或 lambda 表达式，以便代码更易读。
- **封装复杂排序逻辑**：如果排序规则比较复杂，可以将其封装成一个独立的函数，而不是在 `sort()` 或 `sorted()` 中直接使用复杂的 lambda 表达式。

```python
def get_book_sort_key(book):
    return (book.year, book.title)

books = [Book("Python Crash Course", "Eric Matthes", 2015),
         Book("Clean Code", "Robert C. Martin", 2008),
         Book("The Mythical Man - Month", "Frederick P. Brooks Jr.", 1975)]

sorted_books = sorted(books, key=get_book_sort_key)
print(sorted_books)  
```

## 小结
在 Python 中对列表进行排序有多种方法，每种方法都有其特点和适用场景。`sort()` 方法直接修改原始列表，而 `sorted()` 函数返回新的已排序列表。通过 `key` 参数可以实现自定义排序规则，满足各种复杂需求。在实际编程中，要根据性能需求和代码可读性来选择合适的排序方式和技巧，以提高程序的质量和效率。

## 参考资料
- [Python 官方文档 - 排序算法](https://docs.python.org/3/howto/sorting.html){: rel="nofollow"}
- [Python 官方文档 - 列表方法](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists){: rel="nofollow"}
- [Python 官方文档 - 内置函数 - sorted](https://docs.python.org/3/library/functions.html#sorted){: rel="nofollow"}