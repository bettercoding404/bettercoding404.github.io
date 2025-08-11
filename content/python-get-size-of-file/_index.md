---
title: "Python 获取文件大小：基础与实践"
description: "在Python编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理还是开发文件相关的工具，了解文件大小都非常重要。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理还是开发文件相关的工具，了解文件大小都非常重要。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os模块**
    - **pathlib模块**
    - **stat模块**
3. **常见实践**
    - **检查文件是否存在并获取大小**
    - **批量获取多个文件的大小**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
在计算机系统中，文件大小指的是文件所占用的磁盘空间大小。文件大小通常以字节（byte）为单位进行衡量，1字节等于8位（bit）。常见的文件大小单位还有千字节（KB）、兆字节（MB）、吉字节（GB）等，它们之间的换算关系为：1KB = 1024字节，1MB = 1024KB，1GB = 1024MB。

在Python中，获取文件大小就是通过特定的函数或方法来查询文件在磁盘上实际占用的字节数。

## 使用方法

### os模块
`os`模块是Python标准库中用于与操作系统进行交互的模块。要使用`os`模块获取文件大小，可以使用`os.path.getsize()`函数。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### pathlib模块
`pathlib`模块是Python 3.4 及以上版本引入的用于处理文件路径的模块，它提供了面向对象的方式来操作文件路径。使用`pathlib.Path`对象的`stat()`方法可以获取文件的状态信息，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### stat模块
`stat`模块用于解析`os.stat()`函数返回的文件状态信息。虽然可以直接使用`os.stat()`获取文件大小，但`stat`模块提供了一些常量来更方便地访问文件状态信息中的特定字段。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 常见实践

### 检查文件是否存在并获取大小
在获取文件大小之前，通常需要先检查文件是否存在，以避免出现文件不存在的错误。

```python
import os

file_path = 'example.txt'
if os.path.exists(file_path):
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 存在，大小是 {file_size} 字节")
else:
    print(f"文件 {file_path} 不存在")
```

### 批量获取多个文件的大小
在处理大量文件时，需要批量获取多个文件的大小。可以使用`os.walk()`函数遍历目录及其子目录，获取所有文件的路径，然后逐个获取文件大小。

```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 最佳实践

### 错误处理
在获取文件大小的过程中，可能会出现各种错误，如文件不存在、权限不足等。因此，需要进行适当的错误处理。

```python
import os

file_path = 'example.txt'
try:
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 的大小是 {file_size} 字节")
except FileNotFoundError:
    print(f"文件 {file_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件 {file_path}")
```

### 性能优化
在处理大量文件时，性能是一个重要的考虑因素。可以使用多线程或异步编程来提高获取文件大小的效率。以下是使用`concurrent.futures`模块进行多线程处理的示例：

```python
import os
import concurrent.futures

def get_file_size(file_path):
    try:
        return os.path.getsize(file_path)
    except FileNotFoundError:
        return None
    except PermissionError:
        return None

file_paths = ['file1.txt', 'file2.txt', 'file3.txt']  # 替换为实际的文件路径列表

with concurrent.futures.ThreadPoolExecutor() as executor:
    sizes = list(executor.map(get_file_size, file_paths))

for file_path, size in zip(file_paths, sizes):
    if size is not None:
        print(f"文件 {file_path} 的大小是 {size} 字节")
    else:
        print(f"获取文件 {file_path} 大小失败")
```

## 小结
本文详细介绍了在Python中获取文件大小的方法，包括使用`os`模块、`pathlib`模块和`stat`模块。同时，通过实际代码示例展示了常见实践，如检查文件存在性和批量获取文件大小。在最佳实践部分，强调了错误处理和性能优化的重要性。希望读者通过本文的学习，能够熟练掌握在Python中获取文件大小的技巧，并应用到实际项目中。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html)
- [Python官方文档 - stat模块](https://docs.python.org/3/library/stat.html)