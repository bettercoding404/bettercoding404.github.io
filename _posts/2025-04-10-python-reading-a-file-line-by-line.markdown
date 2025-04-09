---
title: "Python 逐行读取文件：从基础到最佳实践"
description: "在 Python 编程中，文件处理是一项非常常见且重要的任务。逐行读取文件是一种常用的文件处理方式，它允许我们按顺序处理文件中的每一行数据。这种方法在处理大文件时特别有用，因为它不需要将整个文件一次性加载到内存中，从而节省了内存空间。本文将深入探讨 Python 中逐行读取文件的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，文件处理是一项非常常见且重要的任务。逐行读取文件是一种常用的文件处理方式，它允许我们按顺序处理文件中的每一行数据。这种方法在处理大文件时特别有用，因为它不需要将整个文件一次性加载到内存中，从而节省了内存空间。本文将深入探讨 Python 中逐行读取文件的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `for` 循环
    - 使用 `readline()` 方法
    - 使用 `readlines()` 方法
3. **常见实践**
    - 处理文本文件
    - 处理 CSV 文件
4. **最佳实践**
    - 内存管理
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，文件被视为一系列的字节流或字符流。逐行读取文件意味着一次读取文件中的一行内容。这在处理文本文件时尤为常见，例如日志文件、配置文件、CSV 文件等。通过逐行读取，我们可以对每一行数据进行独立的处理，如解析、转换、过滤等操作。

## 使用方法
### 使用 `for` 循环
这是最常见且简洁的逐行读取文件的方法。`for` 循环会自动迭代文件对象的每一行。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        for line in file:
            print(line.strip())  # strip() 方法用于去除行末的换行符
except FileNotFoundError:
    print("文件未找到")
```

### 使用 `readline()` 方法
`readline()` 方法每次读取文件中的一行，并返回该行内容。

```python
try:
    file = open('example.txt', 'r', encoding='utf-8')
    while True:
        line = file.readline()
        if not line:
            break
        print(line.strip())
    file.close()
except FileNotFoundError:
    print("文件未找到")
```

### 使用 `readlines()` 方法
`readlines()` 方法会读取文件的所有行，并将其作为一个列表返回。虽然这种方法也能逐行访问，但它会将整个文件内容加载到内存中，不适合处理大文件。

```python
try:
    with open('example.txt', 'r', encoding='utf-8') as file:
        lines = file.readlines()
        for line in lines:
            print(line.strip())
except FileNotFoundError:
    print("文件未找到")
```

## 常见实践
### 处理文本文件
假设我们有一个日志文件，需要统计其中包含特定关键词的行数。

```python
keyword = "error"
count = 0
try:
    with open('log.txt', 'r', encoding='utf-8') as file:
        for line in file:
            if keyword in line.lower():
                count += 1
    print(f"包含关键词 '{keyword}' 的行数为: {count}")
except FileNotFoundError:
    print("文件未找到")
```

### 处理 CSV 文件
CSV（逗号分隔值）文件是一种常见的数据存储格式。我们可以逐行读取 CSV 文件并解析数据。

```python
import csv

try:
    with open('data.csv', 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        for row in reader:
            print(row)
except FileNotFoundError:
    print("文件未找到")
```

## 最佳实践
### 内存管理
如前所述，对于大文件，应避免使用 `readlines()` 方法，因为它会将整个文件加载到内存中。使用 `for` 循环或 `readline()` 方法逐行处理文件可以有效减少内存占用。

### 错误处理
在处理文件时，始终要进行错误处理。常见的错误包括文件未找到、权限不足等。使用 `try - except` 块可以捕获并处理这些错误，提高程序的健壮性。

```python
try:
    with open('nonexistent_file.txt', 'r', encoding='utf-8') as file:
        for line in file:
            print(line.strip())
except FileNotFoundError:
    print("文件未找到")
except PermissionError:
    print("权限不足，无法打开文件")
```

## 小结
Python 提供了多种逐行读取文件的方法，每种方法都有其优缺点。在实际应用中，我们应根据文件的大小、处理需求以及内存限制等因素选择合适的方法。同时，注意内存管理和错误处理是编写高效、健壮的文件处理代码的关键。

## 参考资料
- [Python 官方文档 - 文件 I/O](https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files){: rel="nofollow"}
- [Python 教程 - 文件处理](https://www.runoob.com/python3/python3-file-methods.html){: rel="nofollow"}