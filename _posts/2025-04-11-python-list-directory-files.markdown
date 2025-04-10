---
title: "Python 中列出目录文件的全面指南"
description: "在 Python 编程中，处理文件和目录是一项常见任务。能够列出目录中的文件是许多实际应用的基础，无论是数据处理、文件管理还是自动化脚本编写。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一重要技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---

<!-- more -->

## 简介
在 Python 编程中，处理文件和目录是一项常见任务。能够列出目录中的文件是许多实际应用的基础，无论是数据处理、文件管理还是自动化脚本编写。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一重要技能。

## 目录
1. **基础概念**
2. **使用方法**
    - `os.listdir()`
    - `os.scandir()`
    - `pathlib.Path.iterdir()`
3. **常见实践**
    - 列出特定目录下的所有文件
    - 筛选特定类型的文件
    - 递归列出目录及其子目录中的文件
4. **最佳实践**
    - 选择合适的方法
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，要列出目录中的文件，需要借助一些内置模块和方法。这些方法主要涉及操作系统相关的功能，因为不同操作系统对文件和目录的管理方式略有不同，但 Python 提供了统一的接口来处理这些操作。

文件系统中的目录（文件夹）是用于组织和存储文件的容器。列出目录中的文件意味着获取该目录下所有文件的名称列表，这在很多情况下都非常有用，比如批量处理文件、检查文件是否存在等。

## 使用方法

### `os.listdir()`
`os.listdir()` 是 Python 标准库 `os` 模块中用于列出指定目录下所有文件和子目录名称的函数。

```python
import os

# 列出当前目录下的所有文件和子目录
files_and_dirs = os.listdir('.')
for item in files_and_dirs:
    print(item)
```

### `os.scandir()`
`os.scandir()` 也是 `os` 模块中的函数，它返回一个迭代器，该迭代器生成 `DirEntry` 对象，这些对象提供了有关目录条目的更多信息，如文件类型、文件大小等。

```python
import os

# 列出当前目录下的所有文件和子目录，并获取更多信息
with os.scandir('.') as entries:
    for entry in entries:
        if entry.is_file():
            print(f"文件: {entry.name}，大小: {entry.stat().st_size} 字节")
        elif entry.is_dir():
            print(f"目录: {entry.name}")
```

### `pathlib.Path.iterdir()`
`pathlib` 模块提供了面向对象的文件路径处理方式。`Path.iterdir()` 方法返回一个迭代器，用于遍历指定路径下的所有文件和子目录。

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

### 列出特定目录下的所有文件
```python
import os

def list_files_in_directory(directory):
    files = []
    for entry in os.scandir(directory):
        if entry.is_file():
            files.append(entry.name)
    return files

directory_path = '/path/to/directory'
file_list = list_files_in_directory(directory_path)
for file in file_list:
    print(file)
```

### 筛选特定类型的文件
```python
import os

def list_py_files_in_directory(directory):
    py_files = []
    for entry in os.scandir(directory):
        if entry.is_file() and entry.name.endswith('.py'):
            py_files.append(entry.name)
    return py_files

directory_path = '.'
py_file_list = list_py_files_in_directory(directory_path)
for py_file in py_file_list:
    print(py_file)
```

### 递归列出目录及其子目录中的文件
```python
import os

def list_all_files_recursively(directory):
    all_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            all_files.append(os.path.join(root, file))
    return all_files

directory_path = '.'
all_file_list = list_all_files_recursively(directory_path)
for file in all_file_list:
    print(file)
```

## 最佳实践

### 选择合适的方法
- 如果只需要获取文件名列表，`os.listdir()` 是一个简单直接的选择。
- 若需要获取文件的详细信息（如文件类型、大小等），`os.scandir()` 或 `pathlib.Path.iterdir()` 更合适，因为它们提供了更丰富的 `DirEntry` 对象。
- 对于递归遍历目录结构，`os.walk()` 是常用的方法。

### 错误处理
在处理文件和目录操作时，可能会遇到各种错误，如目录不存在、权限不足等。应始终进行适当的错误处理，以确保程序的健壮性。

```python
import os

directory_path = '/nonexistent/directory'
try:
    files = os.listdir(directory_path)
    for file in files:
        print(file)
except FileNotFoundError:
    print(f"目录 {directory_path} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {directory_path}")
```

### 性能优化
- 对于大量文件的目录，使用迭代器（如 `os.scandir()` 和 `pathlib.Path.iterdir()` 返回的迭代器）可以避免一次性将所有文件信息加载到内存中，提高性能。
- 在筛选文件时，可以使用生成器表达式来减少内存占用。

```python
import os

def get_py_files_generator(directory):
    for entry in os.scandir(directory):
        if entry.is_file() and entry.name.endswith('.py'):
            yield entry.name

directory_path = '.'
py_files_generator = get_py_files_generator(directory_path)
for py_file in py_files_generator:
    print(py_file)
```

## 小结
本文详细介绍了在 Python 中列出目录文件的基础概念、多种使用方法、常见实践场景以及最佳实践。通过掌握 `os.listdir()`、`os.scandir()` 和 `pathlib.Path.iterdir()` 等方法，以及合理的错误处理和性能优化技巧，读者可以在实际编程中更加高效地处理文件和目录相关的任务。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}