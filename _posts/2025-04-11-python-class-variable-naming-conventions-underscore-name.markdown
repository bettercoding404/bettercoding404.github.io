---
title: "Python 类变量命名规范：下划线命名法"
description: "在 Python 编程中，命名规范是一个重要的方面，它不仅影响代码的可读性，还在一定程度上影响代码的可维护性和可扩展性。类变量命名规范中的下划线命名法是一种常见且具有特定含义的命名方式。本文将深入探讨 Python 类变量命名规范中的下划线命名法，帮助读者理解其概念、掌握使用方法、了解常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，命名规范是一个重要的方面，它不仅影响代码的可读性，还在一定程度上影响代码的可维护性和可扩展性。类变量命名规范中的下划线命名法是一种常见且具有特定含义的命名方式。本文将深入探讨 Python 类变量命名规范中的下划线命名法，帮助读者理解其概念、掌握使用方法、了解常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 单下划线开头的类变量
    - 双下划线开头的类变量
    - 双下划线开头和结尾的类变量
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，下划线在类变量命名中有特殊的含义。根据下划线的数量和位置不同，类变量的性质和使用方式也有所不同。

### 单下划线开头
以单下划线开头的类变量（例如 `_variable`），通常表示这个变量是“受保护的”。这意味着虽然在 Python 中没有严格的访问控制机制，但按照约定，这种变量不应该在类的外部直接访问，它更多是用于类内部以及子类之间的交互。

### 双下划线开头
以双下划线开头的类变量（例如 `__variable`），会触发 Python 的名称修饰（name mangling）机制。这种变量在类的外部不能直接通过变量名访问，它的名称会在内部被修改，以防止在子类或外部意外地重写。

### 双下划线开头和结尾
以双下划线开头和结尾的类变量（例如 `__variable__`），被称为“魔法方法”或“特殊方法”。这些变量通常用于实现 Python 中的一些特殊功能，比如 `__init__` 用于初始化对象，`__str__` 用于定义对象的字符串表示等。

## 使用方法

### 单下划线开头的类变量
```python
class MyClass:
    def __init__(self):
        self._protected_variable = 10

    def _protected_method(self):
        print("This is a protected method")


my_obj = MyClass()
# 虽然可以在外部访问，但不建议
print(my_obj._protected_variable)  
my_obj._protected_method()  
```

### 双下划线开头的类变量
```python
class MyClass:
    def __init__(self):
        self.__private_variable = 20

    def __private_method(self):
        print("This is a private method")


my_obj = MyClass()
# 以下代码会报错，无法直接访问
# print(my_obj.__private_variable)  
# my_obj.__private_method()  

# 可以通过名称修饰后的名称访问，但不建议
print(my_obj._MyClass__private_variable)  
my_obj._MyClass__private_method()  
```

### 双下划线开头和结尾的类变量
```python
class MyClass:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f"MyClass with value {self.value}"


my_obj = MyClass(30)
print(my_obj)  
```

## 常见实践
1. **保护内部状态**：使用单下划线开头的变量来保护类的内部状态，防止外部代码意外修改。例如，在一个数据处理类中，可能有一些中间计算结果的变量使用单下划线开头。
```python
class DataProcessor:
    def __init__(self, data):
        self._data = data

    def process_data(self):
        self._processed_data = self._data * 2
        return self._processed_data


dp = DataProcessor(5)
print(dp.process_data())  
```
2. **实现真正的私有变量**：对于一些不希望被外部访问甚至子类也不应该访问的变量和方法，使用双下划线开头的命名方式。比如在一个加密类中，可能有一些用于密钥生成和管理的变量和方法是私有的。
```python
class Encryption:
    def __init__(self):
        self.__key = "secret_key"

    def __generate_encrypted_text(self, text):
        # 实际的加密逻辑
        return text + self.__key

    def encrypt(self, text):
        return self.__generate_encrypted_text(text)


enc = Encryption()
print(enc.encrypt("Hello"))  
```
3. **特殊方法的使用**：利用双下划线开头和结尾的特殊方法来实现类的一些特殊行为。例如，在一个自定义的集合类中，可以实现 `__len__` 方法来返回集合的元素个数。
```python
class MyCollection:
    def __init__(self):
        self.items = [1, 2, 3]

    def __len__(self):
        return len(self.items)


mc = MyCollection()
print(len(mc))  
```

## 最佳实践
1. **遵循约定**：始终遵循 Python 的命名规范约定，不要随意打破规则。如果一个变量是打算作为内部使用的，就使用单下划线开头；如果是真正私有的，使用双下划线开头。
2. **避免过度使用**：不要过度使用双下划线开头的变量和方法，因为名称修饰会使代码在某些情况下变得难以理解和调试。只有在真正需要严格限制访问的情况下才使用。
3. **文档说明**：对于使用下划线命名的变量和方法，特别是那些有特殊含义的，应该在类的文档字符串中进行说明，以便其他开发人员能够理解代码的意图。

## 小结
Python 类变量命名规范中的下划线命名法是一种强大且灵活的机制，通过不同数量和位置的下划线，我们可以控制变量和方法的访问级别以及实现特殊功能。正确使用下划线命名法能够提高代码的可读性、可维护性和安全性。在实际编程中，我们应该遵循约定，合理使用不同类型的下划线命名方式，并通过文档清晰地传达代码的意图。

## 参考资料
1. [Python 官方文档 - 命名规范](https://www.python.org/dev/peps/pep-0008/){: rel="nofollow"}
2. [Python 深入学习 - 变量和方法命名](https://www.learnpython.org/en/Variable_and_Method_Names){: rel="nofollow"}