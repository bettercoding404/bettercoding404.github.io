---
title: "Python 中的结构体（Structs）"
description: "在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许我们将不同类型的数据组合成一个单一的实体，便于数据的组织和管理。本文将深入探讨在 Python 中实现和使用结构体相关概念的方法，涵盖基础概念、使用方式、常见实践以及最佳实践等方面。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许我们将不同类型的数据组合成一个单一的实体，便于数据的组织和管理。本文将深入探讨在 Python 中实现和使用结构体相关概念的方法，涵盖基础概念、使用方式、常见实践以及最佳实践等方面。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `class` 模拟结构体
    - 使用 `namedtuple`
    - 使用 `dataclass`
3. 常见实践
    - 数据封装与访问
    - 结构体作为函数参数
4. 最佳实践
    - 选择合适的实现方式
    - 数据验证与属性方法
5. 小结
6. 参考资料

## 基础概念
结构体本质上是一种用户自定义的数据类型，它将多个不同类型的变量组合在一起形成一个逻辑单元。在 Python 中，我们可以通过不同的手段来创建类似结构体的对象，每种方式都有其特点和适用场景。

## 使用方法

### 使用 `class` 模拟结构体
在 Python 中，最直观的方式是使用 `class` 关键字来创建一个类，类的属性就类似于结构体的成员变量。

```python
class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y


point = Point(3, 5)
print(point.x)  
print(point.y)  
```

在上述代码中，我们定义了一个 `Point` 类，它有两个属性 `x` 和 `y`。通过实例化 `Point` 类，我们可以创建一个 `point` 对象，并访问其属性。

### 使用 `namedtuple`
`collections` 模块中的 `namedtuple` 提供了一种轻量级的方式来创建类似于结构体的对象。`namedtuple` 创建的是一个不可变的对象。

```python
from collections import namedtuple

Point = namedtuple('Point', ['x', 'y'])
point = Point(3, 5)
print(point.x)  
print(point.y)  
```

这里我们使用 `namedtuple` 创建了一个 `Point` 类型，它有两个字段 `x` 和 `y`。`namedtuple` 的优点是创建简单，并且支持通过字段名和索引访问元素。

### 使用 `dataclass`
Python 3.7 引入的 `dataclass` 装饰器提供了一种简洁的方式来创建类，自动生成 `__init__`、`__repr__` 等方法。

```python
from dataclasses import dataclass


@dataclass
class Point:
    x: int
    y: int


point = Point(3, 5)
print(point)  
```

`dataclass` 会根据定义的字段自动生成初始化方法和字符串表示方法，使代码更加简洁。

## 常见实践

### 数据封装与访问
无论是使用 `class`、`namedtuple` 还是 `dataclass`，都可以实现数据的封装。通过定义合适的属性和方法，可以控制数据的访问和修改。

```python
from dataclasses import dataclass


@dataclass
class Rectangle:
    width: int
    height: int

    def area(self):
        return self.width * self.height


rect = Rectangle(4, 5)
print(rect.area())  
```

在这个例子中，`Rectangle` 类封装了 `width` 和 `height` 两个属性，并提供了一个 `area` 方法来计算矩形的面积。

### 结构体作为函数参数
将类似结构体的对象作为函数参数传递可以使代码更加清晰和模块化。

```python
def distance(p1, p2):
    return ((p1.x - p2.x) ** 2 + (p1.y - p2.y) ** 2) ** 0.5


Point = namedtuple('Point', ['x', 'y'])
p1 = Point(0, 0)
p2 = Point(3, 4)
print(distance(p1, p2))  
```

这里 `distance` 函数接受两个 `Point` 对象作为参数，计算它们之间的距离。

## 最佳实践

### 选择合适的实现方式
- 如果需要可变对象并且希望有更多的自定义方法和行为，使用 `class` 是一个不错的选择。
- 对于不可变对象，并且只需要简单的数据存储和访问，`namedtuple` 是一个轻量级的解决方案。
- 如果想要简洁的语法并且自动生成常用方法，`dataclass` 是 Python 3.7 及以上版本的推荐选择。

### 数据验证与属性方法
在处理结构体数据时，可能需要进行数据验证。可以使用属性方法（`property`）来实现数据的验证和控制。

```python
from dataclasses import dataclass


@dataclass
class Person:
    _name: str
    _age: int

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        if not isinstance(value, str):
            raise ValueError("Name must be a string")
        self._name = value

    @property
    def age(self):
        return self._age

    @age.setter
    def age(self, value):
        if not isinstance(value, int) or value < 0:
            raise ValueError("Age must be a non - negative integer")
        self._age = value


person = Person("John", 30)
person.name = "Jane"
# person.age = -5  # 这行代码会引发 ValueError
```

在这个例子中，我们使用属性方法来验证和设置 `name` 和 `age` 属性，确保数据的正确性。

## 小结
在 Python 中实现结构体功能有多种方式，每种方式都有其特点和优势。通过合理选择和使用这些方法，可以更高效地组织和管理数据。无论是简单的数据存储还是复杂的对象行为定义，都能找到合适的解决方案来满足需求。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》