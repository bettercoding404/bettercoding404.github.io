---
title: "Python 获取文件大小：深入解析与实践"
description: "在Python编程中，获取文件大小是一个常见的操作。无论是在文件管理、数据处理还是系统监控等场景下，了解文件的大小都非常重要。本文将详细介绍Python中获取文件大小的基础概念、多种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，获取文件大小是一个常见的操作。无论是在文件管理、数据处理还是系统监控等场景下，了解文件的大小都非常重要。本文将详细介绍Python中获取文件大小的基础概念、多种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **批量获取文件大小**
    - **在文件处理流程中获取文件大小**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
文件大小指的是文件在存储设备上占用的字节数。在计算机中，文件的大小是衡量文件所包含数据量的一个重要指标。Python提供了多种方式来获取文件的大小，不同的方法适用于不同的场景和需求。

## 使用方法

### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块，其中 `os.path.getsize()` 方法可以用来获取文件的大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### pathlib 模块
`pathlib` 模块是Python 3.4 及以上版本中引入的面向对象的文件路径处理模块。通过 `Path` 对象的 `stat()` 方法可以获取文件的状态信息，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### stat 模块
`stat` 模块提供了与文件状态相关的函数和常量。可以使用 `os.stat()` 获取文件的状态信息，进而获取文件大小。

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
在处理大量文件时，需要批量获取文件大小。以下是使用 `os` 模块遍历目录并获取所有文件大小的示例：

```python
import os

folder_path = 'your_folder_path'
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### 在文件处理流程中获取文件大小
在进行文件读取、写入或其他处理操作时，获取文件大小可以帮助我们更好地控制处理过程。例如，在读取大文件时，可以先获取文件大小，以便分块读取。

```python
import os

file_path = 'large_file.txt'
file_size = os.path.getsize(file_path)
chunk_size = 1024 * 1024  # 1MB 分块

with open(file_path, 'rb') as f:
    for i in range(0, file_size, chunk_size):
        chunk = f.read(chunk_size)
        # 处理每一块数据
```

## 最佳实践

### 性能优化
对于大量文件的处理，为了提高性能，可以考虑使用多线程或异步操作。例如，使用 `concurrent.futures` 模块的线程池来并行获取文件大小。

```python
import os
import concurrent.futures

folder_path = 'your_folder_path'
file_paths = []
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_paths.append(os.path.join(root, file))

def get_file_size(file_path):
    return os.path.getsize(file_path)

with concurrent.futures.ThreadPoolExecutor() as executor:
    file_sizes = list(executor.map(get_file_size, file_paths))

for path, size in zip(file_paths, file_sizes):
    print(f"文件 {path} 的大小是: {size} 字节")
```

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
    print(f"没有权限获取文件 {file_path} 的大小")
```

## 小结
本文详细介绍了Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，通过常见实践和最佳实践展示了如何在不同场景下应用这些方法，如批量获取文件大小、在文件处理流程中获取文件大小，以及如何进行性能优化和错误处理。希望读者通过本文的学习，能够熟练掌握Python获取文件大小的技巧，并在实际项目中灵活运用。

## 参考资料
- [Python官方文档 - os 模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html)
- [Python官方文档 - stat 模块](https://docs.python.org/3/library/stat.html)