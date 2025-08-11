---
title: "在Python中从目录中选择文件或目录：深入解析与实践"
description: "在Python编程中，处理文件系统是一项常见的任务。从目录中选择特定的文件或目录是许多实际应用场景的基础，比如数据处理、文件管理、自动化脚本等。本文将详细介绍如何在Python中从目录中进行选择操作，涵盖基础概念、多种使用方法、常见实践案例以及最佳实践建议，帮助读者全面掌握这一重要的技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---

<!-- more -->

## 简介
在Python编程中，处理文件系统是一项常见的任务。从目录中选择特定的文件或目录是许多实际应用场景的基础，比如数据处理、文件管理、自动化脚本等。本文将详细介绍如何在Python中从目录中进行选择操作，涵盖基础概念、多种使用方法、常见实践案例以及最佳实践建议，帮助读者全面掌握这一重要的技能。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os`模块
    - 使用`pathlib`模块
    - 使用`glob`模块
3. 常见实践
    - 选择特定类型的文件
    - 递归选择文件
    - 选择目录
4. 最佳实践
    - 代码可读性与可维护性
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在Python中，从目录中选择文件或目录，意味着根据特定的条件（如文件名模式、文件类型、文件大小等）从给定的目录及其子目录中筛选出符合要求的文件或目录。这需要我们了解Python中处理文件系统的相关模块和函数。主要涉及到`os`模块（提供了许多与操作系统交互的函数）、`pathlib`模块（面向对象的文件路径处理模块）以及`glob`模块（用于文件路径名模式匹配）。

## 使用方法

### 使用`os`模块
`os`模块是Python标准库中用于与操作系统进行交互的模块。以下是使用`os`模块从目录中选择文件的示例：

```python
import os

def select_files_os(dir_path):
    selected_files = []
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            file_path = os.path.join(root, file)
            selected_files.append(file_path)
    return selected_files

directory = '.'
result = select_files_os(directory)
for file in result:
    print(file)
```

### 使用`pathlib`模块
`pathlib`模块提供了更面向对象的方式来处理文件路径。

```python
from pathlib import Path

def select_files_pathlib(dir_path):
    p = Path(dir_path)
    selected_files = []
    for file in p.rglob('*'):
        if file.is_file():
            selected_files.append(str(file))
    return selected_files

directory = '.'
result = select_files_pathlib(directory)
for file in result:
    print(file)
```

### 使用`glob`模块
`glob`模块用于文件路径名模式匹配。

```python
import glob

def select_files_glob(dir_path):
    file_pattern = os.path.join(dir_path, '**', '*')
    selected_files = glob.glob(file_pattern, recursive=True)
    return selected_files

directory = '.'
result = select_files_glob(directory)
for file in result:
    print(file)
```

## 常见实践

### 选择特定类型的文件
假设我们要选择目录下所有的`.txt`文件。

使用`os`模块：

```python
import os

def select_txt_files_os(dir_path):
    selected_files = []
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            if file.endswith('.txt'):
                file_path = os.path.join(root, file)
                selected_files.append(file_path)
    return selected_files

directory = '.'
result = select_txt_files_os(directory)
for file in result:
    print(file)
```

使用`pathlib`模块：

```python
from pathlib import Path

def select_txt_files_pathlib(dir_path):
    p = Path(dir_path)
    selected_files = []
    for file in p.rglob('*.txt'):
        if file.is_file():
            selected_files.append(str(file))
    return selected_files

directory = '.'
result = select_txt_files_pathlib(directory)
for file in result:
    print(file)
```

使用`glob`模块：

```python
import glob

def select_txt_files_glob(dir_path):
    file_pattern = os.path.join(dir_path, '**', '*.txt')
    selected_files = glob.glob(file_pattern, recursive=True)
    return selected_files

directory = '.'
result = select_txt_files_glob(directory)
for file in result:
    print(file)
```

### 递归选择文件
上述代码中通过`os.walk`、`p.rglob`以及`glob.glob`的`recursive=True`参数已经实现了递归选择文件的功能。

### 选择目录
使用`os`模块选择目录：

```python
import os

def select_dirs_os(dir_path):
    selected_dirs = []
    for root, dirs, files in os.walk(dir_path):
        for dir in dirs:
            dir_path = os.path.join(root, dir)
            selected_dirs.append(dir_path)
    return selected_dirs

directory = '.'
result = select_dirs_os(directory)
for dir in result:
    print(dir)
```

使用`pathlib`模块选择目录：

```python
from pathlib import Path

def select_dirs_pathlib(dir_path):
    p = Path(dir_path)
    selected_dirs = []
    for dir in p.rglob('*'):
        if dir.is_dir():
            selected_dirs.append(str(dir))
    return selected_dirs

directory = '.'
result = select_dirs_pathlib(directory)
for dir in result:
    print(dir)
```

## 最佳实践

### 代码可读性与可维护性
尽量使用`pathlib`模块，因为其面向对象的设计使得代码更易读和维护。同时，将选择文件或目录的逻辑封装在函数中，提高代码的模块化。

### 错误处理
在处理文件系统操作时，要注意捕获可能的异常，如目录不存在、权限不足等。例如：

```python
from pathlib import Path

def select_files_pathlib_safe(dir_path):
    try:
        p = Path(dir_path)
        if not p.exists():
            raise FileNotFoundError(f"目录 {dir_path} 不存在")
        selected_files = []
        for file in p.rglob('*'):
            if file.is_file():
                selected_files.append(str(file))
        return selected_files
    except PermissionError as e:
        print(f"权限不足: {e}")
        return []
    except Exception as e:
        print(f"发生错误: {e}")
        return []

directory = '.'
result = select_files_pathlib_safe(directory)
for file in result:
    print(file)
```

### 性能优化
如果处理的目录非常大，要注意性能问题。例如，`os.walk`在遍历深层目录时可能效率较低，此时可以考虑使用`pathlib`模块的`rglob`方法，它在某些情况下性能更好。另外，尽量减少不必要的文件操作，如打开和关闭文件。

## 小结
本文详细介绍了在Python中从目录中选择文件或目录的方法，涵盖了`os`模块、`pathlib`模块和`glob`模块的使用。通过常见实践案例展示了如何选择特定类型的文件、递归选择文件以及选择目录。同时，提供了最佳实践建议，包括提高代码可读性与可维护性、错误处理和性能优化。希望读者通过本文的学习，能够在实际项目中高效、准确地处理文件系统选择操作。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html)
- [Python官方文档 - glob模块](https://docs.python.org/3/library/glob.html)