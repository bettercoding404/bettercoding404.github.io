---
title: "Python 创建文件夹：基础与实践"
description: "在Python编程中，创建文件夹是一项常见且实用的操作。无论是用于整理项目文件、存储数据，还是为自动化脚本创建工作目录，掌握如何使用Python创建文件夹都是必不可少的技能。本文将详细介绍Python创建文件夹的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面了解并熟练运用这一功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在Python编程中，创建文件夹是一项常见且实用的操作。无论是用于整理项目文件、存储数据，还是为自动化脚本创建工作目录，掌握如何使用Python创建文件夹都是必不可少的技能。本文将详细介绍Python创建文件夹的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面了解并熟练运用这一功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `os` 模块创建文件夹**
    - **使用 `pathlib` 模块创建文件夹**
3. **常见实践**
    - **为项目创建特定目录结构**
    - **根据日期创建文件夹**
4. **最佳实践**
    - **错误处理**
    - **确保路径的跨平台兼容性**
5. **小结**
6. **参考资料**

## 基础概念
在操作系统中，文件夹（也称为目录）是用于组织和存储文件的容器。Python提供了不同的模块和方法来与操作系统进行交互，从而实现创建文件夹的操作。主要涉及到的模块有 `os` 和 `pathlib`。`os` 模块是Python标准库中用于与操作系统进行交互的核心模块之一，它提供了许多函数来处理文件和目录。`pathlib` 模块是Python 3.4 及以上版本引入的面向对象的文件路径处理模块，它提供了一种更直观、更面向对象的方式来处理文件路径。

## 使用方法

### 使用 `os` 模块创建文件夹
`os` 模块中的 `mkdir()` 函数可以用来创建单个文件夹。以下是基本的代码示例：

```python
import os

# 创建单个文件夹
folder_name = "new_folder"
os.mkdir(folder_name)
```

上述代码首先导入了 `os` 模块，然后定义了要创建的文件夹名称 `new_folder`，最后使用 `os.mkdir()` 函数创建了该文件夹。

如果要创建多级目录（即包含子目录的目录结构），可以使用 `os.makedirs()` 函数。例如：

```python
import os

# 创建多级目录
sub_folder_path = "parent_folder/child_folder"
os.makedirs(sub_folder_path)
```

这段代码创建了一个包含子文件夹的目录结构，`parent_folder` 是父文件夹，`child_folder` 是子文件夹。

### 使用 `pathlib` 模块创建文件夹
`pathlib` 模块提供了更简洁、面向对象的方式来创建文件夹。首先，需要导入 `Path` 类。以下是创建单个文件夹的示例：

```python
from pathlib import Path

# 创建单个文件夹
folder_name = "new_folder"
folder_path = Path(folder_name)
folder_path.mkdir()
```

创建多级目录同样很简单：

```python
from pathlib import Path

# 创建多级目录
sub_folder_path = Path("parent_folder/child_folder")
sub_folder_path.mkdir(parents=True)
```

在上述代码中，`parents=True` 参数告诉 `mkdir()` 方法，如果父目录不存在，则创建所有必要的父目录。

## 常见实践

### 为项目创建特定目录结构
在开发项目时，通常需要创建特定的目录结构来组织代码、数据和文档等。例如，一个典型的Python项目目录结构可能如下：

```
project/
├── src/
│   ├── __init__.py
│   ├── module1.py
│   └── module2.py
├── data/
│   ├── raw/
│   └── processed/
├── docs/
└── tests/
```

可以使用Python脚本来自动创建这个目录结构：

```python
import os

project_dir = "project"
src_dir = os.path.join(project_dir, "src")
data_dir = os.path.join(project_dir, "data")
raw_data_dir = os.path.join(data_dir, "raw")
processed_data_dir = os.path.join(data_dir, "processed")
docs_dir = os.path.join(project_dir, "docs")
tests_dir = os.path.join(project_dir, "tests")

os.makedirs(src_dir)
os.makedirs(raw_data_dir)
os.makedirs(processed_data_dir)
os.makedirs(docs_dir)
os.makedirs(tests_dir)
```

### 根据日期创建文件夹
在处理日志文件或数据备份时，根据日期创建文件夹可以方便地组织和管理文件。以下是一个示例：

```python
import os
from datetime import datetime

# 获取当前日期
today = datetime.now().strftime("%Y-%m-%d")

# 创建以当前日期命名的文件夹
folder_name = f"backup_{today}"
os.mkdir(folder_name)
```

这段代码获取当前日期，并以日期命名创建了一个文件夹。

## 最佳实践

### 错误处理
在创建文件夹时，可能会遇到各种错误，例如文件夹已存在、权限不足等。因此，进行适当的错误处理是很重要的。

使用 `os` 模块时，可以通过捕获异常来处理错误：

```python
import os

folder_name = "new_folder"
try:
    os.mkdir(folder_name)
except FileExistsError:
    print(f"文件夹 {folder_name} 已存在")
except PermissionError:
    print(f"没有权限创建文件夹 {folder_name}")
```

使用 `pathlib` 模块时，同样可以捕获异常：

```python
from pathlib import Path

folder_name = "new_folder"
folder_path = Path(folder_name)
try:
    folder_path.mkdir()
except FileExistsError:
    print(f"文件夹 {folder_name} 已存在")
except PermissionError:
    print(f"没有权限创建文件夹 {folder_name}")
```

### 确保路径的跨平台兼容性
不同的操作系统使用不同的路径分隔符（Windows使用 `\`，Unix-like系统使用 `/`）。为了确保代码在不同操作系统上都能正常工作，可以使用 `os.path.join()` 函数（在 `os` 模块中）或 `Path` 类（在 `pathlib` 模块中）。

使用 `os.path.join()`：

```python
import os

parent_dir = "parent"
child_dir = "child"
folder_path = os.path.join(parent_dir, child_dir)
os.makedirs(folder_path)
```

使用 `pathlib`：

```python
from pathlib import Path

parent_dir = "parent"
child_dir = "child"
folder_path = Path(parent_dir) / child_dir
folder_path.mkdir(parents=True)
```

## 小结
本文详细介绍了Python中创建文件夹的相关知识，包括基础概念、使用 `os` 模块和 `pathlib` 模块的不同方法、常见的实践场景以及最佳实践建议。通过掌握这些内容，读者可以在Python编程中更加高效、可靠地创建和管理文件夹，为项目开发和数据处理提供便利。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html)