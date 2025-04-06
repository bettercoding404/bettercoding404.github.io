---
title: "Python 中列出文件夹中的文件"
description: "在 Python 编程中，经常需要处理文件和文件夹。列出文件夹中的文件是一项基本操作，无论是进行文件管理、数据处理还是自动化脚本编写等场景，都可能会用到。本文将深入探讨如何使用 Python 列出文件夹中的文件，涵盖基础概念、使用方法、常见实践以及最佳实践等内容，帮助读者熟练掌握这一重要技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 编程中，经常需要处理文件和文件夹。列出文件夹中的文件是一项基本操作，无论是进行文件管理、数据处理还是自动化脚本编写等场景，都可能会用到。本文将深入探讨如何使用 Python 列出文件夹中的文件，涵盖基础概念、使用方法、常见实践以及最佳实践等内容，帮助读者熟练掌握这一重要技能。

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
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在操作系统中，文件夹（也称为目录）是用于组织和存储文件的容器。列出文件夹中的文件，就是获取该文件夹内所有文件的名称列表。Python 提供了多种方式来实现这一操作，主要涉及 `os` 模块和 `pathlib` 模块。

`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，它提供了许多函数来处理文件和目录，例如列出目录内容、创建目录、删除文件等。

`pathlib` 模块是 Python 3.4 及以上版本引入的，它提供了一种面向对象的方式来处理文件路径，相比 `os` 模块更加直观和易用。

## 使用方法

### 使用 `os` 模块
`os` 模块中的 `listdir` 函数可以用于列出指定文件夹中的文件和子目录。以下是基本的使用示例：

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

在上述代码中，首先导入了 `os` 模块。然后定义了一个变量 `folder_path` 表示要列出文件的文件夹路径，这里使用 `.` 表示当前目录。接着使用 `os.listdir` 函数获取文件夹中的文件和子目录列表，并通过循环打印出每个文件和子目录的名称。

如果要获取文件的完整路径，可以使用 `os.path.join` 函数将文件夹路径和文件名拼接起来：

```python
import os

folder_path = '.'
file_list = os.listdir(folder_path)
for file in file_list:
    full_path = os.path.join(folder_path, file)
    print(full_path)
```

### 使用 `pathlib` 模块
`pathlib` 模块中的 `Path` 类提供了方便的方法来处理文件路径。以下是使用 `pathlib` 列出文件夹中文件的示例：

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

在上述代码中，首先从 `pathlib` 模块导入 `Path` 类。然后创建一个 `Path` 对象 `folder_path` 表示当前目录。使用 `folder_path.iterdir()` 方法获取文件夹中的所有文件和子目录的迭代器，通过列表推导式筛选出其中的文件，并存储在 `file_list` 中。最后通过循环打印出每个文件的路径。

## 常见实践

### 列出特定类型的文件
在实际应用中，常常需要只列出特定类型的文件，例如只列出所有的 Python 文件（`.py` 后缀）。可以通过过滤文件名来实现：

使用 `os` 模块：

```python
import os

folder_path = '.'
python_files = [file for file in os.listdir(folder_path) if file.endswith('.py')]
for file in python_files:
    print(file)
```

使用 `pathlib` 模块：

```python
from pathlib import Path

folder_path = Path('.')
python_files = [file for file in folder_path.iterdir() if file.is_file() and file.suffix == '.py']
for file in python_files:
    print(file)
```

### 递归列出文件夹中的文件
有时候需要列出一个文件夹及其所有子文件夹中的文件。可以使用递归函数来实现。

使用 `os` 模块：

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

在上述代码中，定义了一个 `list_files_recursively` 函数，使用 `os.walk` 函数遍历指定文件夹及其所有子文件夹。`os.walk` 函数返回一个三元组 `(root, dirs, files)`，其中 `root` 是当前目录路径，`dirs` 是当前目录下的子目录列表，`files` 是当前目录下的文件列表。通过循环将所有文件的完整路径添加到 `file_list` 中，并返回该列表。

使用 `pathlib` 模块：

```python
from pathlib import Path

def list_files_recursively(folder_path):
    file_list = []
    for file in folder_path.rglob('*'):
        if file.is_file():
            file_list.append(file)
    return file_list

folder_path = Path('.')
all_files = list_files_recursively(folder_path)
for file in all_files:
    print(file)
```

在这个 `pathlib` 版本中，使用 `Path` 对象的 `rglob` 方法，该方法会递归地匹配指定路径下的所有文件和文件夹，通过过滤只保留文件并添加到 `file_list` 中。

## 最佳实践

### 错误处理
在处理文件和文件夹时，可能会遇到各种错误，例如文件夹不存在、权限不足等。因此，进行适当的错误处理是很重要的。

使用 `os` 模块时，可以使用 `try - except` 语句来捕获可能的错误：

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

使用 `pathlib` 模块时，同样可以进行错误处理：

```python
from pathlib import Path

folder_path = Path('nonexistent_folder')
try:
    file_list = [file for file in folder_path.iterdir() if file.is_file()]
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}")
```

### 性能优化
当处理大量文件时，性能可能会成为一个问题。以下是一些性能优化的建议：

- **减少不必要的操作**：例如在列表推导式或循环中，尽量避免进行复杂的计算或频繁的函数调用。
- **使用生成器**：如果不需要一次性获取所有文件列表，可以使用生成器来逐个生成文件路径，这样可以减少内存占用。

使用 `os` 模块的生成器示例：

```python
import os

def file_generator(folder_path):
    for root, dirs, files in os.walk(folder_path):
        for file in files:
            yield os.path.join(root, file)

folder_path = '.'
file_gen = file_generator(folder_path)
for file in file_gen:
    print(file)
```

使用 `pathlib` 模块的生成器示例：

```python
from pathlib import Path

def file_generator(folder_path):
    for file in folder_path.rglob('*'):
        if file.is_file():
            yield file

folder_path = Path('.')
file_gen = file_generator(folder_path)
for file in file_gen:
    print(file)
```

## 小结
本文详细介绍了在 Python 中列出文件夹中文件的方法，包括使用 `os` 模块和 `pathlib` 模块。通过基础概念的讲解、丰富的代码示例以及常见实践和最佳实践的分享，希望读者能够熟练掌握这一操作，并在实际项目中灵活运用。在处理文件和文件夹时，要注意错误处理和性能优化，以确保程序的稳定性和高效性。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}