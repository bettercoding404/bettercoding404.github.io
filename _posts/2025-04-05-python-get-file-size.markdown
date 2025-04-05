---
title: "Python 获取文件大小：全面解析与实践"
description: "在Python编程中，获取文件大小是一项常见且重要的操作。无论是进行数据处理、磁盘空间管理，还是对文件进行评估和分析，了解文件的大小都能为我们提供有价值的信息。本文将深入探讨在Python中获取文件大小的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一实用技能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，获取文件大小是一项常见且重要的操作。无论是进行数据处理、磁盘空间管理，还是对文件进行评估和分析，了解文件的大小都能为我们提供有价值的信息。本文将深入探讨在Python中获取文件大小的基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者全面掌握这一实用技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - os 模块
    - pathlib 模块
    - stat 模块
3. 常见实践
    - 批量获取文件大小
    - 处理大文件时的优化
4. 最佳实践
    - 错误处理
    - 代码可读性与维护性
5. 小结
6. 参考资料

## 基础概念
文件大小是指文件在存储介质上所占用的字节数。在计算机系统中，文件的大小直接反映了其占用的磁盘空间量。在Python中，获取文件大小就是通过特定的函数或方法来查询并返回这个字节数的过程。这一操作对于许多程序逻辑的实现至关重要，比如判断文件是否符合特定的大小要求、计算磁盘使用率等。

## 使用方法
### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块，其中包含了获取文件大小的函数。

```python
import os


def get_file_size_os(path):
    if os.path.isfile(path):
        return os.path.getsize(path)
    else:
        return None


file_path = 'test.txt'
size = get_file_size_os(file_path)
if size:
    print(f"文件 {file_path} 的大小是 {size} 字节")
else:
    print(f"{file_path} 不是一个有效的文件路径")
```

在上述代码中：
1. 使用 `os.path.isfile` 函数检查给定路径是否指向一个文件。
2. 如果是文件，使用 `os.path.getsize` 函数获取文件大小，并返回大小值。
3. 如果路径不是文件，则返回 `None`。

### pathlib 模块
`pathlib` 模块提供了一种面向对象的方式来处理文件路径，同时也能获取文件大小。

```python
from pathlib import Path


def get_file_size_pathlib(path):
    p = Path(path)
    if p.is_file():
        return p.stat().st_size
    else:
        return None


file_path = 'test.txt'
size = get_file_size_pathlib(file_path)
if size:
    print(f"文件 {file_path} 的大小是 {size} 字节")
else:
    print(f"{file_path} 不是一个有效的文件路径")
```

代码解释：
1. 使用 `Path` 类将路径转换为 `Path` 对象。
2. 通过 `is_file` 方法检查路径是否为文件。
3. 如果是文件，使用 `stat` 方法获取文件的状态信息，其中 `st_size` 属性表示文件大小。

### stat 模块
`stat` 模块用于获取文件的状态信息，也可以用来获取文件大小。

```python
import os
import stat


def get_file_size_stat(path):
    if os.path.isfile(path):
        file_stat = os.stat(path)
        return file_stat[stat.ST_SIZE]
    else:
        return None


file_path = 'test.txt'
size = get_file_size_stat(file_path)
if size:
    print(f"文件 {file_path} 的大小是 {size} 字节")
else:
    print(f"{file_path} 不是一个有效的文件路径")
```

这里：
1. 同样先使用 `os.path.isfile` 检查路径是否为文件。
2. 然后使用 `os.stat` 获取文件的状态信息，通过索引 `stat.ST_SIZE` 来获取文件大小。

## 常见实践
### 批量获取文件大小
在处理大量文件时，我们通常需要批量获取它们的大小。以下是使用 `os` 模块遍历目录并获取所有文件大小的示例：

```python
import os


def get_files_size_in_dir(dir_path):
    file_sizes = {}
    if os.path.isdir(dir_path):
        for root, dirs, files in os.walk(dir_path):
            for file in files:
                file_path = os.path.join(root, file)
                file_sizes[file_path] = os.path.getsize(file_path)
    return file_sizes


directory = '.'
file_sizes = get_files_size_in_dir(directory)
for file, size in file_sizes.items():
    print(f"文件 {file} 的大小是 {size} 字节")
```

### 处理大文件时的优化
对于非常大的文件，直接获取文件大小可能会消耗较多资源。在这种情况下，可以使用 `os.stat` 结合缓冲区的方式来提高效率。以下是一个简单的示例：

```python
import os


def get_large_file_size(path):
    if os.path.isfile(path):
        st = os.stat(path)
        return st.st_size
    else:
        return None


large_file_path = 'large_file.txt'
size = get_large_file_size(large_file_path)
if size:
    print(f"文件 {large_file_path} 的大小是 {size} 字节")
else:
    print(f"{large_file_path} 不是一个有效的文件路径")
```

## 最佳实践
### 错误处理
在获取文件大小的过程中，可能会遇到各种错误，如文件不存在、权限不足等。因此，在代码中进行适当的错误处理是非常重要的。

```python
import os


def get_file_size_with_error_handling(path):
    try:
        if os.path.isfile(path):
            return os.path.getsize(path)
        else:
            raise FileNotFoundError(f"{path} 不是一个有效的文件路径")
    except PermissionError:
        print(f"没有权限访问 {path}")
        return None
    except Exception as e:
        print(f"获取文件大小失败: {e}")
        return None


file_path = 'test.txt'
size = get_file_size_with_error_handling(file_path)
if size:
    print(f"文件 {file_path} 的大小是 {size} 字节")
```

### 代码可读性与维护性
为了提高代码的可读性和维护性，建议将获取文件大小的功能封装成独立的函数，并添加适当的注释。

```python
import os


def get_file_size(path):
    """
    获取指定路径文件的大小。

    :param path: 文件路径
    :return: 文件大小（字节），如果路径无效或发生错误则返回 None
    """
    try:
        if os.path.isfile(path):
            return os.path.getsize(path)
        else:
            return None
    except Exception as e:
        print(f"获取文件大小失败: {e}")
        return None


file_path = 'test.txt'
size = get_file_size(file_path)
if size:
    print(f"文件 {file_path} 的大小是 {size} 字节")
```

## 小结
在Python中获取文件大小有多种方法，`os` 模块、`pathlib` 模块和 `stat` 模块都提供了相应的功能。在实际应用中，我们需要根据具体的需求和场景选择合适的方法。同时，注意错误处理和代码的可读性与维护性，能使我们的程序更加健壮和易于管理。通过掌握这些知识和技巧，读者可以在处理文件相关的任务时更加得心应手。

## 参考资料
- 《Python核心编程》