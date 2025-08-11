---
title: "在 Python 中创建目录"
description: "在 Python 编程中，处理文件和目录是一项常见的任务。创建目录（make directory）是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是构建复杂的文件系统结构，掌握在 Python 中创建目录的方法都非常关键。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地在实际项目中运用这一功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---

<!-- more -->

## 简介
在 Python 编程中，处理文件和目录是一项常见的任务。创建目录（make directory）是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是构建复杂的文件系统结构，掌握在 Python 中创建目录的方法都非常关键。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地在实际项目中运用这一功能。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os` 模块创建目录
    - 使用 `pathlib` 模块创建目录
3. 常见实践
    - 创建单层目录
    - 创建多层目录
    - 检查目录是否存在再创建
4. 最佳实践
    - 错误处理
    - 与项目结构的结合
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织和管理文件的容器。在 Python 中，创建目录就是在文件系统中生成一个新的文件夹，以便后续可以在其中存储文件或创建更多子目录。Python 提供了不同的模块和方法来实现这一操作，主要涉及 `os` 模块和 `pathlib` 模块。

## 使用方法

### 使用 `os` 模块创建目录
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中包含了许多操作文件和目录的函数。要使用 `os` 模块创建目录，可以使用 `os.mkdir()` 函数。

```python
import os

# 创建一个名为 new_directory 的单层目录
directory_name = 'new_directory'
os.mkdir(directory_name)
```

### 使用 `pathlib` 模块创建目录
`pathlib` 模块是 Python 3.4 及以上版本中引入的，它提供了一种面向对象的方式来处理文件路径。使用 `pathlib` 模块创建目录可以使用 `Path.mkdir()` 方法。

```python
from pathlib import Path

# 创建一个名为 new_directory 的单层目录
directory_name = 'new_directory'
Path(directory_name).mkdir()
```

## 常见实践

### 创建单层目录
上述代码示例展示了创建单层目录的基本方法。无论是使用 `os` 模块还是 `pathlib` 模块，都只需要指定要创建的目录名称即可。

### 创建多层目录
在实际应用中，有时需要创建包含多层嵌套的目录结构。

使用 `os` 模块时，可以使用 `os.makedirs()` 函数。

```python
import os

# 创建多层目录，例如 parent/child/grandchild
nested_directory = 'parent/child/grandchild'
os.makedirs(nested_directory)
```

使用 `pathlib` 模块时，可以在调用 `mkdir()` 方法时传递 `parents=True` 参数。

```python
from pathlib import Path

# 创建多层目录，例如 parent/child/grandchild
nested_directory = 'parent/child/grandchild'
Path(nested_directory).mkdir(parents=True)
```

### 检查目录是否存在再创建
在创建目录之前，先检查该目录是否已经存在是一个良好的实践，这样可以避免因目录已存在而导致的错误。

使用 `os` 模块时，可以结合 `os.path.exists()` 函数。

```python
import os

directory_name = 'new_directory'
if not os.path.exists(directory_name):
    os.mkdir(directory_name)
```

使用 `pathlib` 模块时，可以使用 `Path.exists()` 方法。

```python
from pathlib import Path

directory_name = 'new_directory'
if not Path(directory_name).exists():
    Path(directory_name).mkdir()
```

## 最佳实践

### 错误处理
在创建目录时，可能会遇到各种错误，例如权限不足、磁盘空间不足等。因此，进行适当的错误处理是很重要的。

使用 `os` 模块时，可以使用 `try - except` 语句捕获异常。

```python
import os

directory_name = 'new_directory'
try:
    os.mkdir(directory_name)
except OSError as e:
    print(f"创建目录失败: {e}")
```

使用 `pathlib` 模块时，同样可以使用 `try - except` 语句。

```python
from pathlib import Path

directory_name = 'new_directory'
try:
    Path(directory_name).mkdir()
except OSError as e:
    print(f"创建目录失败: {e}")
```

### 与项目结构的结合
在实际项目中，目录的创建应该与项目的整体结构相匹配。例如，在一个数据处理项目中，可以创建专门用于存储原始数据、处理后数据以及日志文件的目录。

```python
from pathlib import Path

project_dir = Path('my_project')
data_dir = project_dir / 'data'
raw_data_dir = data_dir / 'raw'
processed_data_dir = data_dir / 'processed'
log_dir = project_dir / 'logs'

for dir_path in [project_dir, data_dir, raw_data_dir, processed_data_dir, log_dir]:
    if not dir_path.exists():
        dir_path.mkdir(parents=True)
```

## 小结
本文详细介绍了在 Python 中创建目录的相关知识，包括使用 `os` 模块和 `pathlib` 模块的方法，以及常见实践和最佳实践。通过掌握这些内容，读者可以更加灵活和可靠地在 Python 项目中处理文件目录操作，提高代码的健壮性和可读性。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/zh-cn/3/library/os.html)
- [Python 官方文档 - pathlib 模块](https://docs.python.org/zh-cn/3/library/pathlib.html)