---
title: "在Python中列出文件夹中的文件"
description: "在Python编程中，列出文件夹中的文件是一项常见的操作。无论是进行数据处理、文件管理还是自动化任务，能够获取指定文件夹中的文件列表都是非常有用的技能。本文将详细介绍在Python中列出文件夹中文件的基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，列出文件夹中的文件是一项常见的操作。无论是进行数据处理、文件管理还是自动化任务，能够获取指定文件夹中的文件列表都是非常有用的技能。本文将详细介绍在Python中列出文件夹中文件的基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib.Path.iterdir()`
3. **常见实践**
    - 列出特定类型的文件
    - 递归列出文件夹中的文件
4. **最佳实践**
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在Python中，有多种方法可以列出文件夹中的文件。这些方法主要涉及到`os`模块和`pathlib`模块。`os`模块是Python标准库的一部分，提供了与操作系统交互的功能，包括文件和目录操作。`pathlib`模块是Python 3.4及以上版本引入的，提供了面向对象的路径操作方式，使代码更加简洁和易读。

## 使用方法

### 使用`os.listdir()`
`os.listdir()`是Python中列出文件夹中文件的最基本方法。它返回指定目录中所有文件和文件夹的名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

### 使用`os.scandir()`
`os.scandir()`是`os.listdir()`的改进版本，它返回一个迭代器，迭代器中的每个元素是一个`DirEntry`对象，包含了文件或文件夹的更多信息，如文件类型、修改时间等。

```python
import os

folder_path = '.'
with os.scandir(folder_path) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

### 使用`pathlib.Path.iterdir()`
`pathlib.Path.iterdir()`是`pathlib`模块中列出文件夹中文件的方法。它返回一个生成器，生成器中的每个元素是一个`Path`对象，代表文件夹中的一个文件或文件夹。

```python
from pathlib import Path

folder_path = Path('.')
for file in folder_path.iterdir():
    if file.is_file():
        print(file.name)
```

## 常见实践

### 列出特定类型的文件
有时候我们只需要列出特定类型的文件，比如所有的图片文件或文本文件。可以通过过滤列表来实现。

```python
import os

folder_path = '.'
file_extension = '.txt'

file_list = os.listdir(folder_path)
txt_files = [file for file in file_list if file.endswith(file_extension)]
for txt_file in txt_files:
    print(txt_file)
```

### 递归列出文件夹中的文件
如果需要列出文件夹及其子文件夹中的所有文件，可以使用递归方法。

```python
import os

def list_files_recursively(folder_path):
    file_list = []
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

folder_path = '.'
all_files = list_files_recursively(folder_path)
for file in all_files:
    print(file)
```

## 最佳实践

### 错误处理
在访问文件夹时，可能会遇到文件夹不存在或没有权限访问的情况。因此，进行错误处理是很重要的。

```python
import os

folder_path = 'nonexistent_folder'
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
如果文件夹中包含大量文件，使用迭代器（如`os.scandir()`和`pathlib.Path.iterdir()`）可以提高性能，因为它们不会一次性将所有文件信息加载到内存中。

```python
import os
import time

folder_path = '.'

start_time = time.time()
file_list = os.listdir(folder_path)
for file in file_list:
    pass
print(f"os.listdir() 耗时: {time.time() - start_time} 秒")

start_time = time.time()
with os.scandir(folder_path) as entries:
    for entry in entries:
        pass
print(f"os.scandir() 耗时: {time.time() - start_time} 秒")

from pathlib import Path
start_time = time.time()
folder_path = Path('.')
for file in folder_path.iterdir():
    pass
print(f"pathlib.Path.iterdir() 耗时: {time.time() - start_time} 秒")
```

## 小结
在Python中列出文件夹中的文件有多种方法，每种方法都有其特点和适用场景。`os.listdir()`简单直接，适用于获取基本的文件和文件夹名称列表；`os.scandir()`提供了更多文件信息，性能也更好；`pathlib.Path.iterdir()`则以面向对象的方式提供了简洁的路径操作。在实际应用中，需要根据具体需求选择合适的方法，并注意错误处理和性能优化。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}