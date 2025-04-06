---
title: "Python 类变量命名规范之下划线命名法"
description: "在 Python 编程中，类变量的命名规范是一个重要的方面，它不仅影响代码的可读性，还关乎代码的可维护性。下划线命名法是 Python 中常用的一种命名约定，特别是在处理类变量时。理解并遵循这种命名规范有助于编写更清晰、易于理解和协作的代码。本文将深入探讨 Python 类变量命名规范中的下划线命名法，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，类变量的命名规范是一个重要的方面，它不仅影响代码的可读性，还关乎代码的可维护性。下划线命名法是 Python 中常用的一种命名约定，特别是在处理类变量时。理解并遵循这种命名规范有助于编写更清晰、易于理解和协作的代码。本文将深入探讨 Python 类变量命名规范中的下划线命名法，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 单下划线开头
    - 双下划线开头
    - 双下划线开头和结尾
3. 常见实践
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
在 Python 中，下划线在变量命名中具有特殊的含义。下划线命名法主要有以下几种形式：
- **单下划线开头（`_var`）**：表示该变量是一个“内部使用”的变量，通常约定为非公开的，虽然在技术上仍然可以从外部访问，但不建议这样做。这是一种向其他开发者传达该变量不应该被直接访问的约定。
- **双下划线开头（`__var`）**：这种命名会触发 Python 的名称修饰机制。在类定义中，以双下划线开头的变量名会被修改，以避免在子类中发生命名冲突。实际上，Python 会在变量名前加上类名前缀，使得变量在类外部难以直接访问。
- **双下划线开头和结尾（`__var__`）**：这类变量是 Python 的特殊方法或属性，通常被称为“魔法方法”。例如 `__init__`、`__str__` 等，它们具有特定的用途和行为，由 Python 解释器在特定情况下自动调用。

## 使用方法
### 单下划线开头
```python
class MyClass:
    def __init__(self):
        self._internal_variable = 42

    def get_internal_variable(self):
        return self._internal_variable


obj = MyClass()
print(obj.get_internal_variable())  # 可以通过这种方式访问
print(obj._internal_variable)  # 虽然技术上可以直接访问，但不建议
```
在上述代码中，`_internal_variable` 被定义为一个内部变量。通过定义访问方法 `get_internal_variable` 来获取该变量的值是更合适的方式。

### 双下划线开头
```python
class MyClass:
    def __init__(self):
        self.__private_variable = 100

    def get_private_variable(self):
        return self.__private_variable


obj = MyClass()
# print(obj.__private_variable)  # 这会导致 AttributeError
print(obj.get_private_variable())  
```
在这个例子中，`__private_variable` 是一个私有变量。尝试直接访问 `obj.__private_variable` 会引发 `AttributeError`，因为 Python 对其进行了名称修饰。实际上，变量在内存中被重命名为 `_MyClass__private_variable`，可以通过 `obj._MyClass__private_variable` 访问，但这同样不推荐。

### 双下划线开头和结尾
```python
class MyClass:
    def __init__(self):
        self.value = 5

    def __str__(self):
        return f"MyClass with value {self.value}"


obj = MyClass()
print(obj)  
```
在这段代码中，`__str__` 是一个魔法方法。当使用 `print()` 函数打印对象时，Python 会自动调用 `__str__` 方法来获取对象的字符串表示。

## 常见实践
- **表示内部变量**：单下划线开头的变量常用于表示类内部使用的变量，这些变量不应该被类的外部直接修改。例如，在一个复杂的类中，可能有一些变量用于辅助类的内部逻辑，但对于外部用户来说并不重要。
- **避免命名冲突**：双下划线开头的变量用于创建真正的私有变量，防止在子类中意外地覆盖变量。这在设计框架或大型类层次结构时非常有用。
- **实现特殊方法**：双下划线开头和结尾的魔法方法用于实现各种特殊功能，如对象的初始化（`__init__`）、比较（`__eq__`）、迭代（`__iter__`）等。了解并正确使用这些魔法方法可以大大增强类的功能和灵活性。

## 最佳实践
- **遵循约定**：始终遵循 Python 的命名约定，特别是下划线命名法。这有助于其他开发者快速理解代码的意图，减少错误和误解。
- **适度使用私有变量**：虽然双下划线开头的私有变量可以提供一定的封装性，但不要过度使用。过度的封装可能会使代码难以调试和扩展。
- **文档化内部变量**：对于单下划线开头的内部变量，应该在代码的文档字符串中进行适当的说明，解释为什么这些变量被认为是内部使用的，以及它们的作用。

## 小结
Python 类变量命名规范中的下划线命名法是一种强大且灵活的机制，它有助于提高代码的可读性、可维护性和封装性。通过合理使用单下划线开头、双下划线开头以及双下划线开头和结尾的变量命名方式，可以更好地组织和设计类的结构。遵循这些命名规范和最佳实践将使 Python 代码更符合 Pythonic 风格，便于团队协作和项目的长期发展。

## 参考资料
- [Python 官方文档 - 命名规范](https://www.python.org/dev/peps/pep-0008/){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》