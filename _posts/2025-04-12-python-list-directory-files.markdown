---
title: "Python 列出目录文件：全面指南"
description: "在 Python 编程中，经常会遇到需要列出指定目录下文件的需求。无论是进行文件处理、数据整理，还是开发系统工具，能够灵活地操作文件目录结构都是一项重要的技能。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---

<!-- more -->

## 简介
在 Python 编程中，经常会遇到需要列出指定目录下文件的需求。无论是进行文件处理、数据整理，还是开发系统工具，能够灵活地操作文件目录结构都是一项重要的技能。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践建议。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.listdir()`
    - 使用 `os.scandir()`
    - 使用 `pathlib` 模块
3. 常见实践
    - 遍历多层目录
    - 过滤特定类型的文件
4. 最佳实践
    - 性能优化
    - 代码可读性与可维护性
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织和存储文件的容器。Python 提供了多种方式来与文件系统进行交互，其中列出目录中的文件是基本操作之一。通过列出目录文件，我们可以获取目录下所有文件和子目录的名称，进而对它们进行进一步的操作，如读取文件内容、重命名文件、删除文件等。

## 使用方法

### 使用 `os.listdir()`
`os.listdir()` 是 Python 标准库 `os` 模块中用于列出指定目录中所有文件和子目录名称的函数。

```python
import os

# 列出当前目录下的所有文件和子目录
files_and_dirs = os.listdir('.')
for item in files_and_dirs:
    print(item)
```

### 使用 `os.scandir()`
`os.scandir()` 是 `os.listdir()` 的改进版本，它返回一个迭代器，该迭代器生成 `DirEntry` 对象，这些对象提供了关于文件和目录的更多信息，如文件类型、文件大小等。

```python
import os

# 列出当前目录下的所有文件和子目录
with os.scandir('.') as entries:
    for entry in entries:
        if entry.is_file():
            print(f"文件: {entry.name}")
        elif entry.is_dir():
            print(f"目录: {entry.name}")
```

### 使用 `pathlib` 模块
`pathlib` 模块提供了面向对象的方式来处理文件路径。`Path.iterdir()` 方法可以用于遍历目录中的所有文件和子目录。

```python
from pathlib import Path

# 列出当前目录下的所有文件和子目录
p = Path('.')
for item in p.iterdir():
    if item.is_file():
        print(f"文件: {item.name}")
    elif item.is_dir():
        print(f"目录: {item.name}")
```

## 常见实践

### 遍历多层目录
在实际应用中，我们经常需要遍历多层目录结构，获取所有层级的文件。可以通过递归的方式来实现。

```python
import os

def list_files_recursively(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            print(os.path.join(root, file))

list_files_recursively('.')
```

### 过滤特定类型的文件
有时候我们只对特定类型的文件感兴趣，比如只获取所有的 `.txt` 文件。可以在遍历目录时进行条件过滤。

```python
import os

def list_txt_files(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.txt'):
                print(os.path.join(root, file))

list_txt_files('.')
```

## 最佳实践

### 性能优化
在处理大量文件时，性能是一个重要的考虑因素。`os.scandir()` 和 `pathlib` 模块通常比 `os.listdir()` 性能更好，因为它们提供了更高效的文件系统交互方式。同时，使用迭代器可以避免一次性将所有文件信息加载到内存中，提高内存使用效率。

### 代码可读性与可维护性
使用 `pathlib` 模块可以使代码更加简洁和易读，因为它采用了面向对象的设计理念。此外，将文件遍历和过滤逻辑封装成函数，可以提高代码的模块化和可维护性。

## 小结
本文详细介绍了在 Python 中列出目录文件的方法，包括 `os.listdir()`、`os.scandir()` 和 `pathlib` 模块的使用。同时，通过常见实践场景展示了如何遍历多层目录和过滤特定类型的文件。在实际开发中，我们应该根据具体需求选择合适的方法，并遵循最佳实践原则，以提高代码的性能、可读性和可维护性。

## 参考资料
- 《Python 核心编程》