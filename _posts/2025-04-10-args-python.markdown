---
title: "深入理解 Python 中的 `*args` 和 `**kwargs`"
description: "在 Python 编程中，`*args` 和 `**kwargs` 是两个非常重要且强大的特性。它们为函数参数的传递提供了极大的灵活性，使得函数可以接受数量可变的参数。无论是在日常开发还是构建通用的函数库时，这两个工具都发挥着关键作用。本文将详细介绍 `*args` 和 `**kwargs` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用它们。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，`*args` 和 `**kwargs` 是两个非常重要且强大的特性。它们为函数参数的传递提供了极大的灵活性，使得函数可以接受数量可变的参数。无论是在日常开发还是构建通用的函数库时，这两个工具都发挥着关键作用。本文将详细介绍 `*args` 和 `**kwargs` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握和运用它们。

<!-- more -->
## 目录
1. `*args` 基础概念
2. `*args` 使用方法
3. `**kwargs` 基础概念
4. `**kwargs` 使用方法
5. 常见实践
6. 最佳实践
7. 小结
8. 参考资料

## `*args` 基础概念
`*args` 是 Python 中用于在函数定义时表示可变参数的语法。这里的 “可变参数” 意味着函数可以接受任意数量的非关键字参数。`*args` 本质上是一个元组，它会收集所有位置参数（即没有参数名，按照顺序传入的参数）。

## `*args` 使用方法
### 示例代码
```python
def print_args(*args):
    for arg in args:
        print(arg)


print_args(1, 2, 3)
print_args('a', 'b', 'c', 'd')
```

### 代码解释
在上述代码中，定义了一个名为 `print_args` 的函数，它接受 `*args` 参数。在函数内部，通过一个 `for` 循环遍历 `args` 元组，并打印其中的每个元素。当调用 `print_args(1, 2, 3)` 时，数字 `1`、`2`、`3` 作为位置参数被收集到 `args` 元组中，然后在函数内部依次打印。同理，`print_args('a', 'b', 'c', 'd')` 也会将字符串参数收集到 `args` 中并打印。

## `**kwargs` 基础概念
`**kwargs` 同样用于在函数定义时处理可变参数，但与 `*args` 不同的是，`**kwargs` 收集的是关键字参数（即带有参数名的参数）。`**kwargs` 本质上是一个字典，其中键是参数名，值是对应的参数值。

## `**kwargs` 使用方法
### 示例代码
```python
def print_kwargs(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")


print_kwargs(name='Alice', age=25, city='Beijing')
```

### 代码解释
这里定义了 `print_kwargs` 函数，它接受 `**kwargs` 参数。在函数内部，通过 `items()` 方法遍历 `kwargs` 字典，打印每个键值对。调用 `print_kwargs(name='Alice', age=25, city='Beijing')` 时，`name`、`age`、`city` 作为关键字参数被收集到 `kwargs` 字典中，然后在函数内部打印出对应的键值对。

## 常见实践
### 结合普通参数、`*args` 和 `**kwargs`
函数可以同时接受普通参数、`*args` 和 `**kwargs`，但它们的顺序必须是普通参数在前，`*args` 其次，`**kwargs` 最后。

```python
def combined_function(a, b, *args, **kwargs):
    print(f"普通参数 a: {a}, b: {b}")
    print("*args 中的参数:")
    for arg in args:
        print(arg)
    print("**kwargs 中的参数:")
    for key, value in kwargs.items():
        print(f"{key}: {value}")


combined_function(1, 2, 3, 4, name='Bob', age=30)
```

### 将序列或可迭代对象作为参数传递给函数
可以使用 `*` 运算符将列表或元组作为位置参数传递给函数。

```python
def add_numbers(a, b, c):
    return a + b + c


numbers = [1, 2, 3]
result = add_numbers(*numbers)
print(result)  
```

### 将字典作为关键字参数传递给函数
使用 `**` 运算符可以将字典作为关键字参数传递给函数。

```python
def describe_person(name, age, city):
    return f"{name} 今年 {age} 岁，住在 {city}。"


person_info = {'name': 'Charlie', 'age': 35, 'city': 'Shanghai'}
description = describe_person(**person_info)
print(description)  
```

## 最佳实践
### 保持函数参数的清晰性
虽然 `*args` 和 `**kwargs` 提供了灵活性，但过度使用可能会使函数的参数含义不明确。尽量在定义函数时明确列出必要的参数，只有在确实需要接受可变参数时才使用 `*args` 和 `**kwargs`。

### 文档化参数
当使用 `*args` 和 `**kwargs` 时，务必在函数的文档字符串中清晰地说明这些参数的预期用途和类型。这样可以帮助其他开发者理解和使用你的函数。

### 避免混淆
注意 `*args` 和 `**kwargs` 的区别，确保在函数调用和定义时正确使用。如果参数既有位置参数又有关键字参数，要遵循正确的顺序。

## 小结
`*args` 和 `**kwargs` 是 Python 中强大的特性，它们为函数参数的处理提供了极大的灵活性。`*args` 用于收集任意数量的非关键字参数，而 `**kwargs` 用于收集任意数量的关键字参数。在实际开发中，合理使用这两个特性可以使代码更加通用和简洁，但也要注意保持代码的清晰性和可维护性。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/tutorial/controlflow.html#more-on-defining-functions){: rel="nofollow"}
- 《Python 核心编程》

希望通过本文的介绍，你对 `*args` 和 `**kwargs` 有了更深入的理解，并能在实际项目中熟练运用它们。  