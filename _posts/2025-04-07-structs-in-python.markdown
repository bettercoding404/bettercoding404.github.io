---
title: "Python 中的结构体（Structs）：概念、使用与最佳实践"
description: "在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许将不同类型的数据组合成一个单一的实体，方便数据的组织和管理。本文将深入探讨在 Python 中实现和使用结构体的方法，从基础概念到常见实践，再到最佳实践，帮助读者全面掌握这一技术。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 中，虽然没有像 C 语言那样原生的结构体（struct）类型，但可以通过多种方式来实现类似结构体的功能。结构体在编程中非常有用，它允许将不同类型的数据组合成一个单一的实体，方便数据的组织和管理。本文将深入探讨在 Python 中实现和使用结构体的方法，从基础概念到常见实践，再到最佳实践，帮助读者全面掌握这一技术。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是结构体
    - Python 中实现结构体的方式
2. **使用方法**
    - 使用 `class` 定义结构体
    - 使用 `namedtuple` 创建结构体
    - 使用 `dataclass` 实现结构体
3. **常见实践**
    - 数据封装与访问
    - 结构体作为函数参数
    - 结构体的序列化与反序列化
4. **最佳实践**
    - 选择合适的结构体实现方式
    - 保持代码简洁与可读性
    - 考虑性能因素
5. **小结**
6. **参考资料**

## 基础概念
### 什么是结构体
结构体是一种用户自定义的数据类型，它将不同类型的数据成员组合在一起。在传统编程语言（如 C）中，结构体用于将相关的数据项组织成一个逻辑单元。例如，一个表示学生信息的结构体可能包含姓名（字符串）、年龄（整数）和成绩（浮点数）等不同类型的数据。

### Python 中实现结构体的方式
Python 没有内置的 `struct` 类型，但有几种方法可以模拟结构体的行为：
- **使用 `class`**：定义一个类，将结构体的数据成员作为类的属性。这是最常见和灵活的方式，因为类可以包含方法，并且支持面向对象编程的特性。
- **使用 `namedtuple`**：`collections` 模块中的 `namedtuple` 是一个工厂函数，用于创建具有命名字段的元组子类。它比普通元组更具可读性，并且可以通过字段名访问元素。
- **使用 `dataclass`**：Python 3.7 引入的 `dataclass` 装饰器可以自动为类生成一些特殊方法，如 `__init__`、`__repr__` 和 `__eq__`，简化了结构体类的定义。

## 使用方法
### 使用 `class` 定义结构体
```python
class Student:
    def __init__(self, name, age, grade):
        self.name = name
        self.age = age
        self.grade = grade


# 创建结构体实例
student1 = Student("Alice", 20, 95.5)
print(student1.name)  # 输出: Alice
print(student1.age)   # 输出: 20
print(student1.grade) # 输出: 95.5
```
在这个例子中，我们定义了一个 `Student` 类，它有三个属性 `name`、`age` 和 `grade`。通过 `__init__` 方法初始化这些属性，创建 `Student` 类的实例后，可以方便地访问这些属性。

### 使用 `namedtuple` 创建结构体
```python
from collections import namedtuple

Student = namedtuple('Student', ['name', 'age', 'grade'])

# 创建结构体实例
student2 = Student("Bob", 22, 88.0)
print(student2.name)  # 输出: Bob
print(student2.age)   # 输出: 22
print(student2.grade) # 输出: 88.0
```
这里使用 `namedtuple` 创建了一个 `Student` 结构体。`namedtuple` 的第一个参数是结构体的名称，第二个参数是字段名的列表。创建的实例可以像普通元组一样访问元素，也可以通过字段名访问。

### 使用 `dataclass` 实现结构体
```python
from dataclasses import dataclass


@dataclass
class Student:
    name: str
    age: int
    grade: float


# 创建结构体实例
student3 = Student("Charlie", 21, 92.0)
print(student3.name)  # 输出: Charlie
print(student3.age)   # 输出: 21
print(student3.grade) # 输出: 92.0
```
`dataclass` 装饰器使得定义结构体更加简洁。只需定义类的属性及其类型，`dataclass` 会自动生成 `__init__` 等方法。

## 常见实践
### 数据封装与访问
无论是使用 `class`、`namedtuple` 还是 `dataclass`，都可以实现数据的封装。通过合理定义属性和方法，可以控制对结构体内部数据的访问。例如，可以在 `class` 中定义 getter 和 setter 方法来实现对属性的访问控制：
```python
class Student:
    def __init__(self, name, age, grade):
        self._name = name
        self._age = age
        self._grade = grade

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def age(self):
        return self._age

    @age.setter
    def age(self, value):
        if value > 0:
            self._age = value
        else:
            raise ValueError("Age must be a positive number")

    @property
    def grade(self):
        return self._grade


student4 = Student("David", 20, 90.0)
print(student4.name)  # 输出: David
student4.name = "Eve"
print(student4.name)  # 输出: Eve
student4.age = -1  # 会抛出 ValueError
```

### 结构体作为函数参数
结构体作为函数参数可以使函数调用更加清晰和模块化。例如：
```python
def print_student_info(student):
    print(f"Name: {student.name}, Age: {student.age}, Grade: {student.grade}")


student5 = Student("Frank", 23, 85.0)
print_student_info(student5)
```

### 结构体的序列化与反序列化
在实际应用中，可能需要将结构体数据保存到文件或通过网络传输。这就涉及到序列化和反序列化的操作。例如，使用 `json` 模块对 `dataclass` 进行序列化：
```python
import json


@dataclass
class Student:
    name: str
    age: int
    grade: float


student6 = Student("Grace", 22, 90.5)
# 序列化
student_json = json.dumps(student6.__dict__)
print(student_json)  # 输出: {"name": "Grace", "age": 22, "grade": 90.5}

# 反序列化
new_student = Student(**json.loads(student_json))
print(new_student.name)  # 输出: Grace
```

## 最佳实践
### 选择合适的结构体实现方式
- 如果需要复杂的行为和方法，使用 `class` 定义结构体是最好的选择，因为它提供了完整的面向对象编程支持。
- 当只需要简单的数据存储和访问，并且希望代码简洁时，`namedtuple` 是一个不错的选择。它的性能也较好，因为它基于元组。
- 如果注重代码的简洁性和自动生成特殊方法，`dataclass` 是首选。它在 Python 3.7 及以上版本中使用非常方便。

### 保持代码简洁与可读性
无论使用哪种方式，都要保持代码的简洁和可读性。合理命名结构体和属性，避免过度复杂的逻辑。例如，使用有意义的字段名和方法名，使代码易于理解和维护。

### 考虑性能因素
在性能敏感的场景中，`namedtuple` 通常比 `class` 和 `dataclass` 具有更好的性能，因为它基于元组，内存占用小且访问速度快。如果性能是关键因素，可以优先考虑 `namedtuple`。

## 小结
在 Python 中，虽然没有原生的结构体类型，但通过 `class`、`namedtuple` 和 `dataclass` 等方式可以实现类似结构体的功能。不同的实现方式各有优缺点，适用于不同的场景。通过合理选择实现方式，并遵循最佳实践，可以高效地使用结构体来组织和管理数据，提高代码的可读性和可维护性。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》