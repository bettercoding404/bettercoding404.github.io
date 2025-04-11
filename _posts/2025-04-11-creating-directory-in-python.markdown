---
title: "在 Python 中创建目录"
description: "在 Python 编程中，处理文件和目录是一项常见的任务。创建目录是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是管理用户生成的内容，了解如何在 Python 中创建目录都至关重要。本文将深入探讨在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---

<!-- more -->

## 简介
在 Python 编程中，处理文件和目录是一项常见的任务。创建目录是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是管理用户生成的内容，了解如何在 Python 中创建目录都至关重要。本文将深入探讨在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一技能。

## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `os` 模块
    - 使用 `pathlib` 模块
3. **常见实践**
    - 创建单个目录
    - 创建多级目录
4. **最佳实践**
    - 错误处理
    - 跨平台兼容性
5. **小结**
6. **参考资料**

## 基础概念
在计算机文件系统中，目录（也称为文件夹）是用于组织和存储文件的容器。每个目录可以包含文件和其他子目录，形成一个层次结构。在 Python 中，创建目录意味着在操作系统的文件系统中生成一个新的目录对象，你可以在其中存储文件或进一步创建子目录。

## 使用方法

### 使用 `os` 模块
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中包含了许多用于处理文件和目录的函数。

**创建单个目录**
```python
import os

# 创建单个目录
directory_name = 'new_directory'
parent_directory = '.'  # 当前目录
path = os.path.join(parent_directory, directory_name)

try:
    os.mkdir(path)
    print(f"目录 {directory_name} 创建成功。")
except FileExistsError:
    print(f"目录 {directory_name} 已存在。")
```

在上述代码中：
1. 首先导入 `os` 模块。
2. 定义要创建的目录名称 `directory_name` 和父目录 `parent_directory`（这里使用当前目录 `.`）。
3. 使用 `os.path.join` 函数将父目录和目录名称组合成完整的路径 `path`。
4. 尝试使用 `os.mkdir` 函数创建目录，如果目录已存在，则捕获 `FileExistsError` 异常并打印相应信息。

**创建多级目录**
```python
import os

# 创建多级目录
sub_directory_name = 'level1/level2/level3'
parent_directory = '.'
path = os.path.join(parent_directory, sub_directory_name)

try:
    os.makedirs(path)
    print(f"多级目录 {sub_directory_name} 创建成功。")
except FileExistsError:
    print(f"多级目录 {sub_directory_name} 已存在。")
```

`os.makedirs` 函数用于创建多级目录，即如果父目录不存在，它会自动创建所有必要的父目录。

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本引入的面向对象的文件路径处理模块，提供了更直观和面向对象的方式来处理文件和目录。

**创建单个目录**
```python
from pathlib import Path

# 创建单个目录
directory_name = 'new_directory'
parent_directory = Path('.')
path = parent_directory / directory_name

try:
    path.mkdir()
    print(f"目录 {directory_name} 创建成功。")
except FileExistsError:
    print(f"目录 {directory_name} 已存在。")
```

在这段代码中：
1. 从 `pathlib` 模块导入 `Path` 类。
2. 创建 `parent_directory` 对象（这里是当前目录），并使用 `/` 运算符将其与目录名称组合成 `path` 对象。
3. 调用 `path.mkdir()` 方法创建目录，同样捕获 `FileExistsError` 异常。

**创建多级目录**
```python
from pathlib import Path

# 创建多级目录
sub_directory_name = 'level1/level2/level3'
parent_directory = Path('.')
path = parent_directory / sub_directory_name

try:
    path.mkdir(parents=True)
    print(f"多级目录 {sub_directory_name} 创建成功。")
except FileExistsError:
    print(f"多级目录 {sub_directory_name} 已存在。")
```

`path.mkdir(parents=True)` 表示如果父目录不存在，自动创建所有必要的父目录。

## 常见实践

### 创建单个目录
在许多情况下，你可能只需要在某个特定位置创建一个简单的目录。例如，在项目根目录下创建一个用于存储日志文件的目录：
```python
import os

log_directory = 'logs'
project_root = '.'
log_path = os.path.join(project_root, log_directory)

try:
    os.mkdir(log_path)
    print(f"日志目录 {log_directory} 创建成功。")
except FileExistsError:
    print(f"日志目录 {log_directory} 已存在。")
```

### 创建多级目录
当你需要组织复杂的文件结构时，创建多级目录就非常有用。比如一个数据处理项目，可能需要按照数据来源、处理阶段等创建多级目录结构：
```python
from pathlib import Path

data_directory = 'data/source1/processed'
project_root = Path('.')
data_path = project_root / data_directory

try:
    data_path.mkdir(parents=True)
    print(f"数据目录 {data_directory} 创建成功。")
except FileExistsError:
    print(f"数据目录 {data_directory} 已存在。")
```

## 最佳实践

### 错误处理
在创建目录时，始终要进行错误处理。除了 `FileExistsError`，还可能遇到权限问题（`PermissionError`）等。例如：
```python
import os

directory_name = 'new_directory'
parent_directory = '.'
path = os.path.join(parent_directory, directory_name)

try:
    os.mkdir(path)
    print(f"目录 {directory_name} 创建成功。")
except FileExistsError:
    print(f"目录 {directory_name} 已存在。")
except PermissionError as e:
    print(f"权限不足，无法创建目录: {e}")
except Exception as e:
    print(f"创建目录时发生其他错误: {e}")
```

### 跨平台兼容性
不同的操作系统（如 Windows、Linux 和 macOS）在文件路径表示和目录操作上可能存在差异。使用 `os.path.join`（对于 `os` 模块）和 `Path` 类（对于 `pathlib` 模块）可以确保代码在不同平台上都能正确运行。例如：
```python
from pathlib import Path

# 适用于所有平台
directory_name = 'new_directory'
parent_directory = Path('.')
path = parent_directory / directory_name

try:
    path.mkdir()
    print(f"目录 {directory_name} 创建成功。")
except FileExistsError:
    print(f"目录 {directory_name} 已存在。")
```

## 小结
在 Python 中创建目录是一项基本操作，`os` 模块和 `pathlib` 模块都提供了强大的功能来实现这一任务。`os` 模块是标准库中较老的模块，功能丰富，适用于各种 Python 版本；`pathlib` 模块则提供了更面向对象和直观的方式，在 Python 3.4 及以上版本推荐使用。在实际编程中，要注意错误处理以确保程序的健壮性，并使用跨平台兼容的方法来提高代码的可移植性。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}