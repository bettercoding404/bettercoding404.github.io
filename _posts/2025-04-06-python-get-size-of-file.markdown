---
title: "Python 获取文件大小：从基础到最佳实践"
description: "在Python编程中，获取文件的大小是一个常见的需求。无论是在处理文件系统操作、优化存储还是进行数据处理时，了解文件的大小都非常有用。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，获取文件的大小是一个常见的需求。无论是在处理文件系统操作、优化存储还是进行数据处理时，了解文件的大小都非常有用。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os.path.getsize() 方法**
    - **os.stat() 方法**
    - **pathlib.Path.stat() 方法**
3. **常见实践**
    - **批量获取文件大小**
    - **处理大文件**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
文件大小指的是文件在存储介质上所占用的字节数。在Python中，获取文件大小就是通过特定的函数或方法来查询文件系统，获取这个字节数的数值。这一操作依赖于Python的标准库以及操作系统提供的文件系统接口。

## 使用方法

### os.path.getsize() 方法
`os.path.getsize()` 是Python标准库 `os.path` 模块中的一个函数，用于获取文件的大小（以字节为单位）。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### os.stat() 方法
`os.stat()` 函数返回文件或目录的状态信息。其中包含了文件大小的信息，可以通过 `.st_size` 属性来获取。

```python
import os

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat.st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### pathlib.Path.stat() 方法
`pathlib` 模块提供了面向对象的方式来处理文件路径。`Path.stat()` 方法返回文件的状态信息，同样可以通过 `.st_size` 属性获取文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_stat = file_path.stat()
file_size = file_stat.st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 常见实践

### 批量获取文件大小
在处理多个文件时，需要批量获取它们的大小。可以结合循环来遍历文件列表。

```python
import os

file_dir = 'your_directory'
for root, dirs, files in os.walk(file_dir):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### 处理大文件
对于非常大的文件，获取大小的操作可能会消耗较多时间。在这种情况下，可以考虑异步操作或多线程处理。

```python
import os
import threading

def get_file_size_async(file_path):
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 的大小是: {file_size} 字节")

file_path = 'large_file.txt'
thread = threading.Thread(target=get_file_size_async, args=(file_path,))
thread.start()
```

## 最佳实践

### 错误处理
在获取文件大小之前，需要确保文件存在并且具有读取权限。可以使用异常处理来捕获可能出现的错误。

```python
import os

file_path = 'nonexistent_file.txt'
try:
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
except FileNotFoundError:
    print(f"文件 {file_path} 不存在")
except PermissionError:
    print(f"没有权限读取文件 {file_path}")
```

### 性能优化
对于频繁获取文件大小的场景，可以考虑缓存文件大小信息，避免重复读取文件系统。

```python
import os
file_size_cache = {}

def get_file_size_cached(file_path):
    if file_path in file_size_cache:
        return file_size_cache[file_path]
    try:
        file_size = os.path.getsize(file_path)
        file_size_cache[file_path] = file_size
        return file_size
    except FileNotFoundError:
        return None
```

## 小结
本文详细介绍了在Python中获取文件大小的多种方法，包括 `os.path.getsize()`、`os.stat()` 和 `pathlib.Path.stat()`。同时，通过常见实践和最佳实践部分，展示了如何在实际应用中使用这些方法，如批量获取文件大小、处理大文件，以及如何进行错误处理和性能优化。掌握这些知识和技巧，将有助于你在Python开发中更高效地处理文件系统相关的任务。

## 参考资料
- [Python官方文档 - os.path](https://docs.python.org/3/library/os.path.html){: rel="nofollow"}
- [Python官方文档 - os.stat](https://docs.python.org/3/library/os.html#os.stat){: rel="nofollow"}
- [Python官方文档 - pathlib](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}