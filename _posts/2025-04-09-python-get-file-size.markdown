---
title: "Python 获取文件大小：全面解析与实践"
description: "在Python编程中，获取文件大小是一个常见的需求。无论是进行数据处理、文件管理还是系统监控，了解文件的大小都至关重要。本文将深入探讨Python中获取文件大小的基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握这一关键技能。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在Python编程中，获取文件大小是一个常见的需求。无论是进行数据处理、文件管理还是系统监控，了解文件的大小都至关重要。本文将深入探讨Python中获取文件大小的基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握这一关键技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - os 模块
    - pathlib 模块
    - stat 模块
3. 常见实践
    - 批量获取文件大小
    - 处理大文件
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
文件大小是指文件在存储介质上占用的字节数。在Python中，获取文件大小是通过调用操作系统提供的接口来实现的。不同的操作系统对文件大小的表示方式可能略有不同，但Python提供了统一的方式来处理。

## 使用方法
### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块。可以使用 `os.path.getsize()` 方法来获取文件的大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### pathlib 模块
`pathlib` 模块是Python 3.4 及以上版本引入的，提供了面向对象的文件路径操作方式。可以使用 `Path.stat()` 方法来获取文件的状态信息，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### stat 模块
`stat` 模块提供了与文件状态相关的常量和函数。可以使用 `os.stat()` 方法结合 `stat` 模块来获取文件大小。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 常见实践
### 批量获取文件大小
在实际应用中，常常需要获取目录下所有文件的大小。可以结合 `os.walk()` 或 `pathlib.Path.iterdir()` 方法来遍历目录，并获取每个文件的大小。

```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### 处理大文件
对于非常大的文件，直接获取文件大小可能会消耗大量内存。可以使用 `os.stat()` 方法结合生成器来逐块读取文件，以避免内存问题。

```python
import os


def get_large_file_size(file_path):
    total_size = 0
    block_size = 1024 * 1024  # 1MB
    with open(file_path, 'rb') as f:
        while True:
            data = f.read(block_size)
            if not data:
                break
            total_size += len(data)
    return total_size


file_path = 'large_file.txt'
file_size = get_large_file_size(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 最佳实践
### 错误处理
在获取文件大小的过程中，可能会遇到文件不存在、权限不足等问题。因此，需要进行适当的错误处理。

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
```

### 性能优化
在处理大量文件时，性能优化非常重要。可以使用多线程或异步编程来提高获取文件大小的效率。

```python
import os
import concurrent.futures


def get_file_size(file_path):
    try:
        return os.path.getsize(file_path)
    except FileNotFoundError:
        return 0
    except PermissionError:
        return 0


file_paths = ['file1.txt', 'file2.txt', 'file3.txt']
with concurrent.futures.ThreadPoolExecutor() as executor:
    file_sizes = list(executor.map(get_file_size, file_paths))

for file_path, file_size in zip(file_paths, file_sizes):
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 小结
本文详细介绍了Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，通过常见实践和最佳实践，展示了如何在实际应用中高效地获取文件大小，并处理可能遇到的问题。希望读者通过本文的学习，能够熟练掌握Python获取文件大小的技巧，提升编程能力。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - stat模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}