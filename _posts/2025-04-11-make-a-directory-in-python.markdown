---
title: "在 Python 中创建目录"
description: "在 Python 编程中，操作文件和目录是一项常见任务。创建目录（也称为文件夹）是其中的基础操作之一。无论是组织项目文件、存储数据还是进行临时文件管理，能够熟练地在 Python 中创建目录都是非常有用的技能。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---

<!-- more -->

## 简介
在 Python 编程中，操作文件和目录是一项常见任务。创建目录（也称为文件夹）是其中的基础操作之一。无论是组织项目文件、存储数据还是进行临时文件管理，能够熟练地在 Python 中创建目录都是非常有用的技能。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os` 模块
    - 使用 `pathlib` 模块
3. 常见实践
    - 创建单层目录
    - 创建多层目录
    - 处理目录存在的情况
4. 最佳实践
    - 错误处理
    - 路径的跨平台处理
5. 小结
6. 参考资料

## 基础概念
在计算机文件系统中，目录是用于组织和存储文件的容器。每个目录都可以包含文件和其他子目录。在 Python 中，创建目录就是在文件系统中生成一个新的文件夹，以便后续可以在其中存储相关文件。

## 使用方法

### 使用 `os` 模块
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中包含了许多用于文件和目录操作的函数。要使用 `os` 模块创建目录，可以使用 `os.mkdir()` 函数。

示例代码：
```python
import os

# 创建一个名为 new_directory 的目录
directory_name = 'new_directory'
os.mkdir(directory_name)
```

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本中引入的用于处理文件路径的面向对象模块。它提供了一种更直观和面向对象的方式来处理文件和目录。要使用 `pathlib` 模块创建目录，可以使用 `Path.mkdir()` 方法。

示例代码：
```python
from pathlib import Path

# 创建一个名为 new_directory 的目录
directory_name = 'new_directory'
directory_path = Path(directory_name)
directory_path.mkdir()
```

## 常见实践

### 创建单层目录
上述使用 `os` 模块和 `pathlib` 模块的示例就是创建单层目录的基本方法。只需要指定目录名称，即可在当前工作目录下创建一个新的单层目录。

### 创建多层目录
有时候我们需要创建一个包含多层嵌套结构的目录。例如，我们要创建一个 `parent_directory`，其中包含 `sub_directory`，而 `sub_directory` 中又包含 `sub_sub_directory`。

使用 `os` 模块，可以使用 `os.makedirs()` 函数：
```python
import os

# 创建多层目录
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
sub_sub_directory ='sub_sub_directory'
full_path = os.path.join(parent_directory, sub_directory, sub_sub_directory)
os.makedirs(full_path)
```

使用 `pathlib` 模块，可以使用 `mkdir` 方法并设置 `parents=True` 参数：
```python
from pathlib import Path

# 创建多层目录
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
sub_sub_directory ='sub_sub_directory'
full_path = Path(parent_directory) / sub_directory / sub_sub_directory
full_path.mkdir(parents=True)
```

### 处理目录存在的情况
在创建目录时，如果目录已经存在，直接使用上述方法会导致错误。为了避免这种情况，我们需要先检查目录是否存在。

使用 `os` 模块：
```python
import os

directory_name = 'new_directory'
if not os.path.exists(directory_name):
    os.mkdir(directory_name)
```

使用 `pathlib` 模块：
```python
from pathlib import Path

directory_name = 'new_directory'
directory_path = Path(directory_name)
if not directory_path.exists():
    directory_path.mkdir()
```

## 最佳实践

### 错误处理
在创建目录时，可能会由于各种原因导致错误，例如权限不足、磁盘空间不足等。因此，最好进行适当的错误处理。

使用 `os` 模块：
```python
import os

directory_name = 'new_directory'
try:
    os.mkdir(directory_name)
except OSError as e:
    print(f"创建目录失败: {e}")
```

使用 `pathlib` 模块：
```python
from pathlib import Path

directory_name = 'new_directory'
directory_path = Path(directory_name)
try:
    directory_path.mkdir()
except OSError as e:
    print(f"创建目录失败: {e}")
```

### 路径的跨平台处理
不同的操作系统（如 Windows、Linux 和 macOS）使用不同的路径分隔符。为了确保代码在不同平台上都能正常工作，可以使用 `os.path.join()` 函数（对于 `os` 模块）或 `Path` 类的 `/` 运算符（对于 `pathlib` 模块）来构建路径。

例如，在使用 `os` 模块创建多层目录时：
```python
import os

# 在不同平台上都能正确构建路径
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
sub_sub_directory ='sub_sub_directory'
full_path = os.path.join(parent_directory, sub_directory, sub_sub_directory)
try:
    os.makedirs(full_path)
except OSError as e:
    print(f"创建目录失败: {e}")
```

使用 `pathlib` 模块时：
```python
from pathlib import Path

# 在不同平台上都能正确构建路径
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
sub_sub_directory ='sub_sub_directory'
full_path = Path(parent_directory) / sub_directory / sub_sub_directory
try:
    full_path.mkdir(parents=True)
except OSError as e:
    print(f"创建目录失败: {e}")
```

## 小结
在 Python 中创建目录有多种方法，`os` 模块和 `pathlib` 模块都提供了方便的函数和方法来完成这项任务。`os` 模块是 Python 标准库中较为传统的与操作系统交互的模块，而 `pathlib` 模块则提供了更面向对象和直观的方式。在实际应用中，我们需要根据具体需求选择合适的方法，并注意处理目录存在的情况、进行错误处理以及确保路径的跨平台兼容性。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}