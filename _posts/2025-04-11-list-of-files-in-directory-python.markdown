---
title: "在Python中获取目录中的文件列表"
description: "在Python编程中，经常需要处理文件和目录。获取目录中的文件列表是一项基本操作，它在文件管理、数据处理、自动化脚本等众多场景中都发挥着重要作用。本文将详细介绍如何在Python中获取目录中的文件列表，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---

<!-- more -->

## 简介
在Python编程中，经常需要处理文件和目录。获取目录中的文件列表是一项基本操作，它在文件管理、数据处理、自动化脚本等众多场景中都发挥着重要作用。本文将详细介绍如何在Python中获取目录中的文件列表，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib.Path.iterdir()`
3. 常见实践
    - 过滤特定类型的文件
    - 递归获取文件列表
4. 最佳实践
    - 性能优化
    - 错误处理
5. 小结
6. 参考资料

## 基础概念
在Python中，要获取目录中的文件列表，需要了解一些基本的文件和目录操作概念。

### 文件系统路径
文件系统路径是指向文件或目录的地址。在不同的操作系统中，路径的表示方式略有不同。例如，在Windows系统中，路径使用反斜杠（`\`）分隔目录和文件，而在Unix/Linux系统中，使用正斜杠（`/`）。Python提供了一些方法来处理不同操作系统下的路径，以确保代码的可移植性。

### 目录遍历
目录遍历是指访问目录及其子目录中的所有文件和目录。在获取文件列表时，有时需要递归地遍历整个目录树，以获取所有层次的文件。

## 使用方法

### 使用`os.listdir()`
`os.listdir()`是Python标准库`os`模块中的一个函数，用于返回指定目录中的所有文件和目录的名称列表。

```python
import os

directory = '.'  # 当前目录
file_list = os.listdir(directory)
for file in file_list:
    print(file)
```

### 使用`os.scandir()`
`os.scandir()`是Python 3.5及以上版本中`os`模块新增的函数，它返回一个迭代器，迭代器中的每个元素是一个`DirEntry`对象，包含了文件或目录的详细信息，如名称、是否为目录等。

```python
import os

directory = '.'
with os.scandir(directory) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

### 使用`pathlib.Path.iterdir()`
`pathlib`是Python 3.4及以上版本中新增的标准库模块，提供了面向对象的文件系统路径操作方式。`Path.iterdir()`方法返回一个迭代器，用于遍历目录中的所有文件和目录。

```python
from pathlib import Path

directory = Path('.')
for entry in directory.iterdir():
    if entry.is_file():
        print(entry.name)
```

## 常见实践

### 过滤特定类型的文件
在实际应用中，往往只需要获取特定类型的文件，比如所有的文本文件或图片文件。可以通过检查文件的扩展名来实现过滤。

```python
import os

directory = '.'
file_extension = '.txt'
for file in os.listdir(directory):
    if file.endswith(file_extension):
        print(file)
```

### 递归获取文件列表
有时候需要获取目录及其所有子目录中的文件列表。可以通过递归函数来实现。

```python
import os

def get_all_files(directory):
    file_list = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

directory = '.'
all_files = get_all_files(directory)
for file in all_files:
    print(file)
```

## 最佳实践

### 性能优化
`os.scandir()`和`pathlib.Path.iterdir()`在性能上比`os.listdir()`更好，因为它们返回的是迭代器，而不是一次性加载所有文件和目录的名称到内存中。在处理大量文件时，使用迭代器可以减少内存占用，提高程序的运行效率。

### 错误处理
在获取文件列表时，可能会遇到目录不存在、权限不足等错误。应该使用适当的错误处理机制来确保程序的稳定性。

```python
import os

directory = '.'
try:
    with os.scandir(directory) as entries:
        for entry in entries:
            if entry.is_file():
                print(entry.name)
except FileNotFoundError:
    print(f"目录 {directory} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {directory}")
```

## 小结
本文介绍了在Python中获取目录中文件列表的多种方法，包括`os.listdir()`、`os.scandir()`和`pathlib.Path.iterdir()`。同时，还讨论了常见实践，如过滤特定类型的文件和递归获取文件列表，以及最佳实践，如性能优化和错误处理。通过掌握这些知识，读者可以更加高效地处理文件和目录操作，编写出健壮的Python程序。

## 参考资料