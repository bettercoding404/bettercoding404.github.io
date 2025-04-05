---
title: "Python 中列出目录文件的全面指南"
description: "在 Python 编程中，经常需要处理文件和目录。列出目录中的文件是一项基础且常用的操作。无论是进行数据处理、文件管理还是自动化脚本编写，了解如何有效地列出目录中的文件都至关重要。本文将深入探讨 Python 中列出目录文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

<!-- more -->

## 简介
在 Python 编程中，经常需要处理文件和目录。列出目录中的文件是一项基础且常用的操作。无论是进行数据处理、文件管理还是自动化脚本编写，了解如何有效地列出目录中的文件都至关重要。本文将深入探讨 Python 中列出目录文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. **基础概念**
2. **使用方法**
    - `os.listdir()` 方法
    - `os.scandir()` 方法
    - `pathlib.Path.iterdir()` 方法
3. **常见实践**
    - 列出指定目录下的所有文件
    - 筛选特定类型的文件
    - 递归列出目录及其子目录中的文件
4. **最佳实践**
    - 性能优化
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
在 Python 中，列出目录文件本质上是获取指定目录下所有文件和子目录的名称列表。这可以帮助我们对目录结构有一个清晰的了解，进而进行后续的操作，如读取文件内容、移动或删除文件等。

操作系统提供了不同的方式来与文件系统进行交互，Python 通过标准库中的模块（如 `os` 和 `pathlib`）来封装这些操作，使开发者可以方便地操作文件和目录。

## 使用方法

### `os.listdir()` 方法
`os.listdir()` 是 Python `os` 模块中一个简单而常用的方法，用于返回指定目录下的所有文件和子目录的名称列表。

```python
import os

# 列出当前目录下的所有文件和子目录
files_and_dirs = os.listdir('.')
for item in files_and_dirs:
    print(item)
```

### `os.scandir()` 方法
`os.scandir()` 方法返回一个迭代器对象，该对象生成 `DirEntry` 对象，每个 `DirEntry` 对象表示目录中的一个条目（文件或子目录）。这种方式相比 `os.listdir()` 更加高效，因为它在遍历目录时提供了更多的元数据。

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

### `pathlib.Path.iterdir()` 方法
`pathlib` 模块是 Python 3.4 及以上版本中推荐的处理文件路径的方式。`Path.iterdir()` 方法返回一个迭代器，用于遍历指定路径下的所有文件和子目录。

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

### 列出指定目录下的所有文件
```python
import os

def list_files_in_dir(dir_path):
    files = []
    for entry in os.scandir(dir_path):
        if entry.is_file():
            files.append(entry.name)
    return files

dir_path = '/your/directory/path'
file_list = list_files_in_dir(dir_path)
for file in file_list:
    print(file)
```

### 筛选特定类型的文件
```python
import os

def list_specific_files(dir_path, file_extension):
    files = []
    for entry in os.scandir(dir_path):
        if entry.is_file() and entry.name.endswith(file_extension):
            files.append(entry.name)
    return files

dir_path = '/your/directory/path'
file_extension = '.txt'
txt_files = list_specific_files(dir_path, file_extension)
for txt_file in txt_files:
    print(txt_file)
```

### 递归列出目录及其子目录中的文件
```python
import os

def list_files_recursively(dir_path):
    all_files = []
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            all_files.append(os.path.join(root, file))
    return all_files

dir_path = '/your/directory/path'
recursive_file_list = list_files_recursively(dir_path)
for file in recursive_file_list:
    print(file)
```

## 最佳实践

### 性能优化
- 使用 `os.scandir()` 或 `pathlib.Path.iterdir()` 代替 `os.listdir()`，因为它们提供了更高效的遍历方式，并且可以获取更多元数据。
- 对于大型目录，使用迭代器而不是一次性获取所有文件列表，以减少内存占用。

### 错误处理
在处理文件和目录操作时，可能会遇到各种错误，如目录不存在、权限不足等。因此，需要进行适当的错误处理。

```python
import os
from pathlib import Path

dir_path = '/non/existent/directory'

# 使用 os 模块的错误处理
try:
    files = os.listdir(dir_path)
except FileNotFoundError:
    print(f"目录 {dir_path} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {dir_path}")

# 使用 pathlib 模块的错误处理
p = Path(dir_path)
try:
    for item in p.iterdir():
        print(item.name)
except FileNotFoundError:
    print(f"目录 {dir_path} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {dir_path}")
```

## 小结
本文详细介绍了 Python 中列出目录文件的基础概念、多种使用方法、常见实践以及最佳实践。通过掌握 `os.listdir()`、`os.scandir()` 和 `pathlib.Path.iterdir()` 等方法，开发者可以更加灵活高效地处理文件和目录。在实际应用中，结合性能优化和错误处理的最佳实践，可以使代码更加健壮和可靠。

## 参考资料
- 《Python 核心编程》
- 《Effective Python》