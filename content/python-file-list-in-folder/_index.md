---
title: "探索Python中获取文件夹内文件列表的方法"
description: "在Python编程中，经常会遇到需要获取指定文件夹内文件列表的情况。无论是进行文件批量处理、数据整理，还是简单的文件目录查看，掌握如何列出文件夹中的文件都是一项基础且实用的技能。本文将深入探讨在Python中获取文件夹内文件列表的相关概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一功能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，经常会遇到需要获取指定文件夹内文件列表的情况。无论是进行文件批量处理、数据整理，还是简单的文件目录查看，掌握如何列出文件夹中的文件都是一项基础且实用的技能。本文将深入探讨在Python中获取文件夹内文件列表的相关概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.walk()`
    - 使用`pathlib`模块
3. 常见实践
    - 遍历特定类型文件
    - 获取文件完整路径
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在Python中，获取文件夹内文件列表本质上是对操作系统文件系统的一种操作。不同的操作系统（如Windows、Linux、macOS）对文件和目录的管理方式略有不同，但Python提供了跨平台的方法来处理这些操作。理解文件路径的表示方式（绝对路径和相对路径）以及文件和目录的区别是掌握这一功能的基础。

## 使用方法

### 使用`os.listdir()`
`os.listdir()` 是Python标准库 `os` 模块中的一个函数，用于返回指定目录中的文件和目录名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

### 使用`os.walk()`
`os.walk()` 可以递归地遍历目录树，返回一个三元组 `(dirpath, dirnames, filenames)`，其中 `dirpath` 是当前目录路径，`dirnames` 是当前目录下的子目录列表，`filenames` 是当前目录下的文件列表。

```python
import os

folder_path = '.'  # 当前目录
for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

### 使用`pathlib`模块
`pathlib` 是Python 3.4 及以上版本引入的标准库模块，提供了面向对象的文件路径操作方式。

```python
from pathlib import Path

folder_path = Path('.')  # 当前目录
file_list = [file for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

## 常见实践

### 遍历特定类型文件
在实际应用中，常常需要遍历特定类型的文件，比如只获取 `.txt` 文件。

```python
import os

folder_path = '.'  # 当前目录
for file in os.listdir(folder_path):
    if file.endswith('.txt'):
        print(file)
```

### 获取文件完整路径
有时需要获取文件的完整路径，而不仅仅是文件名。

```python
import os

folder_path = '.'  # 当前目录
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_path = os.path.join(root, file)
        print(file_path)
```

## 最佳实践

### 错误处理
在获取文件列表时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，进行适当的错误处理是很有必要的。

```python
import os

folder_path = 'nonexistent_folder'
try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}。")
```

### 性能优化
如果文件夹中文件数量较多，使用 `os.walk()` 时可以通过适当的条件判断来减少不必要的遍历，提高性能。

```python
import os

folder_path = '.'
max_depth = 2  # 最大遍历深度

def walk_with_depth(folder, depth=0):
    if depth > max_depth:
        return
    for root, dirs, files in os.walk(folder):
        for file in files:
            print(os.path.join(root, file))
        for sub_dir in dirs:
            walk_with_depth(os.path.join(root, sub_dir), depth + 1)

walk_with_depth(folder_path)
```

## 小结
本文详细介绍了在Python中获取文件夹内文件列表的多种方法，包括 `os.listdir()`、`os.walk()` 和 `pathlib` 模块的使用。同时，探讨了常见实践场景以及最佳实践，如遍历特定类型文件、获取完整路径、错误处理和性能优化等。通过掌握这些知识，读者能够更加灵活、高效地处理文件列表相关的任务，为实际项目开发提供有力支持。

## 参考资料
- 《Python Cookbook》