---
title: "Python 获取文件大小：全面解析与实践"
description: "在Python编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理还是系统监控，了解文件的大小信息都至关重要。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者熟练掌握这一重要技能。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在Python编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理还是系统监控，了解文件的大小信息都至关重要。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议，帮助读者熟练掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **批量获取文件大小**
    - **在特定目录下查找大文件**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
文件大小是指文件在存储设备上占用的字节数。在计算机系统中，文件大小的表示单位有字节（Byte）、千字节（KB）、兆字节（MB）、吉字节（GB）等。在Python中，获取文件大小就是通过特定的函数或方法，获取文件所占用的字节数，以便进行后续的分析和处理。

## 使用方法

### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块，其中 `os.path.getsize()` 函数可以用来获取文件的大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### pathlib 模块
`pathlib` 模块提供了一种面向对象的方式来处理文件路径。`Path.stat()` 方法可以获取文件的状态信息，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### stat 模块
`stat` 模块用于解析 `os.stat()` 返回的结果。虽然它通常与 `os` 模块一起使用，但也可以单独用于获取文件大小。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 常见实践

### 批量获取文件大小
在实际应用中，常常需要获取一个目录下所有文件的大小。可以结合 `os.walk()` 函数遍历目录，然后使用 `os.path.getsize()` 获取每个文件的大小。

```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### 在特定目录下查找大文件
可以通过获取文件大小，筛选出特定目录下的大文件。

```python
import os

directory = '.'
threshold = 1024 * 1024  # 1MB
for root, dirs, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        if file_size > threshold:
            print(f"大文件 {file_path} 的大小是 {file_size} 字节")
```

## 最佳实践

### 性能优化
如果需要获取大量文件的大小，为了提高性能，可以考虑使用多线程或异步编程。例如，使用 `concurrent.futures` 模块中的 `ThreadPoolExecutor` 进行多线程处理。

```python
import os
from concurrent.futures import ThreadPoolExecutor

directory = '.'

def get_file_size(file_path):
    return os.path.getsize(file_path)

file_paths = []
for root, dirs, files in os.walk(directory):
    for file in files:
        file_paths.append(os.path.join(root, file))

with ThreadPoolExecutor() as executor:
    file_sizes = list(executor.map(get_file_size, file_paths))

for i, file_path in enumerate(file_paths):
    print(f"文件 {file_path} 的大小是 {file_sizes[i]} 字节")
```

### 错误处理
在获取文件大小的过程中，可能会遇到文件不存在、权限不足等错误。因此，需要进行适当的错误处理。

```python
import os

file_path = 'nonexistent_file.txt'
try:
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 的大小是 {file_size} 字节")
except FileNotFoundError:
    print(f"文件 {file_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件 {file_path}")
```

## 小结
本文详细介绍了在Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，通过实际示例展示了常见的实践场景，如批量获取文件大小和查找大文件。在最佳实践部分，讨论了性能优化和错误处理的重要性。掌握这些知识和技巧，能够帮助读者在Python编程中更高效、更稳健地处理文件大小相关的任务。

## 参考资料
- [Python官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - stat 模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}