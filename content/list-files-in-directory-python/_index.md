---
title: "Python 中列出目录中的文件"
description: "在 Python 编程中，经常会遇到需要列出指定目录下的文件的需求。无论是进行文件处理、数据收集还是项目管理，掌握列出目录文件的方法都是非常实用的技能。本文将详细介绍在 Python 中列出目录文件的基础概念、多种使用方法、常见实践场景以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---

<!-- more -->

## 简介
在 Python 编程中，经常会遇到需要列出指定目录下的文件的需求。无论是进行文件处理、数据收集还是项目管理，掌握列出目录文件的方法都是非常实用的技能。本文将详细介绍在 Python 中列出目录文件的基础概念、多种使用方法、常见实践场景以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.listdir()`
    - 使用 `os.scandir()`
    - 使用 `pathlib` 模块
3. 常见实践
    - 列出特定类型的文件
    - 递归列出目录中的文件
4. 最佳实践
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织和存储文件的容器。列出目录中的文件意味着获取该目录下所有文件的名称列表。Python 提供了多种内置的模块和函数来实现这一功能，这些方法各有优缺点，适用于不同的场景。

## 使用方法

### 使用 `os.listdir()`
`os.listdir()` 是 Python 标准库 `os` 模块中的一个函数，用于返回指定目录下的所有文件和子目录的名称列表。

```python
import os

directory = '.'  # 当前目录
file_list = os.listdir(directory)
for file in file_list:
    print(file)
```

在上述代码中，首先导入 `os` 模块，然后指定要列出文件的目录（这里使用当前目录 `.`），调用 `os.listdir()` 函数获取文件列表，并通过循环打印出每个文件的名称。

### 使用 `os.scandir()`
`os.scandir()` 也是 `os` 模块中的函数，它返回一个迭代器，迭代器的每个元素是一个 `DirEntry` 对象，这些对象包含了文件或目录的更多信息，如文件类型、文件的完整路径等。

```python
import os

directory = '.'
with os.scandir(directory) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

在这段代码中，使用 `os.scandir()` 打开目录，通过迭代器遍历每个条目，使用 `entry.is_file()` 判断是否为文件，如果是则打印文件名。与 `os.listdir()` 相比，`os.scandir()` 性能更好，并且提供了更多关于文件的元数据。

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 引入的标准库，它提供了一种面向对象的方式来处理文件路径。

```python
from pathlib import Path

directory = Path('.')
file_list = [file.name for file in directory.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

在这个示例中，首先从 `pathlib` 模块导入 `Path` 类，创建一个 `Path` 对象表示当前目录。使用 `directory.iterdir()` 方法获取目录下的所有条目，通过列表推导式筛选出文件并获取文件名列表，最后循环打印文件名。`pathlib` 模块的语法更加直观和面向对象，推荐在 Python 3 中使用。

## 常见实践

### 列出特定类型的文件
在实际应用中，往往只需要列出特定类型的文件，比如只列出所有的 Python 文件（`.py` 后缀）。

```python
import os

directory = '.'
file_extension = '.py'
file_list = [file for file in os.listdir(directory) if file.endswith(file_extension)]
for file in file_list:
    print(file)
```

这段代码通过列表推导式过滤出文件名以 `.py` 结尾的文件，并打印出来。

### 递归列出目录中的文件
有时候需要列出一个目录及其所有子目录中的文件，这时候可以使用递归的方法。

```python
import os

def list_files_recursively(directory):
    file_list = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_list.append(os.path.join(root, file))
    return file_list

directory = '.'
result = list_files_recursively(directory)
for file in result:
    print(file)
```

在这个示例中，定义了一个 `list_files_recursively` 函数，使用 `os.walk()` 函数递归遍历目录及其子目录，将所有文件的完整路径添加到列表中并返回。

## 最佳实践
- **性能优先**：如果需要处理大量文件，`os.scandir()` 通常比 `os.listdir()` 性能更好，因为它返回的 `DirEntry` 对象包含了文件的元数据，避免了重复的系统调用。
- **代码可读性**：在 Python 3 环境下，`pathlib` 模块提供了更直观、面向对象的语法，有助于提高代码的可读性和可维护性。
- **错误处理**：在处理文件和目录时，要注意进行适当的错误处理，比如目录不存在的情况。可以使用 `try - except` 语句来捕获并处理可能的异常。

```python
from pathlib import Path

directory = Path('non_existent_directory')
try:
    file_list = [file.name for file in directory.iterdir() if file.is_file()]
except FileNotFoundError:
    print(f"目录 {directory} 不存在。")
```

## 小结
本文详细介绍了在 Python 中列出目录文件的多种方法，包括 `os.listdir()`、`os.scandir()` 和 `pathlib` 模块的使用。通过常见实践部分展示了如何列出特定类型的文件以及递归列出目录中的文件。在实际应用中，应根据性能需求和代码可读性等因素选择合适的方法，并注意进行错误处理。掌握这些方法将有助于更加高效地处理文件和目录相关的任务。

## 参考资料
- 《Python 核心编程》