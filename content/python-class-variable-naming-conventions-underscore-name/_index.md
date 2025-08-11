---
title: "Python 类变量命名规范：下划线命名法"
description: "在 Python 编程中，遵循良好的命名规范对于代码的可读性、可维护性至关重要。类变量命名规范中的下划线命名法是一种常用且具有特定含义的方式。理解并正确使用下划线命名法，能够让代码更易于理解和协作开发。本文将深入探讨 Python 类变量命名规范中的下划线命名法，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，遵循良好的命名规范对于代码的可读性、可维护性至关重要。类变量命名规范中的下划线命名法是一种常用且具有特定含义的方式。理解并正确使用下划线命名法，能够让代码更易于理解和协作开发。本文将深入探讨 Python 类变量命名规范中的下划线命名法，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 单下划线开头的变量
    - 双下划线开头的变量
    - 双下划线开头和结尾的变量
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
在 Python 中，下划线在类变量命名中有特殊的意义。通过在变量名前添加不同数量的下划线，可以改变变量的访问权限和含义。主要有以下三种情况：
- **单下划线开头**：如 `_variable`，表示该变量是 “受保护的”，意味着它不应该在类的外部直接访问，但这种保护只是一种约定，并非严格的访问控制。
- **双下划线开头**：如 `__variable`，表示该变量是 “私有” 的，Python 会对其进行名称重整（name mangling），以防止在类的外部直接访问。
- **双下划线开头和结尾**：如 `__variable__`，这种变量是 Python 的特殊方法或属性，通常用于特定的 Python 语言功能，开发者应该避免自定义这种命名风格的变量，除非是为了实现特定的 Python 魔法方法。

## 使用方法

### 单下划线开头的变量
单下划线开头的变量表示 “受保护”。虽然 Python 没有像其他语言那样严格的访问修饰符，但这种命名方式是一种约定，提醒开发者这个变量不应该在类的外部直接访问。

```python
class MyClass:
    def __init__(self):
        self._protected_variable = 42

    def print_protected(self):
        print(self._protected_variable)


obj = MyClass()
obj.print_protected()  # 输出 42
# 虽然可以在外部访问，但不建议这样做
print(obj._protected_variable)  # 输出 42
```

### 双下划线开头的变量
双下划线开头的变量是 “私有” 的。Python 通过名称重整机制，将变量名修改为 `_ClassName__variable` 的形式，使得在类的外部不能直接通过原始变量名访问。

```python
class MyClass:
    def __init__(self):
        self.__private_variable = 100

    def print_private(self):
        print(self.__private_variable)


obj = MyClass()
obj.print_private()  # 输出 100
# 以下操作会引发 AttributeError
# print(obj.__private_variable)  
```

### 双下划线开头和结尾的变量
双下划线开头和结尾的变量是 Python 的特殊方法或属性。例如，`__init__` 是类的构造函数，`__str__` 用于定义对象的字符串表示。

```python
class MyClass:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f"MyClass with value {self.value}"


obj = MyClass(5)
print(obj)  # 输出 MyClass with value 5
```

## 常见实践
- **使用单下划线开头的变量来隐藏内部实现细节**：当一个类有一些内部变量，不希望外部代码直接修改，但又不是严格意义上的私有变量时，可以使用单下划线开头。
```python
class DataProcessor:
    def __init__(self):
        self._data = []

    def add_data(self, value):
        self._data.append(value)

    def process_data(self):
        # 处理数据的逻辑
        pass
```
- **使用双下划线开头的变量来保护关键的内部状态**：对于一些关键的、不应该被外部随意修改的内部状态变量，可以使用双下划线开头，确保其相对的安全性。
```python
class BankAccount:
    def __init__(self, initial_balance):
        self.__balance = initial_balance

    def deposit(self, amount):
        if amount > 0:
            self.__balance += amount

    def withdraw(self, amount):
        if 0 < amount <= self.__balance:
            self.__balance -= amount
```

## 最佳实践
- **一致性**：在整个项目中，始终遵循一种命名风格。如果在一个模块中使用单下划线表示受保护变量，那么在其他模块中也应该保持一致。
- **明确意图**：根据变量的用途和访问需求，选择合适的下划线命名方式。不要过度使用私有变量，以免影响代码的可维护性和扩展性。
- **文档说明**：对于使用下划线命名的变量，尤其是受保护和私有的变量，应该在类的文档字符串中进行说明，以便其他开发者理解代码的意图。
```python
class MyComplexClass:
    """
    这个类用于处理复杂的业务逻辑。
    _internal_variable 是一个受保护的变量，用于存储一些中间结果。
    __private_variable 是一个私有变量，不应该在类的外部访问。
    """
    def __init__(self):
        self._internal_variable = 0
        self.__private_variable = 10
```

## 小结
Python 类变量命名规范中的下划线命名法为开发者提供了一种灵活且有效的方式来管理变量的访问权限和含义。单下划线开头的变量用于表示受保护的变量，双下划线开头的变量用于表示私有变量，双下划线开头和结尾的变量用于特殊方法和属性。遵循这些命名规范并结合最佳实践，能够提高代码的可读性、可维护性和安全性，使 Python 代码更加优雅和健壮。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/)
- 《Python 编程：从入门到实践》
- 《Effective Python: 编写高质量 Python 代码的 59 个有效方法》