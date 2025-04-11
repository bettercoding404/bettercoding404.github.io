---
title: "Python获取文件大小：基础、实践与最佳方法"
description: "在Python编程中，获取文件大小是一项常见的操作。无论是在进行文件管理、数据处理还是性能优化时，了解文件的大小都非常有用。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者在各种场景下高效地运用这一功能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，获取文件大小是一项常见的操作。无论是在进行文件管理、数据处理还是性能优化时，了解文件的大小都非常有用。本文将深入探讨如何使用Python获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者在各种场景下高效地运用这一功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **检查文件是否为空**
    - **批量获取文件大小**
4. **最佳实践**
    - **异常处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
文件大小指的是文件在存储介质上占用的字节数。在Python中，获取文件大小是通过特定的函数和模块来实现的。不同的方法适用于不同的场景，了解这些方法的特点和适用范围可以帮助我们更高效地编写代码。

## 使用方法

### os 模块
`os` 模块是Python标准库中用于与操作系统进行交互的模块。可以使用 `os.path.getsize()` 函数来获取文件的大小。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### pathlib 模块
`pathlib` 模块提供了一种面向对象的方式来处理文件路径。使用 `Path` 类的 `stat()` 方法可以获取文件的元数据，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### stat 模块
`stat` 模块提供了与文件状态相关的函数。通过 `os.stat()` 函数结合 `stat` 模块的常量，可以获取文件大小。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 常见实践

### 检查文件是否为空
获取文件大小可以用来判断文件是否为空。

```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
if file_size == 0:
    print(f"文件 {file_path} 为空")
else:
    print(f"文件 {file_path} 不为空，大小是: {file_size} 字节")
```

### 批量获取文件大小
在处理多个文件时，可以批量获取文件大小。

```python
import os

folder_path = 'your_folder_path'
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 最佳实践

### 异常处理
在获取文件大小的过程中，可能会遇到文件不存在、权限不足等问题。因此，需要进行异常处理。

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
在处理大量文件时，性能是一个重要的考虑因素。可以使用生成器和并行处理来提高效率。

```python
import os
from concurrent.futures import ThreadPoolExecutor

folder_path = 'your_folder_path'

def get_file_size(file_path):
    try:
        return os.path.getsize(file_path)
    except FileNotFoundError:
        return 0
    except PermissionError:
        return 0

with ThreadPoolExecutor() as executor:
    file_paths = [os.path.join(root, file) for root, dirs, files in os.walk(folder_path) for file in files]
    file_sizes = list(executor.map(get_file_size, file_paths))

for file_path, file_size in zip(file_paths, file_sizes):
    print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 小结
本文详细介绍了在Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，探讨了常见实践和最佳实践，如检查文件是否为空、批量获取文件大小、异常处理和性能优化。通过掌握这些知识，读者可以在不同的编程场景中灵活运用这些方法，提高代码的质量和效率。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - stat模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}