---
title: "Python Print Formatting：深入理解与高效运用"
description: "在Python编程中，`print`语句是我们向控制台输出信息的主要方式。而`print`格式化（`print formatting`）则是让输出更加美观、易读和结构化的关键技巧。通过合理运用`print`格式化，我们可以控制输出的内容排版、数据类型显示等。本文将深入探讨Python `print`格式化的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在Python编程中，`print`语句是我们向控制台输出信息的主要方式。而`print`格式化（`print formatting`）则是让输出更加美观、易读和结构化的关键技巧。通过合理运用`print`格式化，我们可以控制输出的内容排版、数据类型显示等。本文将深入探讨Python `print`格式化的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **旧样式格式化**
    - **新样式格式化（str.format()）**
    - **f-string格式化**
3. **常见实践**
    - **格式化数字**
    - **格式化字符串**
    - **格式化日期和时间**
4. **最佳实践**
    - **选择合适的格式化方式**
    - **提高代码可读性**
    - **避免硬编码格式字符串**
5. **小结**
6. **参考资料**

## 基础概念
`print`格式化本质上是一种将变量和文本按照特定格式组合并输出的技术。在Python中，不同的格式化方式都有其独特的语法规则，但目的都是为了使输出结果更符合我们的需求。格式化可以包括设置数字的精度、对齐文本、添加填充字符等操作。

## 使用方法

### 旧样式格式化
旧样式格式化使用`%`操作符。基本语法是在字符串中使用`%`加上格式化字符（如`%d`表示整数，`%f`表示浮点数等），然后在字符串之后跟上一个`%`以及要格式化的值。

```python
name = "Alice"
age = 30
print("My name is %s and I'm %d years old." % (name, age))
```

### 新样式格式化（str.format()）
新样式格式化使用`str.format()`方法。在字符串中使用花括号`{}`作为占位符，然后通过`format()`方法传入要格式化的值。

```python
name = "Bob"
age = 25
print("My name is {} and I'm {} years old.".format(name, age))
```

还可以通过索引或关键字参数来指定占位符的值：

```python
print("My name is {0} and I'm {1} years old. {0} is a great person.".format(name, age))
print("My name is {name} and I'm {age} years old.".format(name="Charlie", age=28))
```

### f-string格式化
f-string是Python 3.6引入的一种简洁的格式化方式。在字符串前加上`f`，然后在花括号中直接写变量名或表达式。

```python
name = "David"
age = 32
print(f"My name is {name} and I'm {age} years old.")

# 还可以在花括号中进行表达式计算
pi = 3.14159
print(f"The area of a circle with radius 5 is {pi * 5**2}")
```

## 常见实践

### 格式化数字
1. **设置精度**
    - **旧样式**：`print("The value of pi is %.2f" % 3.14159)`
    - **新样式**：`print("The value of pi is {:.2f}".format(3.14159))`
    - **f-string**：`print(f"The value of pi is {3.14159:.2f}")`

2. **添加千位分隔符**
    - **新样式**：`print("The number is {:,}".format(1234567890))`
    - **f-string**：`print(f"The number is {1234567890:,}")`

### 格式化字符串
1. **对齐文本**
    - **左对齐**：
        - **新样式**：`print("|{:<10}|".format("hello"))`
        - **f-string**：`print(f"|{'hello':<10}|")`
    - **右对齐**：
        - **新样式**：`print("|{:>10}|".format("world"))`
        - **f-string**：`print(f"|{'world':>10}|")`
    - **居中对齐**：
        - **新样式**：`print("|{:^10}|".format("python"))`
        - **f-string**：`print(f"|{'python':^10}|")`

### 格式化日期和时间
```python
import datetime

now = datetime.datetime.now()

# 旧样式
print("%02d-%02d-%d" % (now.month, now.day, now.year))

# 新样式
print("{:02d}-{:02d}-{}".format(now.month, now.day, now.year))

# f-string
print(f"{now.month:02d}-{now.day:02d}-{now.year}")
```

## 最佳实践

### 选择合适的格式化方式
- 对于简单的格式化需求，f-string通常是最简洁和易读的选择，尤其是在Python 3.6及以上版本中。
- 如果需要兼容旧版本的Python，新样式格式化（`str.format()`）是一个不错的选择。
- 旧样式格式化在现代代码中使用相对较少，但在一些旧代码库中可能仍然存在。

### 提高代码可读性
尽量保持格式化字符串简洁明了。避免在格式化字符串中编写过于复杂的表达式，将复杂计算放在单独的变量中，然后在格式化字符串中使用这些变量。

### 避免硬编码格式字符串
如果格式字符串可能会在多个地方使用或需要修改，考虑将其定义为一个常量，这样便于维护和修改。

```python
DATE_FORMAT = "{:02d}-{:02d}-{}"
now = datetime.datetime.now()
print(DATE_FORMAT.format(now.month, now.day, now.year))
```

## 小结
Python `print`格式化提供了多种方式来美化和结构化我们的输出。旧样式格式化、新样式格式化（`str.format()`）和f-string格式化各有特点，我们可以根据具体需求选择合适的方式。在实际编程中，遵循最佳实践能够使代码更易读、维护和扩展。通过熟练掌握`print`格式化，我们可以更好地展示程序运行的结果，提高开发效率。

## 参考资料
- [Python官方文档 - 格式化字符串字面值](https://docs.python.org/3/reference/lexical_analysis.html#f-strings){: rel="nofollow"}
- [Python官方文档 - str.format()](https://docs.python.org/3/library/stdtypes.html#str.format){: rel="nofollow"}
- [Python官方文档 - 旧样式字符串格式化](https://docs.python.org/3/library/stdtypes.html#old-string-formatting){: rel="nofollow"}