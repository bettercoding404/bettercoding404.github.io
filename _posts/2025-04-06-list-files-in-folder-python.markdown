---
title: "在Python中列出文件夹中的文件"
description: "在Python编程中，列出文件夹中的文件是一项常见的操作。无论是处理数据文件、管理项目资源还是自动化任务，了解如何获取文件夹中的文件列表都是非常有用的。本文将深入探讨在Python中列出文件夹中文件的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，列出文件夹中的文件是一项常见的操作。无论是处理数据文件、管理项目资源还是自动化任务，了解如何获取文件夹中的文件列表都是非常有用的。本文将深入探讨在Python中列出文件夹中文件的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib.Path.iterdir()`
3. 常见实践
    - 过滤文件类型
    - 递归列出文件
4. 最佳实践
    - 选择合适的方法
    - 错误处理
5. 小结
6. 参考资料

## 基础概念
在Python中，文件系统操作涉及到与操作系统进行交互，以访问和管理文件与文件夹。列出文件夹中的文件，本质上是向操作系统请求获取指定文件夹内的所有文件和子文件夹的名称信息。Python提供了不同的模块和函数来实现这一目的，每个方法都有其特点和适用场景。

## 使用方法

### 使用`os.listdir()`
`os`模块是Python标准库中用于与操作系统交互的模块。`os.listdir()`函数可以返回指定目录下的所有文件和文件夹的名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

### 使用`os.scandir()`
`os.scandir()`函数是`os.listdir()`的增强版本，它返回的是一个迭代器，迭代器中的每个元素是一个`DirEntry`对象，该对象包含了文件或文件夹的更多信息，如文件类型、文件大小等。

```python
import os

folder_path = '.'
with os.scandir(folder_path) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

### 使用`pathlib.Path.iterdir()`
`pathlib`模块提供了面向对象的文件路径操作方式。`Path.iterdir()`方法返回一个迭代器，用于遍历指定路径下的所有文件和文件夹。

```python
from pathlib import Path

folder_path = Path('.')
for entry in folder_path.iterdir():
    if entry.is_file():
        print(entry.name)
```

## 常见实践

### 过滤文件类型
通常我们只对特定类型的文件感兴趣，比如只列出文件夹中的`.txt`文件。

```python
import os

folder_path = '.'
for file in os.listdir(folder_path):
    if file.endswith('.txt'):
        print(file)
```

### 递归列出文件
有时候我们需要列出一个文件夹及其所有子文件夹中的文件。

```python
import os

folder_path = '.'
for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

## 最佳实践

### 选择合适的方法
- 如果只需要获取文件名列表，`os.listdir()`是一个简单直接的选择。
- 当需要获取文件的额外信息，如文件类型、文件大小等，`os.scandir()`更为合适。
- 如果你更喜欢面向对象的编程风格，`pathlib.Path.iterdir()`会是一个不错的选择。

### 错误处理
在进行文件系统操作时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，进行适当的错误处理是很重要的。

```python
import os

folder_path = 'non_existent_folder'
try:
    file_list = os.listdir(folder_path)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有访问文件夹 {folder_path} 的权限。")
```

## 小结
在Python中列出文件夹中的文件有多种方法，每种方法都有其优势和适用场景。通过掌握`os.listdir()`、`os.scandir()`和`pathlib.Path.iterdir()`等方法，以及常见实践和最佳实践，你可以更加高效地处理文件系统操作，满足不同的编程需求。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}