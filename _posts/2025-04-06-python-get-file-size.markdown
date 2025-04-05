---
title: "Python 获取文件大小：从基础到最佳实践"
description: "在 Python 编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理，还是在开发文件上传与下载功能时，了解文件的大小都非常关键。本文将深入探讨如何使用 Python 获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，获取文件大小是一项常见的操作。无论是进行文件管理、数据处理，还是在开发文件上传与下载功能时，了解文件的大小都非常关键。本文将深入探讨如何使用 Python 获取文件大小，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **检查文件是否存在并获取大小**
    - **批量获取多个文件大小**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
文件大小是指文件在存储介质上所占用的字节数。在 Python 中，获取文件大小就是通过特定的函数或方法来查询这个字节数。不同的操作系统和文件系统对文件大小的表示和存储方式可能略有不同，但 Python 提供了统一的接口来处理这些差异。

## 使用方法

### os 模块
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中的 `os.path.getsize()` 函数可以用来获取文件大小。
```python
import os

file_path = 'example.txt'
file_size = os.path.getsize(file_path)
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```
### pathlib 模块
`pathlib` 模块是 Python 3.4 及以上版本中用于处理文件路径的面向对象模块。`Path` 类的 `stat()` 方法可以获取文件的状态信息，其中包括文件大小。
```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```
### stat 模块
`stat` 模块提供了一些与文件状态相关的函数和常量。可以使用 `os.stat()` 结合 `stat` 模块来获取文件大小。
```python
import os
import stat

file_path = 'example.txt'
file_stats = os.stat(file_path)
file_size = file_stats[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 常见实践

### 检查文件是否存在并获取大小
在获取文件大小之前，通常需要先检查文件是否存在，以避免出现错误。
```python
import os

file_path = 'example.txt'
if os.path.exists(file_path):
    file_size = os.path.getsize(file_path)
    print(f"文件 {file_path} 存在，大小是 {file_size} 字节")
else:
    print(f"文件 {file_path} 不存在")
```

### 批量获取多个文件大小
有时候需要获取目录中多个文件的大小。
```python
import os

dir_path = 'your_directory'
for root, dirs, files in os.walk(dir_path):
    for file in files:
        file_path = os.path.join(root, file)
        file_size = os.path.getsize(file_path)
        print(f"文件 {file_path} 的大小是 {file_size} 字节")
```

## 最佳实践

### 错误处理
在获取文件大小的过程中，可能会出现各种错误，如文件不存在、权限不足等。因此，进行适当的错误处理是很重要的。
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
如果需要处理大量文件，性能优化就变得至关重要。可以考虑使用多线程或异步编程来提高效率。以下是使用 `concurrent.futures` 模块进行多线程处理的示例：
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

file_paths = ['file1.txt', 'file2.txt', 'file3.txt']  # 替换为实际文件路径列表
with concurrent.futures.ThreadPoolExecutor() as executor:
    file_sizes = list(executor.map(get_file_size, file_paths))
for i, size in enumerate(file_sizes):
    print(f"文件 {file_paths[i]} 的大小是 {size} 字节")
```

## 小结
通过本文，我们了解了在 Python 中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，我们也探讨了常见实践，如检查文件是否存在和批量获取文件大小。在最佳实践部分，我们强调了错误处理和性能优化的重要性。掌握这些知识和技能，将有助于读者在 Python 编程中更加高效地处理文件大小相关的任务。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python 官方文档 - stat 模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}
- [Python 官方文档 - concurrent.futures 模块](https://docs.python.org/3/library/concurrent.futures.html){: rel="nofollow"}