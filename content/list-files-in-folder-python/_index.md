---
title: "在Python中列出文件夹中的文件"
description: "在Python编程中，列出文件夹中的文件是一项常见的操作。无论是处理数据文件、管理项目资源还是自动化文件处理任务，能够获取文件夹中文件的列表都是非常有用的。本文将详细介绍如何使用Python列出文件夹中的文件，包括基础概念、不同的使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，列出文件夹中的文件是一项常见的操作。无论是处理数据文件、管理项目资源还是自动化文件处理任务，能够获取文件夹中文件的列表都是非常有用的。本文将详细介绍如何使用Python列出文件夹中的文件，包括基础概念、不同的使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib.Path.iterdir()`
3. 常见实践
    - 列出特定类型的文件
    - 递归列出文件夹中的文件
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在Python中，要列出文件夹中的文件，我们需要与操作系统进行交互。Python提供了多个内置模块来处理文件和目录操作，其中最常用的是`os`模块和`pathlib`模块。

`os`模块是Python标准库的一部分，提供了与操作系统交互的功能。`pathlib`模块是Python 3.4引入的面向对象的文件路径处理模块，它提供了更直观和易用的方式来处理文件路径。

## 使用方法

### 使用`os.listdir()`
`os.listdir()`函数是Python中列出文件夹中文件的最基本方法。它返回指定目录中所有文件和子目录的名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

### 使用`os.scandir()`
`os.scandir()`函数是`os.listdir()`的改进版本。它返回一个迭代器，迭代器中的每个元素是一个`DirEntry`对象，包含了文件或目录的更多信息，如文件类型、文件大小等。

```python
import os

folder_path = '.'
with os.scandir(folder_path) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

### 使用`pathlib.Path.iterdir()`
`pathlib.Path.iterdir()`方法是`pathlib`模块中用于列出文件夹中文件的方法。它返回一个迭代器，迭代器中的每个元素是一个`Path`对象，表示文件或目录的路径。

```python
from pathlib import Path

folder_path = Path('.')
for file in folder_path.iterdir():
    if file.is_file():
        print(file.name)
```

## 常见实践

### 列出特定类型的文件
要列出特定类型的文件，我们可以在遍历文件列表时进行过滤。

```python
import os

folder_path = '.'
file_extension = '.txt'

file_list = os.listdir(folder_path)
for file in file_list:
    if file.endswith(file_extension):
        print(file)
```

### 递归列出文件夹中的文件
要递归列出文件夹中的所有文件，我们可以使用`os.walk()`函数或`pathlib.Path.rglob()`方法。

```python
import os

folder_path = '.'

for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

```python
from pathlib import Path

folder_path = Path('.')
for file in folder_path.rglob('*'):
    if file.is_file():
        print(file)
```

## 最佳实践

### 错误处理
在处理文件和目录时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，我们应该进行适当的错误处理。

```python
import os

folder_path = '.'

try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}")
```

### 性能优化
如果需要处理大量文件，性能优化是非常重要的。`os.scandir()`和`pathlib.Path.iterdir()`比`os.listdir()`性能更好，因为它们返回的是迭代器，而不是一次性加载所有文件列表。

```python
import os
import timeit

folder_path = '.'

def list_files_with_listdir():
    return os.listdir(folder_path)

def list_files_with_scandir():
    with os.scandir(folder_path) as entries:
        return [entry.name for entry in entries if entry.is_file()]

print("os.listdir() 运行时间:", timeit.timeit(list_files_with_listdir, number = 1000))
print("os.scandir() 运行时间:", timeit.timeit(list_files_with_scandir, number = 1000))
```

## 小结
在Python中列出文件夹中的文件有多种方法，每种方法都有其优缺点。`os.listdir()`是最基本的方法，而`os.scandir()`和`pathlib.Path.iterdir()`提供了更高效和更丰富的功能。在实际应用中，我们应该根据具体需求选择合适的方法，并注意错误处理和性能优化。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html)