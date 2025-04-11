---
title: "深入探索Python中列出文件夹中的文件"
description: "在Python编程中，列出文件夹中的文件是一项非常常见的操作。无论是进行数据处理、文件管理还是自动化任务，都经常需要获取特定文件夹下的文件列表。Python提供了多种方法来实现这一功能，每种方法都有其特点和适用场景。本文将深入探讨这些方法，帮助你在实际项目中高效地列出文件夹中的文件。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在Python编程中，列出文件夹中的文件是一项非常常见的操作。无论是进行数据处理、文件管理还是自动化任务，都经常需要获取特定文件夹下的文件列表。Python提供了多种方法来实现这一功能，每种方法都有其特点和适用场景。本文将深入探讨这些方法，帮助你在实际项目中高效地列出文件夹中的文件。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.listdir()`
    - `os.walk()`
    - `pathlib.Path.iterdir()`
3. **常见实践**
    - 列出特定类型的文件
    - 递归列出所有文件
4. **最佳实践**
    - 性能优化
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
在Python中，文件和目录的操作是通过标准库中的模块来完成的。`os` 模块是最常用的用于操作系统相关功能的模块，其中包含了许多用于文件和目录操作的函数。`pathlib` 模块是Python 3.4 引入的，它提供了一种面向对象的方式来处理文件路径，使代码更加直观和易读。

## 使用方法

### `os.listdir()`
`os.listdir()` 是Python中列出文件夹中文件的最基本方法。它返回指定目录下的所有文件和子目录的名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

### `os.walk()`
`os.walk()` 用于遍历目录树，它会递归地返回指定目录下的所有文件和子目录。

```python
import os

folder_path = '.'  # 当前目录
for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

### `pathlib.Path.iterdir()`
`pathlib.Path.iterdir()` 是 `pathlib` 模块中用于列出文件夹内容的方法，它返回一个迭代器，遍历目录中的所有项。

```python
from pathlib import Path

folder_path = Path('.')  # 当前目录
for item in folder_path.iterdir():
    if item.is_file():
        print(item.name)
```

## 常见实践

### 列出特定类型的文件
有时候我们只需要列出特定类型的文件，比如所有的 `.txt` 文件。

```python
import os

folder_path = '.'  # 当前目录
for file in os.listdir(folder_path):
    if file.endswith('.txt'):
        print(file)
```

### 递归列出所有文件
使用 `os.walk()` 可以很方便地递归列出所有文件。

```python
import os

folder_path = '.'  # 当前目录
for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

## 最佳实践

### 性能优化
如果需要处理大量文件，`pathlib.Path.iterdir()` 通常比 `os.listdir()` 性能更好，因为它返回的是一个迭代器，而不是一次性加载所有文件列表。

### 错误处理
在进行文件操作时，一定要进行错误处理，以防止程序因为文件不存在或权限问题而崩溃。

```python
import os

folder_path = '.'  # 当前目录
try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}")
```

## 小结
本文介绍了Python中列出文件夹中文件的多种方法，包括 `os.listdir()`、`os.walk()` 和 `pathlib.Path.iterdir()`。同时，还探讨了常见实践和最佳实践，如列出特定类型的文件、递归列出所有文件、性能优化和错误处理等。通过掌握这些方法和技巧，你可以在Python项目中更加高效地处理文件和目录操作。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}