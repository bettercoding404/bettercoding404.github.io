---
title: "Python 中的结构体（Structs）"
description: "在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许我们将不同类型的数据组合成一个单一的实体，方便数据的管理和传递。本文将深入探讨在 Python 中实现和使用结构体的方法，涵盖基础概念、使用方式、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许我们将不同类型的数据组合成一个单一的实体，方便数据的管理和传递。本文将深入探讨在 Python 中实现和使用结构体的方法，涵盖基础概念、使用方式、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `class` 实现结构体
    - 使用 `collections.namedtuple` 实现结构体
    - 使用 `dataclasses` 模块实现结构体
3. 常见实践
    - 数据封装与访问
    - 结构体作为函数参数
    - 结构体的序列化与反序列化
4. 最佳实践
    - 选择合适的结构体实现方式
    - 提高代码可读性和可维护性
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
结构体是一种用户定义的数据类型，它将多个不同类型的变量组合在一起，形成一个单一的单元。在 Python 中，结构体的概念可以通过多种方式模拟实现，主要目的是将相关的数据组织在一起，使代码更具可读性和可维护性。

## 使用方法

### 使用 `class` 实现结构体
在 Python 中，最常见的实现结构体的方式是使用 `class`。通过定义一个类，可以将不同类型的属性组合在一起。

```python
class Person:
    def __init__(self, name, age, city):
        self.name = name
        self.age = age
        self.city = city

# 创建结构体实例
person = Person("Alice", 30, "New York")
print(person.name)  
print(person.age)  
print(person.city)  
```

### 使用 `collections.namedtuple` 实现结构体
`collections.namedtuple` 提供了一种轻量级的方式来创建具有命名字段的元组子类。

```python
from collections import namedtuple

Person = namedtuple('Person', ['name', 'age', 'city'])

# 创建结构体实例
person = Person("Bob", 25, "Los Angeles")
print(person.name)  
print(person.age)  
print(person.city)  
```

### 使用 `dataclasses` 模块实现结构体
`dataclasses` 模块在 Python 3.7 及以上版本可用，它提供了一种更简洁的方式来定义类，这些类主要用于存储数据。

```python
from dataclasses import dataclass

@dataclass
class Person:
    name: str
    age: int
    city: str

# 创建结构体实例
person = Person("Charlie", 35, "Chicago")
print(person.name)  
print(person.age)  
print(person.city)  
```

## 常见实践

### 数据封装与访问
结构体的一个主要用途是将相关数据封装在一起，方便管理和访问。通过上述不同方式创建的结构体实例，可以直接访问其属性。

```python
# 使用 class 实现的结构体
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

point = Point(10, 20)
print(point.x)  
print(point.y)  

# 使用 namedtuple 实现的结构体
from collections import namedtuple
PointNT = namedtuple('PointNT', ['x', 'y'])
point_nt = PointNT(15, 25)
print(point_nt.x)  
print(point_nt.y)  

# 使用 dataclass 实现的结构体
from dataclasses import dataclass

@dataclass
class PointDC:
    x: int
    y: int

point_dc = PointDC(20, 30)
print(point_dc.x)  
print(point_dc.y)  
```

### 结构体作为函数参数
将结构体作为函数参数可以使代码更加清晰和模块化。

```python
# 使用 class 实现的结构体作为函数参数
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

def calculate_area(rect):
    return rect.width * rect.height

rect = Rectangle(5, 10)
area = calculate_area(rect)
print(area)  

# 使用 namedtuple 实现的结构体作为函数参数
from collections import namedtuple

RectangleNT = namedtuple('RectangleNT', ['width', 'height'])

def calculate_area_nt(rect):
    return rect.width * rect.height

rect_nt = RectangleNT(7, 12)
area_nt = calculate_area_nt(rect_nt)
print(area_nt)  

# 使用 dataclass 实现的结构体作为函数参数
from dataclasses import dataclass

@dataclass
class RectangleDC:
    width: int
    height: int

def calculate_area_dc(rect):
    return rect.width * rect.height

rect_dc = RectangleDC(6, 11)
area_dc = calculate_area_dc(rect_dc)
print(area_dc)  
```

### 结构体的序列化与反序列化
在实际应用中，经常需要将结构体数据保存到文件或通过网络传输，这就涉及到序列化和反序列化。

```python
import json
from dataclasses import dataclass

@dataclass
class Book:
    title: str
    author: str
    year: int

# 序列化
book = Book("Python Crash Course", "Eric Matthes", 2015)
book_dict = {
    "title": book.title,
    "author": book.author,
    "year": book.year
}
book_json = json.dumps(book_dict)
print(book_json)  

# 反序列化
book_dict_from_json = json.loads(book_json)
book_from_json = Book(**book_dict_from_json)
print(book_from_json.title)  
print(book_from_json.author)  
print(book_from_json.year)  
```

## 最佳实践

### 选择合适的结构体实现方式
- 如果需要定义方法和复杂的行为，使用 `class` 是最佳选择，因为它提供了完整的面向对象编程功能。
- 对于简单的数据存储，`collections.namedtuple` 是一个轻量级的选择，它的性能较好，并且代码简洁。
- 如果使用 Python 3.7 及以上版本，`dataclasses` 模块提供了一种简洁、现代的方式来定义数据类，推荐优先使用。

### 提高代码可读性和可维护性
- 给结构体和其属性起有意义的名字，这样代码的意图更加清晰。
- 保持结构体的定义简洁，避免在结构体中包含过多复杂的逻辑。

### 性能优化
- 如果对性能要求较高，`collections.namedtuple` 和 `dataclasses` 通常比普通 `class` 具有更好的性能，因为它们的实现更加轻量级。
- 在处理大量结构体实例时，可以考虑使用 `numpy` 数组等更高效的数据结构，尤其是当结构体中的数据类型较为一致时。

## 小结
在 Python 中，虽然没有原生的结构体类型，但通过 `class`、`collections.namedtuple` 和 `dataclasses` 模块等方式，我们可以有效地模拟结构体的功能。不同的实现方式各有优缺点，在实际应用中需要根据具体需求选择合适的方法。掌握结构体在 Python 中的使用方法，可以提高代码的可读性、可维护性和性能。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》