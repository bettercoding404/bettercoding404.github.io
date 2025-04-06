---
title: "Python 获取文件大小：全面解析与实践"
description: "在Python编程中，获取文件大小是一个常见的操作。无论是进行文件管理、数据处理，还是网络传输优化等场景，了解文件的大小都是非常有用的信息。本文将深入探讨如何使用Python获取文件大小，包括基础概念、多种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的编程技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在Python编程中，获取文件大小是一个常见的操作。无论是进行文件管理、数据处理，还是网络传输优化等场景，了解文件的大小都是非常有用的信息。本文将深入探讨如何使用Python获取文件大小，包括基础概念、多种使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要的编程技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **os 模块**
    - **pathlib 模块**
    - **stat 模块**
3. **常见实践**
    - **遍历目录获取所有文件大小**
    - **根据文件大小筛选文件**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
文件大小指的是文件在存储设备上所占用的字节数。在计算机中，数据以字节（byte）为单位进行存储，一个字节包含8位（bit）。文件大小的计算对于许多操作至关重要，例如确定文件传输时间、评估存储需求等。

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
`pathlib` 模块提供了一种面向对象的方式来处理文件路径。可以使用 `Path` 类的 `stat()` 方法获取文件的状态信息，其中包括文件大小。

```python
from pathlib import Path

file_path = Path('example.txt')
file_size = file_path.stat().st_size
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

### stat 模块
`stat` 模块用于获取文件的状态信息。可以直接使用 `os.stat()` 函数结合 `stat` 模块的常量来获取文件大小。

```python
import os
import stat

file_path = 'example.txt'
file_stat = os.stat(file_path)
file_size = file_stat[stat.ST_SIZE]
print(f"文件 {file_path} 的大小是: {file_size} 字节")
```

## 常见实践
### 遍历目录获取所有文件大小
在实际应用中，常常需要遍历一个目录及其子目录，获取所有文件的大小。可以结合 `os.walk()` 函数来实现。

```python
import os

def get_all_file_sizes(directory):
    file_sizes = {}
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path)
            file_sizes[file_path] = file_size
    return file_sizes

directory = '.'
file_sizes = get_all_file_sizes(directory)
for file, size in file_sizes.items():
    print(f"文件 {file} 的大小是: {size} 字节")
```

### 根据文件大小筛选文件
有时需要根据文件大小来筛选出符合特定条件的文件，例如找出大于某个阈值的文件。

```python
import os

def filter_files_by_size(directory, min_size):
    filtered_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path)
            if file_size > min_size:
                filtered_files.append(file_path)
    return filtered_files

directory = '.'
min_size = 1024  # 1KB
filtered_files = filter_files_by_size(directory, min_size)
for file in filtered_files:
    print(f"文件 {file} 的大小大于 {min_size} 字节")
```

## 最佳实践
### 性能优化
- **避免重复获取文件大小**：如果在循环中多次需要获取同一个文件的大小，可以将获取操作放在循环外部，减少重复计算。
- **使用生成器**：在遍历目录获取文件大小时，可以使用生成器来避免一次性将所有文件信息加载到内存中，提高内存使用效率。

### 错误处理
在获取文件大小的过程中，可能会遇到文件不存在、权限不足等错误。因此，需要进行适当的错误处理。

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
本文详细介绍了在Python中获取文件大小的多种方法，包括使用 `os` 模块、`pathlib` 模块和 `stat` 模块。同时，通过常见实践和最佳实践展示了如何在实际应用中灵活运用这些方法。掌握这些知识，将有助于读者在处理文件相关任务时更加高效和准确。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - stat模块](https://docs.python.org/3/library/stat.html){: rel="nofollow"}