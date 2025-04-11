---
title: "深入理解 Python 中的 `*args` 和 `**kwargs`"
description: "在 Python 编程中，`*args` 和 `**kwargs` 是两个强大且常用的特性，它们为函数参数的处理提供了极大的灵活性。无论是在处理不确定数量的参数，还是在传递关键字参数时，这两个工具都发挥着重要作用。本文将深入探讨 `*args` 和 `**kwargs` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握它们并在实际编程中高效运用。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，`*args` 和 `**kwargs` 是两个强大且常用的特性，它们为函数参数的处理提供了极大的灵活性。无论是在处理不确定数量的参数，还是在传递关键字参数时，这两个工具都发挥着重要作用。本文将深入探讨 `*args` 和 `**kwargs` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握它们并在实际编程中高效运用。

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
`*args` 是 Python 中用于在函数定义时收集任意数量非关键字参数的语法。“`args`” 这个名称并不是固定的，你可以使用任何你喜欢的名称，但 “`args`” 是一个被广泛接受的约定俗成的名称，代表 “arguments”（参数）。

当在函数定义中使用 `*args` 时，它会将所有传递给函数的非关键字参数收集到一个元组中。这个元组可以在函数内部像普通元组一样进行操作。

## `*args` 使用方法
下面通过代码示例来展示 `*args` 的使用方法：

```python
def print_args(*args):
    for arg in args:
        print(arg)


print_args(1, 2, 3, "hello", [4, 5])
```

在上述代码中，`print_args` 函数接受任意数量的非关键字参数，并将它们逐个打印出来。`*args` 将传递给函数的参数 `1, 2, 3, "hello", [4, 5]` 收集到一个元组中，然后通过循环遍历这个元组并打印每个元素。

### 与普通参数结合使用
`*args` 可以与普通参数一起使用，但普通参数必须在 `*args` 之前：

```python
def add_numbers(a, b, *args):
    total = a + b
    for num in args:
        total += num
    return total


result = add_numbers(1, 2, 3, 4, 5)
print(result)  # 输出 15
```

在这个例子中，`a` 和 `b` 是普通参数，`*args` 收集了额外的参数 `3, 4, 5`。函数先将 `a` 和 `b` 相加，然后再将 `args` 中的所有数字相加，最终返回总和。

## `**kwargs` 基础概念
`**kwargs` 用于在函数定义时收集任意数量的关键字参数。同样，“`kwargs`” 这个名称也不是固定的，但它是常用的约定名称，代表 “keyword arguments”（关键字参数）。

当在函数定义中使用 `**kwargs` 时，它会将所有传递给函数的关键字参数收集到一个字典中。这个字典的键是参数名，值是对应的值。在函数内部，可以像操作普通字典一样对这个字典进行操作。

## `**kwargs` 使用方法
以下是展示 `**kwargs` 使用方法的代码示例：

```python
def print_kwargs(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")


print_kwargs(name="Alice", age=30, city="New York")
```

在上述代码中，`print_kwargs` 函数接受任意数量的关键字参数，并将它们以键值对的形式打印出来。`**kwargs` 将传递给函数的关键字参数 `name="Alice", age=30, city="New York"` 收集到一个字典中，然后通过循环遍历这个字典并打印每个键值对。

### 与普通参数和 `*args` 结合使用
`**kwargs` 可以与普通参数和 `*args` 一起使用，它们的顺序必须是普通参数在前，`*args` 其次，`**kwargs` 最后：

```python
def display_info(name, *args, **kwargs):
    print(f"Name: {name}")
    if args:
        print(f"Additional arguments: {args}")
    if kwargs:
        print(f"Additional keyword arguments: {kwargs}")


display_info("Bob", 1, 2, hobby="Reading", country="USA")
```

在这个例子中，`name` 是普通参数，`*args` 收集了额外的非关键字参数 `1, 2`，`**kwargs` 收集了关键字参数 `hobby="Reading", country="USA"`。函数先打印出名字，然后根据是否有额外参数和关键字参数，分别进行打印展示。

## 常见实践
### 函数参数的动态传递
在编写通用函数时，`*args` 和 `**kwargs` 可以让函数接受不同数量和类型的参数，从而提高函数的灵活性。例如，在一个日志记录函数中：

```python
import logging


def log_message(message, *args, **kwargs):
    logging.basicConfig(level=logging.INFO)
    if args or kwargs:
        logging.info(f"Message: {message}, Args: {args}, Kwargs: {kwargs}")
    else:
        logging.info(f"Message: {message}")


log_message("Operation completed", 10, 20, status="success")
```

### 函数调用的灵活性
在调用函数时，`*args` 和 `**kwargs` 可以用来解包参数列表或字典，从而方便地调用函数。例如：

```python
def calculate(a, b, operation):
    if operation == '+':
        return a + b
    elif operation == '-':
        return a - b


params = [3, 2]
kwargs = {'operation': '+'}
result = calculate(*params, **kwargs)
print(result)  # 输出 5
```

## 最佳实践
### 明确参数的使用目的
在函数定义中使用 `*args` 和 `**kwargs` 时，要确保函数的功能和参数的使用目的是清晰明确的。尽量避免在一个函数中过度使用这两个特性，导致函数的逻辑变得复杂难以理解。

### 合理命名
虽然 `*args` 和 `**kwargs` 是约定俗成的名称，但如果在特定场景下使用更具描述性的名称可以提高代码的可读性。例如，如果函数用于处理用户信息，你可以将 `**kwargs` 命名为 `**user_info`。

### 文档说明
对于使用了 `*args` 和 `**kwargs` 的函数，一定要在函数的文档字符串中清楚地说明这些参数的预期用途和可能的取值范围。这有助于其他开发者理解和使用你的函数。

## 小结
`*args` 和 `**kwargs` 是 Python 中非常强大的特性，它们为函数参数的处理提供了高度的灵活性。通过使用 `*args`，可以轻松处理不确定数量的非关键字参数；而 `**kwargs` 则让我们能够处理任意数量的关键字参数。在实际编程中，合理运用这两个特性可以使代码更加通用和灵活，但同时也要遵循最佳实践，确保代码的可读性和可维护性。

## 参考资料
- [Python 官方文档 - 函数定义](https://docs.python.org/3/reference/compound_stmts.html#function){: rel="nofollow"}
- [Real Python - Understanding Python's *args and **kwargs](https://realpython.com/python-kwargs-and-args/){: rel="nofollow"}