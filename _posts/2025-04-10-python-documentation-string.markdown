---
title: "深入理解 Python 文档字符串（Documentation String）"
description: "在 Python 编程中，文档字符串（通常简称为 docstring）是一种用于为代码添加文档注释的强大机制。它不仅能够让代码更易于理解，对于代码的维护、扩展以及团队协作都有着至关重要的作用。通过合理使用 docstring，开发人员可以清晰地传达代码的意图、功能、参数以及返回值等关键信息，无论是对自己日后回顾代码，还是其他开发人员接手项目，都能提供极大的便利。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，文档字符串（通常简称为 docstring）是一种用于为代码添加文档注释的强大机制。它不仅能够让代码更易于理解，对于代码的维护、扩展以及团队协作都有着至关重要的作用。通过合理使用 docstring，开发人员可以清晰地传达代码的意图、功能、参数以及返回值等关键信息，无论是对自己日后回顾代码，还是其他开发人员接手项目，都能提供极大的便利。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 模块级 docstring
    - 函数级 docstring
    - 类级 docstring
3. 常见实践
    - 描述功能
    - 说明参数
    - 解释返回值
    - 提及异常
4. 最佳实践
    - 遵循规范
    - 保持简洁明了
    - 提供示例
5. 小结
6. 参考资料

## 基础概念
Python 文档字符串是一种特殊类型的字符串字面量，用于为模块、函数、类和方法添加文档注释。它通常被定义在模块、函数、类或方法的定义之后的第一行，并且可以使用单引号（`'''`）或双引号（`"""`）括起来。这些字符串在运行时可以通过对象的 `__doc__` 属性访问。

## 使用方法
### 模块级 docstring
模块级 docstring 用于描述整个模块的功能、用途以及相关的注意事项等信息。它应该放置在模块文件的开头部分。

```python
"""
这个模块用于提供一些数学计算的工具函数。

模块中包含了加法、减法等基本数学运算函数。
"""


def add(a, b):
    return a + b


def subtract(a, b):
    return a - b

```

### 函数级 docstring
函数级 docstring 用于详细描述函数的功能、参数、返回值以及可能抛出的异常等信息。它应该放置在函数定义之后的第一行。

```python
def multiply(a, b):
    """
    这个函数用于计算两个数的乘积。

    :param a: 第一个乘数，应为数值类型。
    :param b: 第二个乘数，应为数值类型。
    :return: 两个数的乘积，返回值类型与输入参数类型相同。
    """
    return a * b

```

### 类级 docstring
类级 docstring 用于描述类的功能、属性以及类的使用方法等信息。它应该放置在类定义之后的第一行。

```python
class Rectangle:
    """
    这个类用于表示一个矩形。

    它包含了计算矩形面积和周长的方法。

    Attributes:
        length: 矩形的长度。
        width: 矩形的宽度。
    """

    def __init__(self, length, width):
        self.length = length
        self.width = width

    def area(self):
        return self.length * self.width

    def perimeter(self):
        return 2 * (self.length + self.width)

```

## 常见实践
### 描述功能
在 docstring 中，首先要清晰地描述函数或类的主要功能。这有助于其他开发人员快速了解代码的作用。

### 说明参数
详细说明每个参数的含义、类型以及预期的取值范围。这可以帮助调用者正确使用函数或类。

### 解释返回值
明确说明函数的返回值类型和含义。对于返回复杂数据结构的函数，更需要详细解释返回值的结构。

### 提及异常
如果函数可能会抛出某些异常，在 docstring 中应该提及这些异常以及在什么情况下会抛出。

```python
def divide(a, b):
    """
    这个函数用于计算两个数的除法。

    :param a: 被除数，应为数值类型。
    :param b: 除数，应为数值类型，且不能为 0。
    :return: 两个数的商，返回值类型为浮点数。
    :raises ZeroDivisionError: 当除数为 0 时抛出此异常。
    """
    if b == 0:
        raise ZeroDivisionError("除数不能为 0")
    return a / b

```

## 最佳实践
### 遵循规范
有一些流行的 docstring 规范，如 [PEP 257](https://www.python.org/dev/peps/pep-0257/)，建议遵循这些规范来编写 docstring，以保持代码的一致性和可读性。

### 保持简洁明了
docstring 应该简洁明了，避免使用过于复杂的语言和冗长的句子。重点突出关键信息。

### 提供示例
对于复杂的函数或类，可以在 docstring 中提供使用示例，帮助读者更好地理解如何使用代码。

```python
def factorial(n):
    """
    计算一个整数的阶乘。

    :param n: 非负整数。
    :return: n 的阶乘。

    示例：
    >>> factorial(5)
    120
    >>> factorial(0)
    1
    """
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n - 1)

```

## 小结
Python 文档字符串是编写高质量、可维护代码的重要组成部分。通过合理使用 docstring，我们可以为代码添加清晰的文档注释，使代码的功能、参数、返回值等信息一目了然。遵循规范、保持简洁明了并提供示例是编写优秀 docstring 的关键。这不仅有助于提高代码的可读性，也方便了代码的维护和团队协作。

## 参考资料
- [Python 官方文档 - PEP 257](https://www.python.org/dev/peps/pep-0257/){: rel="nofollow"}
- [Sphinx - 用于生成 Python 文档的工具](https://www.sphinx-doc.org/en/master/){: rel="nofollow"}