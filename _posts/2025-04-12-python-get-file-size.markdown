---
title: "Python 获取文件大小：基础、实践与最佳方法"
description: "在Python编程中，获取文件大小是一个常见的需求。无论是在数据处理、文件管理还是系统监控等场景下，了解文件的大小都十分重要。本文将详细介绍Python中获取文件大小的相关知识，涵盖基础概念、不同的使用方法、常见实践案例以及最佳实践建议，帮助读者全面掌握这一实用技能。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在Python编程中，获取文件大小是一个常见的需求。无论是在数据处理、文件管理还是系统监控等场景下，了解文件的大小都十分重要。本文将详细介绍Python中获取文件大小的相关知识，涵盖基础概念、不同的使用方法、常见实践案例以及最佳实践建议，帮助读者全面掌握这一实用技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os模块**
    - **pathlib模块**
    - **stat() 方法**
3. **常见实践**
    - **批量获取文件大小**
    - **结合文件操作获取特定文件大小**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
文件大小是指文件在存储介质上所占用的字节数。在计算机中，文件大小的度量单位有字节（Byte）、千字节（KB）、兆字节（MB）、吉字节（GB）等。在Python中获取文件大小，就是通过特定的函数或方法来查询文件实际占用的字节数。

## 使用方法

### os模块
`os` 模块是Python标准库中用于与操作系统交互的模块，其中的 `os.path.getsize()` 函数可以获取文件的大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### pathlib模块
`pathlib` 模块提供了一种面向对象的方式来处理文件路径。`Path` 类的 `stat()` 方法返回文件的元数据，其中包含文件大小信息。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### stat() 方法
直接使用 `os.stat()` 方法也可以获取文件的元数据，进而得到文件大小。

```python
import os

file_path = 'example.txt'
file_stats = os.stat(file_path)
file_size = file_stats.st_size
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 常见实践

### 批量获取文件大小
在处理大量文件时，需要批量获取文件大小。以下示例展示如何遍历目录并获取所有文件的大小。

```python
import os

directory = 'your_directory_path'
for root, dirs, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

### 结合文件操作获取特定文件大小
在进行文件读取或写入操作时，有时需要先知道文件大小。以下示例展示如何在打开文件前获取文件大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)

with open(file_path, 'r') as file:
    content = file.read()
    print(f"文件大小是 {file_size} 字节，文件内容如下：\n{content}")
```

## 最佳实践

### 性能优化
对于大量文件的处理，可以考虑使用多线程或异步编程来提高获取文件大小的效率。例如，使用 `concurrent.futures` 模块的 `ThreadPoolExecutor` 进行多线程处理。

```python
import os
from concurrent.futures import ThreadPoolExecutor

directory = 'your_directory_path'
file_paths = []
for root, dirs, files in os.walk(directory):
    for file in files:
        file_paths.append(os.path.join(root, file))

def get_file_size(file_path):
    return os.path.getsize(file_path)

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
    print(f"没有权限获取文件 {file_path} 的大小")
```

## 小结
本文介绍了Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块以及 `stat()` 方法。通过常见实践案例展示了如何在不同场景下应用这些方法，同时给出了最佳实践建议，如性能优化和错误处理。希望读者通过本文的学习，能够在实际编程中熟练、高效地获取文件大小。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - concurrent.futures模块](https://docs.python.org/3/library/concurrent.futures.html){: rel="nofollow"}