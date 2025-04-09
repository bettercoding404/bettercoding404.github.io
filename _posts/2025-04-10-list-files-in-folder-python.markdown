---
title: "Python 中列出文件夹中的文件"
description: "在 Python 编程中，经常需要处理文件和文件夹。列出文件夹中的文件是一项基本且常用的操作。无论是开发数据处理脚本、文件管理工具还是其他类型的应用程序，能够轻松获取文件夹中的文件列表都是非常关键的技能。本文将详细介绍如何在 Python 中列出文件夹中的文件，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，经常需要处理文件和文件夹。列出文件夹中的文件是一项基本且常用的操作。无论是开发数据处理脚本、文件管理工具还是其他类型的应用程序，能够轻松获取文件夹中的文件列表都是非常关键的技能。本文将详细介绍如何在 Python 中列出文件夹中的文件，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `os` 模块
    - 使用 `pathlib` 模块
3. **常见实践**
    - 列出特定类型的文件
    - 递归列出文件夹中的文件
4. **最佳实践**
    - 错误处理
    - 提高代码可读性
5. **小结**
6. **参考资料**

## 基础概念
在深入探讨如何列出文件夹中的文件之前，先了解一些相关的基础概念。

**文件系统**：计算机中的文件系统是一种用于组织和存储文件的层次结构。文件夹（也称为目录）用于将相关的文件分组在一起，形成一个树形结构。根目录是文件系统层次结构的顶级目录，所有其他文件夹和文件都位于其下。

**路径**：路径是用于标识文件或文件夹在文件系统中的位置的字符串。在 Windows 系统中，路径使用反斜杠（`\`）作为分隔符，而在 Unix 和类 Unix 系统（如 Linux 和 macOS）中，使用正斜杠（`/`）作为分隔符。为了使 Python 代码在不同操作系统上具有更好的兼容性，建议使用 `os.path.join()` 方法或 `pathlib` 模块来处理路径。

## 使用方法
### 使用 `os` 模块
`os` 模块是 Python 标准库的一部分，提供了与操作系统交互的功能。要列出文件夹中的文件，可以使用 `os.listdir()` 函数。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

在上述代码中：
1. 首先导入 `os` 模块。
2. 定义 `folder_path` 变量，这里使用 `.` 表示当前目录。
3. 使用 `os.listdir()` 函数获取指定文件夹中的所有文件和文件夹的名称列表，并将其存储在 `file_list` 变量中。
4. 最后，通过循环遍历 `file_list` 并打印每个文件和文件夹的名称。

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本引入的标准库模块，提供了面向对象的文件路径处理方式，使得代码更加简洁和易读。

```python
from pathlib import Path

folder_path = Path('.')  # 当前目录
file_list = [file.name for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

在上述代码中：
1. 从 `pathlib` 模块导入 `Path` 类。
2. 创建一个 `Path` 对象 `folder_path`，表示当前目录。
3. 使用 `folder_path.iterdir()` 方法遍历目录中的所有项，并通过 `file.is_file()` 方法过滤出文件，将文件名存储在 `file_list` 列表中。
4. 最后，通过循环遍历 `file_list` 并打印每个文件名。

## 常见实践
### 列出特定类型的文件
有时候，我们只需要列出文件夹中特定类型的文件，比如所有的图片文件或文本文件。

```python
import os

folder_path = '.'
file_extension = '.txt'
file_list = [file for file in os.listdir(folder_path) if file.endswith(file_extension)]
for file in file_list:
    print(file)
```

在上述代码中，通过 `file.endswith(file_extension)` 方法过滤出以指定扩展名结尾的文件，并将其存储在 `file_list` 列表中。

### 递归列出文件夹中的文件
如果需要列出文件夹及其所有子文件夹中的文件，可以使用递归方法。

```python
import os

folder_path = '.'

def list_files_recursively(folder):
    file_list = []
    for root, dirs, files in os.walk(folder):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

file_list = list_files_recursively(folder_path)
for file in file_list:
    print(file)
```

在上述代码中：
1. 定义了一个 `list_files_recursively` 函数，该函数接受一个文件夹路径作为参数。
2. 使用 `os.walk()` 函数遍历指定文件夹及其所有子文件夹。`os.walk()` 函数返回一个三元组 `(root, dirs, files)`，其中 `root` 是当前目录路径，`dirs` 是当前目录下的子文件夹列表，`files` 是当前目录下的文件列表。
3. 在循环中，将每个文件的完整路径添加到 `file_list` 列表中。
4. 调用 `list_files_recursively` 函数获取递归的文件列表，并通过循环打印每个文件的路径。

## 最佳实践
### 错误处理
在处理文件和文件夹时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，进行适当的错误处理是很重要的。

```python
import os

folder_path = '.'

try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}。")
```

在上述代码中，使用 `try-except` 块捕获可能的 `FileNotFoundError` 和 `PermissionError` 异常，并进行相应的处理。

### 提高代码可读性
为了使代码更易于理解和维护，可以将复杂的逻辑封装成函数，并添加适当的注释。

```python
import os


def list_files_in_folder(folder_path):
    """
    列出指定文件夹中的文件
    :param folder_path: 文件夹路径
    :return: 文件列表
    """
    try:
        file_list = os.listdir(folder_path)
        return file_list
    except FileNotFoundError:
        print(f"文件夹 {folder_path} 不存在。")
        return []
    except PermissionError:
        print(f"没有权限访问文件夹 {folder_path}。")
        return []


folder_path = '.'
file_list = list_files_in_folder(folder_path)
for file in file_list:
    print(file)

```

在上述代码中：
1. 定义了一个 `list_files_in_folder` 函数，该函数接受一个文件夹路径作为参数，并返回该文件夹中的文件列表。
2. 函数内部使用 `try-except` 块处理可能的异常，并在发生异常时返回空列表。
3. 添加了函数注释，清晰地说明了函数的功能、参数和返回值。

## 小结
本文详细介绍了在 Python 中列出文件夹中的文件的方法，包括使用 `os` 模块和 `pathlib` 模块。同时，还探讨了常见实践，如列出特定类型的文件和递归列出文件。在最佳实践部分，强调了错误处理和提高代码可读性的重要性。通过掌握这些知识和技巧，读者能够更加高效地处理文件和文件夹操作，开发出健壮、易读的 Python 代码。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/zh-cn/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/zh-cn/3/library/pathlib.html){: rel="nofollow"}