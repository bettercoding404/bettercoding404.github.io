---
title: "Python 格式化输出：从基础到最佳实践"
description: "在 Python 编程中，格式化输出是一项至关重要的技能。无论是将数据展示给用户，记录日志，还是生成特定格式的文件，都需要对输出进行格式化。Python 提供了多种方式来实现格式化输出，掌握这些方法能使我们的代码更加清晰、易读且具有更好的用户体验。本文将深入探讨 Python 格式化输出的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，格式化输出是一项至关重要的技能。无论是将数据展示给用户，记录日志，还是生成特定格式的文件，都需要对输出进行格式化。Python 提供了多种方式来实现格式化输出，掌握这些方法能使我们的代码更加清晰、易读且具有更好的用户体验。本文将深入探讨 Python 格式化输出的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **百分号格式化**
    - **str.format() 方法**
    - **f-string 格式化**
3. **常见实践**
    - **格式化数字**
    - **格式化字符串**
    - **格式化日期和时间**
4. **最佳实践**
    - **选择合适的格式化方式**
    - **提高代码可读性**
    - **处理复杂数据结构的格式化**
5. **小结**
6. **参考资料**

## 基础概念
格式化输出的核心目的是将数据以特定的、预期的格式呈现出来。在 Python 中，数据类型多种多样，如整数、浮点数、字符串、日期时间等，不同的数据类型在不同的场景下需要不同的格式化方式。例如，在显示货币金额时，我们可能希望数字保留两位小数并带有货币符号；在显示文本时，可能需要对其进行对齐、填充等操作。

## 使用方法

### 百分号格式化
百分号格式化是 Python 中较为传统的格式化方式，它使用 `%` 操作符来指定占位符。常见的占位符有 `%s`（用于字符串）、`%d`（用于整数）、`%f`（用于浮点数）等。

```python
name = "Alice"
age = 30
print("My name is %s and I'm %d years old." % (name, age))
```

### str.format() 方法
`str.format()` 方法是 Python 2.6 及以后版本引入的一种格式化方式，它使用 `{}` 作为占位符，可读性更强，使用也更加灵活。

```python
name = "Bob"
age = 25
print("My name is {} and I'm {} years old.".format(name, age))
# 也可以通过索引指定顺序
print("My name is {1} and I'm {0} years old.".format(age, name))
```

### f-string 格式化
f-string 是 Python 3.6 及以上版本引入的一种格式化方式，它在字符串前加上 `f` 或 `F` 前缀，在 `{}` 中可以直接嵌入变量或表达式。

```python
name = "Charlie"
age = 28
print(f"My name is {name} and I'm {age} years old.")
# 可以在 {} 中执行简单表达式
print(f"The sum of 2 and 3 is {2 + 3}")
```

## 常见实践

### 格式化数字
- **保留指定小数位数**
    ```python
    num = 3.14159
    print("保留两位小数：{:.2f}".format(num))
    print(f"保留两位小数：{num:.2f}")
    ```
- **添加千位分隔符**
    ```python
    large_num = 1234567890
    print("添加千位分隔符：{:,}".format(large_num))
    print(f"添加千位分隔符：{large_num:,}")
    ```

### 格式化字符串
- **字符串对齐**
    ```python
    text = "Hello"
    # 左对齐，宽度为 10
    print("{:<10}".format(text))
    print(f"{text:<10}")
    # 右对齐，宽度为 10
    print("{:>10}".format(text))
    print(f"{text:>10}")
    # 居中对齐，宽度为 10
    print("{:^10}".format(text))
    print(f"{text:^10}")
    ```
- **填充字符串**
    ```python
    text = "Hi"
    # 用 * 填充，宽度为 10，左对齐
    print("{:*<10}".format(text))
    print(f"{text:*<10}")
    ```

### 格式化日期和时间
```python
import datetime

now = datetime.datetime.now()
# 使用 strftime 格式化
print(now.strftime("Today is %Y-%m-%d %H:%M:%S"))
# 使用 f-string 和 strftime 结合
print(f"Today is {now.strftime('%Y-%m-%d %H:%M:%S')}")
```

## 最佳实践

### 选择合适的格式化方式
- 对于简单的格式化需求，且代码需要兼容较旧的 Python 版本，百分号格式化可以满足需求。
- 当需要更灵活的格式化，如通过索引或关键字参数指定占位符的顺序时，`str.format()` 方法更为合适。
- 如果使用的是 Python 3.6 及以上版本，f-string 是首选，因为它的语法简洁、可读性强，并且性能也更好。

### 提高代码可读性
- 在格式化字符串中，尽量保持清晰的结构。避免使用过于复杂的表达式或嵌套过多的占位符。
- 使用描述性的变量名，这样在格式化字符串中更容易理解每个占位符的含义。

### 处理复杂数据结构的格式化
- 对于列表、字典等复杂数据结构，可以先对其进行预处理，提取需要的数据，然后再进行格式化输出。
- 可以自定义格式化函数，将复杂的数据结构转换为适合格式化输出的形式。

## 小结
Python 提供了多种格式化输出的方式，每种方式都有其特点和适用场景。百分号格式化是传统的方式，`str.format()` 方法提供了更灵活的功能，而 f-string 则以其简洁和高效成为现代 Python 编程中的首选。在实际应用中，我们需要根据具体需求选择合适的格式化方式，并遵循最佳实践，以提高代码的可读性和性能。

## 参考资料
- [Python 官方文档 - 字符串格式化](https://docs.python.org/zh-cn/3/library/string.html#formatstrings){: rel="nofollow"}
- [Python 教程 - 格式化输出](https://www.runoob.com/python3/python3-inputoutput.html){: rel="nofollow"}