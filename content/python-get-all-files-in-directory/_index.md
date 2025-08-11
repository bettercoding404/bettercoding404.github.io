---
title: "Python 获取目录下所有文件：深入解析与实践"
description: "在Python编程中，经常会遇到需要获取某个目录下所有文件的情况。无论是进行文件批量处理、数据收集还是项目结构分析，这一功能都非常实用。本文将详细介绍如何使用Python获取目录下的所有文件，涵盖基础概念、使用方法、常见实践以及最佳实践。通过阅读本文，读者能够深入理解并高效运用这一功能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---

<!-- more -->

## 简介
在Python编程中，经常会遇到需要获取某个目录下所有文件的情况。无论是进行文件批量处理、数据收集还是项目结构分析，这一功能都非常实用。本文将详细介绍如何使用Python获取目录下的所有文件，涵盖基础概念、使用方法、常见实践以及最佳实践。通过阅读本文，读者能够深入理解并高效运用这一功能。

## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
3. **常见实践**
    - **遍历多层目录**
    - **按文件类型筛选**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
在深入探讨如何获取目录下的所有文件之前，先了解一些相关的基础概念。

### 目录（Directory）
目录，也称为文件夹，是操作系统中用于组织和存储文件的容器。每个目录可以包含多个文件和子目录，形成一种层级结构。

### 文件系统（File System）
文件系统是操作系统用于管理文件和目录的机制。它规定了文件和目录的命名规则、存储方式以及访问权限等。Python提供了多种方式来与不同的文件系统进行交互。

## 使用方法
### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块，其中包含了许多处理文件和目录的函数。要获取目录下的所有文件，可以使用 `os.listdir()` 函数。

```python
import os

directory = '.'  # 当前目录
files = os.listdir(directory)
for file in files:
    if os.path.isfile(os.path.join(directory, file)):
        print(file)
```

在上述代码中：
1. 首先导入 `os` 模块。
2. 定义 `directory` 变量，指定要遍历的目录，这里使用 `.` 表示当前目录。
3. 使用 `os.listdir()` 函数获取目录下的所有文件和子目录的名称列表。
4. 通过 `os.path.isfile()` 函数判断每个名称是否为文件，如果是，则打印文件名。

### pathlib 模块
`pathlib` 模块是Python 3.4 及以上版本引入的标准库模块，它提供了一种面向对象的方式来处理文件路径。

```python
from pathlib import Path

directory = Path('.')  # 当前目录
files = [file for file in directory.iterdir() if file.is_file()]
for file in files:
    print(file.name)
```

在这段代码中：
1. 从 `pathlib` 模块导入 `Path` 类。
2. 创建一个 `Path` 对象，表示当前目录。
3. 使用 `iterdir()` 方法遍历目录下的所有对象，并通过 `is_file()` 方法筛选出文件。
4. 打印每个文件的名称。

## 常见实践
### 遍历多层目录
有时候需要获取某个目录及其所有子目录下的所有文件。可以使用递归的方法来实现。

**使用 os 模块**
```python
import os

def get_all_files(directory):
    all_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            all_files.append(os.path.join(root, file))
    return all_files

directory = '.'
files = get_all_files(directory)
for file in files:
    print(file)
```

在上述代码中，`os.walk()` 函数会递归遍历指定目录及其所有子目录。`root` 表示当前目录路径，`dirs` 表示当前目录下的子目录列表，`files` 表示当前目录下的文件列表。

**使用 pathlib 模块**
```python
from pathlib import Path

def get_all_files(directory):
    all_files = []
    for file in directory.rglob('*'):
        if file.is_file():
            all_files.append(file)
    return all_files

directory = Path('.')
files = get_all_files(directory)
for file in files:
    print(file)
```

这里使用 `rglob()` 方法递归地搜索指定目录及其所有子目录下的所有文件。

### 按文件类型筛选
在实际应用中，可能只需要获取特定类型的文件，例如所有的 `.txt` 文件。

**使用 os 模块**
```python
import os

def get_files_by_extension(directory, extension):
    all_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                all_files.append(os.path.join(root, file))
    return all_files

directory = '.'
extension = '.txt'
files = get_files_by_extension(directory, extension)
for file in files:
    print(file)
```

**使用 pathlib 模块**
```python
from pathlib import Path

def get_files_by_extension(directory, extension):
    all_files = []
    for file in directory.rglob(f'*{extension}'):
        if file.is_file():
            all_files.append(file)
    return all_files

directory = Path('.')
extension = '.txt'
files = get_files_by_extension(directory, extension)
for file in files:
    print(file)
```

这两个示例都通过检查文件名的后缀来筛选出特定类型的文件。

## 最佳实践
### 性能优化
在处理大量文件时，性能是一个重要的考虑因素。`os.walk()` 和 `pathlib.Path.rglob()` 在遍历多层目录时性能可能较低，尤其是在文件数量非常多的情况下。可以考虑使用 `scandir()` 函数（`os` 模块在Python 3.5 及以上版本提供），它返回的是一个迭代器，性能更好。

```python
import os

def get_all_files(directory):
    all_files = []
    with os.scandir(directory) as it:
        for entry in it:
            if entry.is_file():
                all_files.append(entry.path)
            elif entry.is_dir():
                all_files.extend(get_all_files(entry.path))
    return all_files

directory = '.'
files = get_all_files(directory)
for file in files:
    print(file)
```

### 错误处理
在访问文件系统时，可能会遇到各种错误，如目录不存在、权限不足等。因此，进行适当的错误处理是非常必要的。

```python
import os
from pathlib import Path

def get_all_files(directory):
    try:
        if isinstance(directory, str):
            directory = Path(directory)
        all_files = []
        for file in directory.rglob('*'):
            if file.is_file():
                all_files.append(file)
        return all_files
    except FileNotFoundError:
        print(f"目录 {directory} 不存在")
    except PermissionError:
        print(f"没有访问目录 {directory} 的权限")

directory = '.'
files = get_all_files(directory)
if files:
    for file in files:
        print(file)
```

在上述代码中，使用 `try - except` 块捕获可能出现的 `FileNotFoundError` 和 `PermissionError` 异常，并进行相应的处理。

## 小结
本文详细介绍了使用Python获取目录下所有文件的方法，包括使用 `os` 模块和 `pathlib` 模块的基本操作。同时，探讨了常见的实践场景，如遍历多层目录和按文件类型筛选文件。在最佳实践部分，强调了性能优化和错误处理的重要性。通过掌握这些知识和技巧，读者能够更加高效地处理文件系统相关的任务，提高Python编程的能力。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html)