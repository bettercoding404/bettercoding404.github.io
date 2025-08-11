---
title: "在Python中：将数字转换为字符串"
description: "在Python编程中，经常会遇到需要将数字数据类型转换为字符串数据类型的情况。这种转换在很多场景下都非常有用，比如格式化输出、与外部系统进行数据交互（例如通过网络发送数据时，数据通常需要是字符串格式），以及在一些需要对数字进行特定文本处理的算法中。本文将详细介绍在Python中把数字转换为字符串的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，经常会遇到需要将数字数据类型转换为字符串数据类型的情况。这种转换在很多场景下都非常有用，比如格式化输出、与外部系统进行数据交互（例如通过网络发送数据时，数据通常需要是字符串格式），以及在一些需要对数字进行特定文本处理的算法中。本文将详细介绍在Python中把数字转换为字符串的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `str()` 函数
    - 格式化字符串方法
3. 常见实践
    - 数字格式化后转换为字符串
    - 处理不同类型数字的转换
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在Python中，数字有多种类型，包括整数（`int`）、浮点数（`float`）等。而字符串则是由字符组成的序列。将数字转换为字符串，本质上是把数字的值以文本形式表示出来，使得我们可以按照处理文本的方式对其进行操作。例如，数字 `123` 转换为字符串后就是 `"123"`，这样我们就可以对这个字符串进行拼接、查找等文本相关的操作。

## 使用方法
### 使用 `str()` 函数
在Python中，最基本、最常用的将数字转换为字符串的方法是使用内置的 `str()` 函数。这个函数接受一个数字作为参数，并返回该数字的字符串表示形式。

```python
# 整数转换为字符串
num_int = 123
str_int = str(num_int)
print(type(str_int))  
print(str_int)  

# 浮点数转换为字符串
num_float = 3.14
str_float = str(num_float)
print(type(str_float))  
print(str_float)  
```

在上述代码中，我们分别定义了一个整数 `num_int` 和一个浮点数 `num_float`，然后使用 `str()` 函数将它们转换为字符串，并打印出转换后的字符串类型和值。

### 格式化字符串方法
Python还提供了多种格式化字符串的方式，这些方式在将数字转换为字符串时可以实现更复杂的格式控制。

#### 使用 `%` 操作符
这是一种比较传统的格式化方式。

```python
num = 42
formatted_str = "The number is %d" % num
print(formatted_str)  

float_num = 3.14159
formatted_float_str = "The float number is %.2f" % float_num
print(formatted_float_str)  
```

在上面的代码中，`%d` 用于格式化整数，`%.2f` 用于格式化浮点数，并且指定保留两位小数。

#### 使用 `format()` 方法
这是一种更灵活、更现代的格式化方式。

```python
num = 100
formatted_str = "The number is {}".format(num)
print(formatted_str)  

float_num = 2.718
formatted_float_str = "The float number is {:.3f}".format(float_num)
print(formatted_float_str)  
```

在这个例子中，`{}` 是占位符，在 `format()` 方法中传入要格式化的数字。`{:.3f}` 表示格式化浮点数并保留三位小数。

#### 使用 f-strings（Python 3.6+）
f-strings 是Python 3.6引入的一种简洁而强大的格式化字符串方式。

```python
num = 55
formatted_str = f"The number is {num}"
print(formatted_str)  

float_num = 1.618
formatted_float_str = f"The float number is {float_num:.2f}"
print(formatted_float_str)  
```

f-strings 允许我们在字符串字面量中直接嵌入表达式，通过在字符串前加上 `f` 前缀来使用。

## 常见实践
### 数字格式化后转换为字符串
在实际应用中，我们经常需要对数字进行特定格式的转换。例如，在财务应用中，可能需要将数字格式化为带有货币符号和千位分隔符的字符串。

```python
import locale

# 设置本地化环境
locale.setlocale(locale.LC_ALL, 'en_US.UTF-8')

amount = 1234567.89
formatted_amount = locale.currency(amount)
print(formatted_amount)  
```

上述代码使用了 `locale` 模块来设置本地化环境，并将数字格式化为带有美元符号和千位分隔符的货币字符串。

### 处理不同类型数字的转换
在处理包含不同类型数字的列表或数据结构时，我们可能需要将其中的所有数字转换为字符串。

```python
nums = [1, 2.5, 3]
str_nums = [str(num) for num in nums]
print(str_nums)  
```

在这个例子中，我们使用列表推导式遍历 `nums` 列表，并将每个数字使用 `str()` 函数转换为字符串，最终得到一个包含字符串的新列表。

## 最佳实践
### 性能优化
如果需要在循环中频繁地将数字转换为字符串，性能可能会成为一个问题。在这种情况下，尽量使用更高效的方法。例如，使用 `str()` 函数通常比格式化字符串方法（尤其是 `%` 操作符和 `format()` 方法）更高效。

```python
import timeit

def convert_with_str():
    num = 123
    return str(num)

def convert_with_format():
    num = 123
    return "{}".format(num)

def convert_with_fstring():
    num = 123
    return f"{num}"

print(timeit.timeit(convert_with_str, number = 1000000))
print(timeit.timeit(convert_with_format, number = 1000000))
print(timeit.timeit(convert_with_fstring, number = 1000000))
```

通过 `timeit` 模块的测试可以发现，`str()` 函数在性能上表现最佳。

### 代码可读性
选择合适的转换方法可以提高代码的可读性。对于简单的转换，`str()` 函数通常是最清晰的选择。但如果需要复杂的格式控制，f-strings（如果使用的Python版本支持）是一个很好的选择，因为它的语法简洁直观。

```python
# 简单转换，使用 str() 函数
age = 30
age_str = str(age)

# 复杂格式控制，使用 f-strings
pi = 3.14159
formatted_pi = f"Pi rounded to two decimal places is {pi:.2f}"
```

## 小结
在Python中，将数字转换为字符串有多种方法，每种方法都有其适用场景。`str()` 函数是最基本、最常用的方法，适用于简单的转换需求。格式化字符串方法，如 `%` 操作符、`format()` 方法和 f-strings，则提供了更灵活的格式控制。在实际应用中，我们需要根据具体需求选择合适的方法，同时考虑性能和代码可读性等因素。

## 参考资料
- 《Python Cookbook》