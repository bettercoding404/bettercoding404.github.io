---
title: "在Python中把数字转换为字符串"
description: "在Python编程中，将数字转换为字符串是一项常见的操作。这种转换在很多场景下都非常有用，比如当你需要将数字包含在文本消息中，或者将数字数据存储为字符串格式以便于处理和传输时。本文将详细介绍在Python中把数字转换为字符串的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，将数字转换为字符串是一项常见的操作。这种转换在很多场景下都非常有用，比如当你需要将数字包含在文本消息中，或者将数字数据存储为字符串格式以便于处理和传输时。本文将详细介绍在Python中把数字转换为字符串的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `str()` 函数
    - 使用格式化字符串
3. 常见实践
    - 拼接数字和字符串
    - 将数字列表转换为字符串列表
4. 最佳实践
    - 性能优化
    - 代码可读性
5. 小结
6. 参考资料

## 基础概念
在Python中，数字类型主要包括整数（`int`）和浮点数（`float`）。而字符串则是由字符组成的序列。将数字转换为字符串本质上是把数字的数值表示转换为文本形式，这样数字就可以与其他字符串进行合并、格式化输出等操作。

## 使用方法
### 使用 `str()` 函数
在Python中，最基本的将数字转换为字符串的方法是使用内置的 `str()` 函数。这个函数接受一个数字作为参数，并返回对应的字符串表示。

```python
# 转换整数
num_int = 123
str_int = str(num_int)
print(type(str_int))  
print(str_int)  

# 转换浮点数
num_float = 3.14
str_float = str(num_float)
print(type(str_float))  
print(str_float)  
```

### 使用格式化字符串
格式化字符串提供了更灵活的方式来将数字转换为字符串，特别是在需要控制数字的显示格式时。

- **使用 `%` 格式化**
```python
num = 456
formatted_str = "The number is %d" % num
print(formatted_str)  

float_num = 7.89
formatted_float_str = "The float number is %.2f" % float_num
print(formatted_float_str)  
```

- **使用 `format()` 方法**
```python
num = 100
formatted_str = "The number is {}".format(num)
print(formatted_str)  

float_num = 5.678
formatted_float_str = "The float number is {:.1f}".format(float_num)
print(formatted_float_str)  
```

- **使用 f - 字符串（Python 3.6+）**
```python
num = 200
formatted_str = f"The number is {num}"
print(formatted_str)  

float_num = 9.123
formatted_float_str = f"The float number is {float_num:.2f}"
print(formatted_float_str)  
```

## 常见实践
### 拼接数字和字符串
在实际编程中，经常需要将数字与字符串拼接在一起。

```python
name = "Alice"
age = 25
message = name + " is " + str(age) + " years old."
print(message)  

# 使用格式化字符串拼接
message_format = "{0} is {1} years old.".format(name, age)
print(message_format)  

# 使用 f - 字符串拼接
message_fstring = f"{name} is {age} years old."
print(message_fstring)  
```

### 将数字列表转换为字符串列表
有时候需要将列表中的每个数字元素都转换为字符串。

```python
num_list = [1, 2, 3, 4, 5]
str_list = [str(num) for num in num_list]
print(str_list)  
```

## 最佳实践
### 性能优化
如果在循环中频繁进行数字到字符串的转换，`str()` 函数通常是性能最好的选择，因为它是内置函数，执行速度较快。而格式化字符串，特别是 `%` 格式化和 `format()` 方法，在性能上相对较低，尤其是在大量数据的情况下。f - 字符串在性能上介于两者之间，但由于其简洁性和可读性，在很多场景下也是一个不错的选择。

### 代码可读性
为了提高代码的可读性，尽量使用简洁明了的方式进行数字到字符串的转换。对于简单的转换，`str()` 函数已经足够；对于需要格式化的情况，f - 字符串通常是最直观的选择。避免过度复杂的格式化操作，除非有特殊需求。

## 小结
在Python中，将数字转换为字符串有多种方法，每种方法都有其适用的场景。`str()` 函数适用于简单的转换，格式化字符串（`%` 格式化、`format()` 方法和 f - 字符串）则提供了更灵活的格式控制。在实际编程中，要根据性能需求和代码可读性来选择合适的方法。通过掌握这些技巧，能够更高效地处理数字和字符串之间的转换，提升编程效率。

## 参考资料
- [Python官方文档](https://docs.python.org/3/){: rel="nofollow"}
- 《Python核心编程》
- [Real Python - String Formatting in Python](https://realpython.com/python-string-formatting/){: rel="nofollow"}