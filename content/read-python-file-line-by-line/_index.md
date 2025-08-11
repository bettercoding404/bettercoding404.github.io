---
title: "逐行读取 Python 文件：基础、实践与最佳方案"
description: "在 Python 编程中，处理文件是一项常见的任务。逐行读取文件内容是一种非常实用的操作，它允许我们以一种可控且内存高效的方式处理大型文件。无论是处理文本日志、配置文件还是其他格式的文本文件，逐行读取都能让我们方便地对每一行数据进行处理、分析或转换。本文将深入探讨在 Python 中逐行读取文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，处理文件是一项常见的任务。逐行读取文件内容是一种非常实用的操作，它允许我们以一种可控且内存高效的方式处理大型文件。无论是处理文本日志、配置文件还是其他格式的文本文件，逐行读取都能让我们方便地对每一行数据进行处理、分析或转换。本文将深入探讨在 Python 中逐行读取文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `for` 循环**
    - **使用 `readlines()` 方法**
    - **使用 `readline()` 方法**
3. **常见实践**
    - **处理文本文件中的数据**
    - **解析配置文件**
4. **最佳实践**
    - **内存管理**
    - **异常处理**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，文件被视为一种可迭代的对象。这意味着我们可以使用迭代的方式来处理文件内容，而逐行读取就是其中一种常见的迭代方式。当我们打开一个文件时，Python 会在内存中创建一个文件对象，通过这个对象我们可以对文件进行各种操作，包括读取、写入等。逐行读取文件的核心思想是每次从文件中读取一行内容，这样可以避免一次性将整个文件内容加载到内存中，从而提高内存使用效率，特别是对于大型文件。

## 使用方法

### 使用 `for` 循环
这是最常用且简洁的逐行读取文件的方法。当我们使用 `for` 循环遍历文件对象时，Python 会自动逐行读取文件内容。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            print(line.strip())  # strip() 方法用于去除行末的换行符
except FileNotFoundError:
    print("文件未找到")
```

### 使用 `readlines()` 方法
`readlines()` 方法会将文件的所有行读取到一个列表中，每个元素对应文件中的一行。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```

需要注意的是，这种方法会将整个文件内容加载到内存中，如果文件非常大，可能会导致内存不足的问题。

### 使用 `readline()` 方法
`readline()` 方法每次读取文件的一行，返回一个字符串。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        line = file.readline()
        while line:
            print(line.strip())
            line = file.readline()
except FileNotFoundError:
    print("文件未找到")
```

这种方法在需要精确控制读取位置和次数时比较有用，但使用起来相对繁琐。

## 常见实践

### 处理文本文件中的数据
假设我们有一个包含学生成绩的文本文件，每行格式为 `姓名:成绩`，我们可以逐行读取文件并计算平均成绩。

```python
total_score = 0
student_count = 0

try:
    with open('scores.txt', 'r', encoding='utf-8') as file:
        for line in file:
            parts = line.strip().split(':')
            if len(parts) == 2:
                name, score = parts
                try:
                    score = float(score)
                    total_score += score
                    student_count += 1
                except ValueError:
                    print(f"成绩格式错误: {line}")
except FileNotFoundError:
    print("文件未找到")

if student_count > 0:
    average_score = total_score / student_count
    print(f"平均成绩: {average_score}")
```

### 解析配置文件
配置文件通常采用特定的格式，如 `key=value` 形式。我们可以逐行读取配置文件并解析出配置信息。

```python
config = {}

try:
    with open('config.ini', 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()
            if line and not line.startswith('#'):  # 忽略空行和注释行
                parts = line.split('=')
                if len(parts) == 2:
                    key, value = parts
                    config[key.strip()] = value.strip()
except FileNotFoundError:
    print("文件未找到")

print(config)
```

## 最佳实践

### 内存管理
为了避免内存问题，尽量使用 `for` 循环直接遍历文件对象，而不是使用 `readlines()` 方法将整个文件内容加载到内存中。特别是处理大型文件时，这一点尤为重要。

### 异常处理
在读取文件时，始终要进行异常处理。常见的异常包括文件未找到、权限不足、编码错误等。使用 `try - except` 块可以捕获并处理这些异常，提高程序的稳定性。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            # 处理文件内容
            pass
except FileNotFoundError:
    print("文件未找到")
except PermissionError:
    print("没有权限访问该文件")
except UnicodeDecodeError:
    print("编码错误")
```

## 小结
逐行读取 Python 文件是一项基础且重要的技能。通过使用 `for` 循环、`readlines()` 方法和 `readline()` 方法，我们可以灵活地处理文件内容。在实际应用中，我们要根据具体需求选择合适的方法，并注意内存管理和异常处理等最佳实践，以确保程序的高效运行和稳定性。

## 参考资料
- [Python 官方文档 - 文件 I/O](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files)
- 《Python 核心编程》
- [Stack Overflow - 关于逐行读取文件的讨论](https://stackoverflow.com/questions/tagged/read-file-line-by-line+python)