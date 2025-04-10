---
title: "Python 获取文件大小：全面指南"
description: "在Python编程中，获取文件大小是一项常见的任务。无论是进行文件管理、数据处理还是性能优化，了解文件的大小都是非常有用的信息。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，获取文件大小是一项常见的任务。无论是进行文件管理、数据处理还是性能优化，了解文件的大小都是非常有用的信息。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **获取单个文件大小**
    - **获取目录下所有文件大小**
4. **最佳实践**
    - **异常处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
文件大小指的是文件在存储设备上占用的字节数。在Python中，获取文件大小本质上是查询操作系统关于该文件的元数据信息，其中包含了文件大小这一属性。不同的模块提供了不同的方式来获取这一信息，但最终目的都是读取并返回文件的字节数。

## 使用方法

### os 模块
`os` 模块是Python标准库中用于与操作系统交互的模块。可以使用 `os.path.getsize()` 方法来获取文件大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### pathlib 模块
`pathlib` 模块提供了面向对象的方式来处理文件路径。`Path` 类有一个 `stat()` 方法，通过这个方法可以获取文件的各种状态信息，包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_stat = file_path.stat()
file_size = file_stat.st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### stat 模块
`stat` 模块可以直接使用 `os.stat()` 函数来获取文件的状态信息，进而得到文件大小。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 常见实践

### 获取单个文件大小
上述代码示例展示了如何获取单个文件的大小。只需将文件路径作为参数传递给相应的函数或方法即可。

### 获取目录下所有文件大小
有时候需要获取目录下所有文件的大小。可以结合 `os.walk()` 或 `pathlib.Path.iterdir()` 方法来遍历目录，并获取每个文件的大小。

```python
import os

dir_path = 'your_directory'
for root, dirs, files in os.walk(dir_path):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是: {file_size} 字节")


from pathlib import Path

dir_path = Path('your_directory')
for file in dir_path.iterdir():
    if file.is_file():
        file_size = file.stat().st_size
        print(f"文件 {file} 的大小是: {file_size} 字节")
```

## 最佳实践

### 异常处理
在获取文件大小的过程中，可能会遇到文件不存在、权限不足等问题。因此，需要进行适当的异常处理。

```python
import os

file_path = 'nonexistent_file.txt'
try:
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
except FileNotFoundError:
    print(f"文件 {file_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件 {file_path}")


from pathlib import Path

file_path = Path('nonexistent_file.txt')
try:
    file_size = file_path.stat().st_size
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
except FileNotFoundError:
    print(f"文件 {file_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件 {file_path}")
```

### 性能优化
如果需要获取大量文件的大小，频繁调用获取文件大小的函数可能会影响性能。可以考虑批量处理或使用缓存机制来减少重复操作。

```python
import os
from functools import lru_cache

@lru_cache(maxsize=128)
def get_file_size_cached(file_path):
    return os.path.getsize(file_path)

file_paths = ['file1.txt', 'file2.txt', 'file1.txt']  # 包含重复路径
for file_path in file_paths:
    file_size = get_file_size_cached(file_path)
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 小结
本文详细介绍了使用Python获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，还探讨了常见实践和最佳实践，如获取目录下所有文件大小、异常处理以及性能优化。通过掌握这些知识，读者可以更加高效地在Python项目中处理文件大小相关的任务。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - stat模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}