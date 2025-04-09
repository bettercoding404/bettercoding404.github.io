---
title: "Python 中列出目录文件的全面指南"
description: "在 Python 编程中，经常会遇到需要列出指定目录下的文件和子目录的情况。无论是处理文件管理、数据处理还是自动化脚本，能够有效地获取目录内容都是一项基本技能。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---

<!-- more -->

## 简介
在 Python 编程中，经常会遇到需要列出指定目录下的文件和子目录的情况。无论是处理文件管理、数据处理还是自动化脚本，能够有效地获取目录内容都是一项基本技能。本文将深入探讨如何使用 Python 列出目录中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.listdir()`
    - 使用 `os.scandir()`
    - 使用 `pathlib.Path.iterdir()`
3. 常见实践
    - 列出当前目录下的所有文件
    - 列出指定目录下的所有文件
    - 过滤特定类型的文件
4. 最佳实践
    - 处理异常
    - 递归列出目录中的所有文件
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在深入学习具体的代码实现之前，先来了解一些基本概念。在操作系统中，目录（也称为文件夹）是用于组织和存储文件的容器。每个目录可以包含多个文件和子目录。Python 提供了不同的模块和函数来与文件系统进行交互，其中包括列出目录内容的功能。

## 使用方法

### 使用 `os.listdir()`
`os.listdir()` 是 Python 标准库 `os` 模块中一个常用的函数，用于返回指定目录中所有文件和子目录的名称列表。

```python
import os

# 列出当前目录下的所有文件和子目录
files_and_dirs = os.listdir()
for item in files_and_dirs:
    print(item)

# 列出指定目录下的所有文件和子目录
specified_dir = "/path/to/directory"
files_and_dirs_in_specified_dir = os.listdir(specified_dir)
for item in files_and_dirs_in_specified_dir:
    print(item)
```

### 使用 `os.scandir()`
`os.scandir()` 是 Python 3.5 及以上版本中 `os` 模块新增的函数，它返回一个迭代器，迭代器的每个元素是一个 `DirEntry` 对象，包含了文件或子目录的更多信息，如文件类型、文件大小等，性能也比 `os.listdir()` 更好。

```python
import os

# 列出当前目录下的所有文件和子目录
with os.scandir() as entries:
    for entry in entries:
        if entry.is_file():
            print(f"文件: {entry.name}")
        elif entry.is_dir():
            print(f"目录: {entry.name}")

# 列出指定目录下的所有文件和子目录
specified_dir = "/path/to/directory"
with os.scandir(specified_dir) as entries:
    for entry in entries:
        if entry.is_file():
            print(f"文件: {entry.name}")
        elif entry.is_dir():
            print(f"目录: {entry.name}")
```

### 使用 `pathlib.Path.iterdir()`
`pathlib` 是 Python 3.4 及以上版本中用于处理文件系统路径的模块，`Path.iterdir()` 方法返回一个迭代器，用于遍历指定路径下的所有文件和子目录。

```python
from pathlib import Path

# 列出当前目录下的所有文件和子目录
current_dir = Path('.')
for item in current_dir.iterdir():
    if item.is_file():
        print(f"文件: {item.name}")
    elif item.is_dir():
        print(f"目录: {item.name}")

# 列出指定目录下的所有文件和子目录
specified_dir = Path("/path/to/directory")
for item in specified_dir.iterdir():
    if item.is_file():
        print(f"文件: {item.name}")
    elif item.is_dir():
        print(f"目录: {item.name}")
```

## 常见实践

### 列出当前目录下的所有文件
```python
import os

# 使用 os.listdir()
files = [f for f in os.listdir() if os.path.isfile(f)]
for file in files:
    print(file)

# 使用 os.scandir()
with os.scandir() as entries:
    files = [entry.name for entry in entries if entry.is_file()]
    for file in files:
        print(file)

# 使用 pathlib.Path.iterdir()
from pathlib import Path
current_dir = Path('.')
files = [item.name for item in current_dir.iterdir() if item.is_file()]
for file in files:
    print(file)
```

### 列出指定目录下的所有文件
```python
import os

specified_dir = "/path/to/directory"

# 使用 os.listdir()
files = [f for f in os.listdir(specified_dir) if os.path.isfile(os.path.join(specified_dir, f))]
for file in files:
    print(file)

# 使用 os.scandir()
with os.scandir(specified_dir) as entries:
    files = [entry.name for entry in entries if entry.is_file()]
    for file in files:
        print(file)

# 使用 pathlib.Path.iterdir()
from pathlib import Path
specified_dir_path = Path(specified_dir)
files = [item.name for item in specified_dir_path.iterdir() if item.is_file()]
for file in files:
    print(file)
```

### 过滤特定类型的文件
```python
import os

# 列出当前目录下所有的.py 文件
py_files = [f for f in os.listdir() if os.path.isfile(f) and f.endswith('.py')]
for py_file in py_files:
    print(py_file)

# 使用 os.scandir()
with os.scandir() as entries:
    py_files = [entry.name for entry in entries if entry.is_file() and entry.name.endswith('.py')]
    for py_file in py_files:
        print(py_file)

# 使用 pathlib.Path.iterdir()
from pathlib import Path
current_dir = Path('.')
py_files = [item.name for item in current_dir.iterdir() if item.is_file() and item.name.endswith('.py')]
for py_file in py_files:
    print(py_file)
```

## 最佳实践

### 处理异常
在访问目录和文件时，可能会遇到各种异常，如目录不存在、权限不足等。使用 `try - except` 块来处理这些异常可以提高程序的健壮性。

```python
import os

directory = "/path/to/nonexistent/directory"
try:
    files = os.listdir(directory)
    for file in files:
        print(file)
except FileNotFoundError:
    print(f"目录 {directory} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {directory}")
```

### 递归列出目录中的所有文件
有时候需要遍历目录及其所有子目录中的文件。可以使用递归函数来实现这一功能。

```python
import os

def list_all_files(directory):
    all_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            all_files.append(os.path.join(root, file))
    return all_files

directory = "/path/to/directory"
all_files = list_all_files(directory)
for file in all_files:
    print(file)
```

### 性能优化
如果需要处理大量文件和目录，性能就成为一个重要问题。`os.scandir()` 和 `pathlib.Path.iterdir()` 在性能上优于 `os.listdir()`，因为它们返回的是迭代器，而不是一次性加载所有文件和目录的名称到内存中。此外，避免不必要的文件和目录访问操作也可以提高性能。

## 小结
本文详细介绍了在 Python 中列出目录文件的多种方法，包括 `os.listdir()`、`os.scandir()` 和 `pathlib.Path.iterdir()` 的使用。同时，还探讨了常见实践场景，如列出当前目录或指定目录下的文件、过滤特定类型的文件，以及最佳实践，如处理异常、递归遍历目录和性能优化。通过掌握这些知识和技巧，读者可以更加高效地处理文件系统相关的任务。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》

希望这篇博客对您理解和使用 Python 列出目录文件有所帮助。如果您有任何问题或建议，欢迎在评论区留言。  