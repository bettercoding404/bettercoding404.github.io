---
title: "Python 中的格式化输出（print format）"
description: "在 Python 编程中，格式化输出是一项极为重要的技能。它允许我们以整齐、易读且符合特定需求的方式展示数据。`print` 语句是 Python 中用于输出信息的基本工具，而格式化则能让这些输出更加美观和有组织。无论是开发简单的脚本，还是构建大型的应用程序，掌握 `print format` 的使用方法都能极大地提升代码的质量和可读性。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，格式化输出是一项极为重要的技能。它允许我们以整齐、易读且符合特定需求的方式展示数据。`print` 语句是 Python 中用于输出信息的基本工具，而格式化则能让这些输出更加美观和有组织。无论是开发简单的脚本，还是构建大型的应用程序，掌握 `print format` 的使用方法都能极大地提升代码的质量和可读性。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 旧风格格式化
    - 新风格格式化（str.format()）
    - f-string 格式化
3. 常见实践
    - 格式化数字
    - 格式化字符串
    - 格式化日期和时间
4. 最佳实践
    - 提高可读性
    - 性能考量
5. 小结
6. 参考资料

## 基础概念
格式化输出，简单来说，就是按照我们指定的规则对数据进行排版和显示。在 Python 中，这涉及到将变量的值嵌入到字符串中，并对其显示的格式进行控制，比如指定宽度、精度、对齐方式等。

## 使用方法

### 旧风格格式化
这是 Python 早期使用的格式化方式，使用 `%` 操作符。基本语法是在字符串中使用占位符（如 `%s` 用于字符串，`%d` 用于整数，`%f` 用于浮点数等），然后在字符串之后跟上 `%` 以及要插入的值。

```python
name = "Alice"
age = 30
print("My name is %s and I'm %d years old." % (name, age))
```

### 新风格格式化（str.format()）
这种方式是 Python 2.6 及以后引入的，通过 `str.format()` 方法来实现。占位符使用 `{}`，可以通过位置或关键字参数来指定要插入的值。

```python
name = "Bob"
age = 25
print("My name is {} and I'm {} years old.".format(name, age))
# 使用关键字参数
print("My name is {name} and I'm {age} years old.".format(name="Charlie", age=28))
```

### f-string 格式化
这是 Python 3.6 及以上版本引入的一种简洁而强大的格式化方式。只需在字符串前加上 `f` 或 `F`，就可以在 `{}` 中直接嵌入变量或表达式。

```python
name = "David"
age = 35
print(f"My name is {name} and I'm {age} years old.")
# 嵌入表达式
print(f"The sum of 5 and 3 is {5 + 3}.")
```

## 常见实践

### 格式化数字
- **指定宽度和精度**：对于浮点数，可以指定显示的宽度和小数位数。

```python
pi = 3.1415926
# 宽度为 10，精度为 2
print("Pi with width 10 and precision 2: {:.2f}".format(pi))
```

- **千位分隔符**：可以使用 `,` 来添加千位分隔符。

```python
number = 1234567.89
print("Number with thousand separator: {:,}".format(number))
```

### 格式化字符串
- **对齐方式**：可以指定字符串的对齐方式，`<` 表示左对齐，`>` 表示右对齐，`^` 表示居中对齐。

```python
text = "Hello"
# 左对齐，宽度为 10
print("{:<10}".format(text))
# 右对齐，宽度为 10
print("{:>10}".format(text))
# 居中对齐，宽度为 10
print("{:^10}".format(text))
```

### 格式化日期和时间
- **使用 `datetime` 模块结合格式化字符串**

```python
import datetime
now = datetime.datetime.now()
# 格式化日期和时间
print(f"Today is {now.strftime('%Y-%m-%d %H:%M:%S')}")
```

## 最佳实践

### 提高可读性
- 使用 f-string 时，尽量保持表达式简单，避免过于复杂的计算。
- 对于复杂的格式化需求，可以将格式化逻辑封装成函数，提高代码的模块化和可维护性。

### 性能考量
- f-string 通常比旧风格格式化和 `str.format()` 更高效，尤其是在频繁使用格式化的场景中。因此，在 Python 3.6 及以上版本中，优先考虑使用 f-string。

## 小结
Python 提供了多种格式化输出的方式，每种方式都有其特点和适用场景。旧风格格式化简单但不够灵活；新风格格式化 `str.format()` 更加通用和强大；f-string 则以其简洁和高效成为现代 Python 编程中格式化输出的首选。掌握这些格式化方法，并遵循最佳实践，能帮助我们写出更美观、高效且易读的代码。

## 参考资料
- [Python 官方文档 - 格式化字符串字面值](https://docs.python.org/3/reference/lexical_analysis.html#f-strings){: rel="nofollow"}
- [Python 官方文档 - 字符串格式化操作符](https://docs.python.org/3/library/stdtypes.html#old-string-formatting){: rel="nofollow"}
- [Python 官方文档 - str.format()](https://docs.python.org/3/library/stdtypes.html#str.format){: rel="nofollow"}