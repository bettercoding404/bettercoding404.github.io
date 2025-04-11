---
title: "探索Python中获取目录文件列表的方法"
description: "在Python编程中，获取目录中的文件列表是一项常见的操作。无论是进行数据处理、文件管理还是自动化任务，能够轻松地列出目录下的文件都是非常重要的。本文将深入探讨在Python中获取目录文件列表的基础概念、多种使用方法、常见实践场景以及最佳实践，帮助读者全面掌握这一关键技能。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---

<!-- more -->

## 简介
在Python编程中，获取目录中的文件列表是一项常见的操作。无论是进行数据处理、文件管理还是自动化任务，能够轻松地列出目录下的文件都是非常重要的。本文将深入探讨在Python中获取目录文件列表的基础概念、多种使用方法、常见实践场景以及最佳实践，帮助读者全面掌握这一关键技能。

## 目录
1. **基础概念**
2. **使用方法**
    - `os.listdir()`
    - `os.scandir()`
    - `pathlib.Path.iterdir()`
3. **常见实践**
    - 遍历特定类型文件
    - 递归获取文件列表
4. **最佳实践**
    - 性能考量
    - 代码可读性与可维护性
5. **小结**
6. **参考资料**

## 基础概念
在Python中，要获取目录中的文件列表，本质上是与操作系统进行交互，查询指定目录下的所有文件和子目录信息。不同的方法在获取这些信息的方式、效率以及返回的数据结构上有所不同。理解这些差异有助于我们根据具体需求选择最合适的方法。

## 使用方法

### `os.listdir()`
`os.listdir()` 是Python标准库 `os` 模块中用于获取指定目录下所有文件和子目录名称的函数。

```python
import os

directory = '.'  # 当前目录
file_list = os.listdir(directory)
for file in file_list:
    print(file)
```

在上述代码中，首先导入 `os` 模块，然后使用 `os.listdir()` 函数获取指定目录（这里是当前目录 `.`）下的所有文件和子目录名称，并存储在 `file_list` 列表中。最后通过循环打印出每个文件名。

### `os.scandir()`
`os.scandir()` 也是 `os` 模块中的函数，它返回一个迭代器，迭代器中的每个元素是 `DirEntry` 对象，包含了文件或目录的更多信息，如文件类型、文件大小等。

```python
import os

directory = '.'
with os.scandir(directory) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

在这段代码中，使用 `os.scandir()` 打开目录并返回迭代器 `entries`。通过循环遍历迭代器，使用 `entry.is_file()` 判断每个元素是否为文件，如果是则打印文件名。

### `pathlib.Path.iterdir()`
`pathlib` 是Python 3.4 及以上版本引入的标准库模块，它提供了面向对象的路径操作方式。`Path.iterdir()` 方法返回一个迭代器，用于遍历目录中的所有文件和子目录。

```python
from pathlib import Path

directory = Path('.')
for entry in directory.iterdir():
    if entry.is_file():
        print(entry.name)
```

此代码中，首先从 `pathlib` 模块导入 `Path` 类，创建 `Path` 对象表示当前目录。然后使用 `iterdir()` 方法获取迭代器，通过循环遍历并判断是否为文件，打印文件名。

## 常见实践

### 遍历特定类型文件
在实际应用中，我们常常需要遍历目录下特定类型的文件，比如所有的 `.txt` 文件。

```python
import os

directory = '.'
for file in os.listdir(directory):
    if file.endswith('.txt'):
        print(file)
```

这段代码通过 `os.listdir()` 获取目录下所有文件和子目录名称，然后使用 `endswith()` 方法判断文件名是否以 `.txt` 结尾，若是则打印文件名。

### 递归获取文件列表
有时候我们需要获取目录及其所有子目录下的文件列表，这就需要递归操作。

```python
import os

def recursive_file_list(directory):
    file_list = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

directory = '.'
result = recursive_file_list(directory)
for file in result:
    print(file)
```

在上述代码中，定义了 `recursive_file_list` 函数，使用 `os.walk()` 函数递归遍历目录。`os.walk()` 会返回当前目录路径 `root`、子目录列表 `dirs` 和文件列表 `files`。通过循环将每个文件的完整路径添加到 `file_list` 中并返回。

## 最佳实践

### 性能考量
在性能方面，`os.scandir()` 和 `pathlib.Path.iterdir()` 通常比 `os.listdir()` 更高效，因为它们返回的是迭代器，而不是一次性将所有文件名加载到内存中。对于大型目录，这种差异尤为明显。

### 代码可读性与可维护性
`pathlib` 模块提供了更面向对象的方式来处理路径，代码更加直观和易读。如果项目主要关注路径操作，建议优先使用 `pathlib` 模块。

## 小结
本文详细介绍了在Python中获取目录文件列表的多种方法，包括 `os.listdir()`、`os.scandir()` 和 `pathlib.Path.iterdir()`，并阐述了它们的基础概念、使用方式、常见实践以及最佳实践。不同的方法适用于不同的场景，在实际编程中，我们需要根据性能需求、代码可读性等因素选择最合适的方法。掌握这些方法将有助于我们更加高效地处理文件和目录相关的任务。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}