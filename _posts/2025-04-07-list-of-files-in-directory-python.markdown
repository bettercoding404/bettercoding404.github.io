---
title: "Python中获取目录下的文件列表"
description: "在Python编程中，经常会遇到需要获取指定目录下的文件列表的需求。无论是进行文件批量处理、数据整理，还是开发文件管理相关的工具，掌握如何获取目录下的文件列表都是一项基本且重要的技能。本文将深入探讨在Python中获取目录下文件列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---

<!-- more -->

## 简介
在Python编程中，经常会遇到需要获取指定目录下的文件列表的需求。无论是进行文件批量处理、数据整理，还是开发文件管理相关的工具，掌握如何获取目录下的文件列表都是一项基本且重要的技能。本文将深入探讨在Python中获取目录下文件列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib`模块
3. 常见实践
    - 遍历目录及其子目录
    - 筛选特定类型的文件
4. 最佳实践
    - 性能优化
    - 代码可读性和可维护性
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（文件夹）是用于组织和管理文件的容器。获取目录下的文件列表，就是获取该目录中包含的所有文件的名称（或路径）的集合。Python提供了多个内置模块和函数来实现这一功能，不同的方法在功能、性能和使用场景上略有差异。

## 使用方法

### 使用`os.listdir()`
`os.listdir()`是Python标准库`os`模块中用于获取指定目录下所有文件和子目录名称列表的函数。

```python
import os

# 获取当前目录下的所有文件和子目录
file_list = os.listdir('.')
for file in file_list:
    print(file)
```

在上述代码中，`os.listdir('.')`中的参数`'.'`表示当前目录。如果要获取其他目录下的文件列表，只需将相应的目录路径作为参数传入即可。

### 使用`os.scandir()`
`os.scandir()`也是`os`模块中的函数，与`os.listdir()`不同的是，它返回的是一个迭代器对象，包含了目录条目的信息，如文件的元数据（大小、修改时间等）。

```python
import os

with os.scandir('.') as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

这里使用`with`语句来管理`os.scandir()`返回的迭代器，确保资源在使用完毕后正确关闭。`entry.is_file()`用于判断当前条目是否为文件。

### 使用`pathlib`模块
`pathlib`模块是Python 3.4及以上版本引入的面向对象的文件路径处理模块，使用它可以更方便地获取文件列表。

```python
from pathlib import Path

p = Path('.')
for file in p.iterdir():
    if file.is_file():
        print(file.name)
```

`Path`类的`iterdir()`方法返回一个生成器，遍历当前目录下的所有条目，`file.is_file()`用于筛选出文件。

## 常见实践

### 遍历目录及其子目录
有时候我们需要遍历一个目录及其所有子目录下的文件。可以使用递归的方式结合上述方法来实现。

```python
import os

def traverse_directory(dir_path):
    for root, dirs, files in os.walk(dir_path):
        for file in files:
            print(os.path.join(root, file))

traverse_directory('.')
```

`os.walk()`函数会递归地遍历指定目录及其子目录，`root`表示当前目录路径，`dirs`表示当前目录下的子目录列表，`files`表示当前目录下的文件列表。

### 筛选特定类型的文件
在实际应用中，常常需要筛选出特定类型的文件，比如只获取所有的`.txt`文件。

```python
from pathlib import Path

p = Path('.')
for file in p.glob('*.txt'):
    print(file.name)
```

`Path`类的`glob()`方法接受一个通配符模式，这里`'*.txt'`表示匹配所有以`.txt`结尾的文件。

## 最佳实践

### 性能优化
- 当只需要获取文件名列表时，`os.listdir()`通常是最快的方法。
- 如果需要获取文件的元数据信息，`os.scandir()`更高效，因为它一次性获取了目录条目的基本信息，避免了后续多次系统调用获取元数据。
- 对于大规模目录遍历，使用生成器（如`os.scandir()`和`pathlib.Path.iterdir()`返回的迭代器）可以减少内存占用，因为它们是按需生成结果，而不是一次性将所有结果加载到内存中。

### 代码可读性和可维护性
- 使用`pathlib`模块可以使代码更具可读性和面向对象的风格，特别是在处理复杂的文件路径操作时。
- 对获取文件列表的操作进行封装成函数，这样可以提高代码的可维护性和复用性。例如：

```python
from pathlib import Path

def get_files_in_dir(dir_path, file_extension=None):
    p = Path(dir_path)
    if file_extension:
        pattern = f'*.{file_extension}'
        return [file.name for file in p.glob(pattern)]
    else:
        return [file.name for file in p.iterdir() if file.is_file()]


file_list = get_files_in_dir('.', 'txt')
for file in file_list:
    print(file)
```

## 小结
在Python中获取目录下的文件列表有多种方法，每种方法都有其特点和适用场景。`os.listdir()`简单直接，适合只需要文件名列表的场景；`os.scandir()`在获取文件名的同时还能获取文件元数据，性能较好；`pathlib`模块提供了面向对象的方式来处理文件路径，使代码更易读和维护。在实际应用中，应根据具体需求选择合适的方法，并注意性能优化和代码的可读性、可维护性。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}