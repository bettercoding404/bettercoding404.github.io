---
title: "在Python中从目录中选取文件或目录：全面指南"
description: "在Python编程中，处理文件系统是一项常见的任务。从目录中选取特定的文件或目录在许多场景下都非常有用，比如数据处理、文件管理、自动化脚本等。本文将深入探讨如何在Python中从目录里进行选取操作，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

<!-- more -->

## 简介
在Python编程中，处理文件系统是一项常见的任务。从目录中选取特定的文件或目录在许多场景下都非常有用，比如数据处理、文件管理、自动化脚本等。本文将深入探讨如何在Python中从目录里进行选取操作，涵盖基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. **基础概念**
2. **使用方法**
    - 使用`os`模块
    - 使用`pathlib`模块
3. **常见实践**
    - 按文件扩展名选取文件
    - 选取特定目录下的所有文件
    - 递归选取文件
4. **最佳实践**
    - 错误处理
    - 性能优化
    - 代码结构
5. **小结**
6. **参考资料**

## 1. 基础概念
在Python中，从目录中选取意味着遍历目录结构，根据特定的条件筛选出符合要求的文件或目录。目录（文件夹）是文件系统中用于组织文件的容器。理解文件路径的概念很重要，路径是指向文件或目录在文件系统中位置的字符串。

有两种主要的路径表示方式：
- **绝对路径**：从文件系统的根目录开始的完整路径，例如`/home/user/Documents`（在Unix-like系统上）或`C:\Users\user\Documents`（在Windows系统上）。
- **相对路径**：相对于当前工作目录的路径，例如`../data`表示上一级目录中的`data`目录。

## 2. 使用方法

### 使用`os`模块
`os`模块是Python标准库的一部分，提供了与操作系统交互的功能。以下是使用`os`模块从目录中选取文件的基本步骤：

```python
import os


def pick_files_by_extension(directory, extension):
    selected_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                selected_files.append(os.path.join(root, file))
    return selected_files


directory_path = '.'
file_extension = '.txt'
result = pick_files_by_extension(directory_path, file_extension)
for file in result:
    print(file)
```

在上述代码中：
- `os.walk`函数用于遍历目录树。它会返回当前目录路径（`root`）、当前目录下的子目录列表（`dirs`）以及当前目录下的文件列表（`files`）。
- 我们遍历`files`列表，使用`endswith`方法检查文件扩展名是否符合要求。
- `os.path.join`函数用于将目录路径和文件名组合成完整的文件路径。

### 使用`pathlib`模块
`pathlib`模块在Python 3.4及以上版本中可用，它提供了一种面向对象的方式来处理文件路径。

```python
from pathlib import Path


def pick_files_by_extension(directory, extension):
    selected_files = []
    p = Path(directory)
    for file in p.glob('**/*' + extension, recursive=True):
        selected_files.append(str(file))
    return selected_files


directory_path = '.'
file_extension = '.txt'
result = pick_files_by_extension(directory_path, file_extension)
for file in result:
    print(file)
```

在这段代码中：
- `Path`类用于表示文件路径。
- `glob`方法用于查找匹配指定模式的文件路径。`**`表示递归匹配，`*`表示任意数量的任意字符。
- `recursive=True`参数表示递归遍历目录。

## 3. 常见实践

### 按文件扩展名选取文件
这是最常见的选取需求之一。如上述代码示例所示，通过检查文件扩展名来筛选文件。例如，要选取目录下所有的Python文件（`.py`）：

```python
from pathlib import Path


def pick_py_files(directory):
    p = Path(directory)
    return [str(file) for file in p.glob('**/*.py', recursive=True)]


directory_path = '.'
py_files = pick_py_files(directory_path)
for file in py_files:
    print(file)
```

### 选取特定目录下的所有文件
有时候我们只需要获取某个目录下的所有文件，而不关心子目录。可以使用`os.listdir`或`pathlib.Path.iterdir`方法：

```python
from pathlib import Path


def pick_all_files_in_dir(directory):
    p = Path(directory)
    return [str(file) for file in p.iterdir() if file.is_file()]


directory_path = '.'
all_files = pick_all_files_in_dir(directory_path)
for file in all_files:
    print(file)
```

### 递归选取文件
递归选取文件意味着不仅选取当前目录下的文件，还包括所有子目录下的文件。`os.walk`和`pathlib.Path.glob`（设置`recursive=True`）都可以实现这一点。例如：

```python
import os


def pick_all_files_recursively(directory):
    selected_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            selected_files.append(os.path.join(root, file))
    return selected_files


directory_path = '.'
recursive_files = pick_all_files_recursively(directory_path)
for file in recursive_files:
    print(file)
```

## 4. 最佳实践

### 错误处理
在处理文件系统时，可能会遇到各种错误，如目录不存在、权限不足等。应该始终进行适当的错误处理：

```python
from pathlib import Path


def pick_files_by_extension(directory, extension):
    try:
        p = Path(directory)
        if not p.exists() or not p.is_dir():
            raise ValueError(f"{directory} is not a valid directory")
        selected_files = []
        for file in p.glob('**/*' + extension, recursive=True):
            selected_files.append(str(file))
        return selected_files
    except Exception as e:
        print(f"An error occurred: {e}")
        return []


directory_path = '.'
file_extension = '.txt'
result = pick_files_by_extension(directory_path, file_extension)
for file in result:
    print(file)
```

### 性能优化
如果处理大量文件或大型目录结构，性能可能成为问题。可以考虑以下优化方法：
- 尽量减少不必要的文件访问和操作。
- 使用生成器来减少内存占用，例如`os.walk`返回的是生成器，可以直接迭代处理。

### 代码结构
保持代码结构清晰和模块化。将文件选取功能封装成独立的函数或类，以便于复用和维护。例如：

```python
from pathlib import Path


class FilePicker:
    def __init__(self, directory):
        self.directory = Path(directory)
        if not self.directory.exists() or not self.directory.is_dir():
            raise ValueError(f"{directory} is not a valid directory")

    def pick_files_by_extension(self, extension):
        selected_files = []
        for file in self.directory.glob('**/*' + extension, recursive=True):
            selected_files.append(str(file))
        return selected_files


directory_path = '.'
picker = FilePicker(directory_path)
file_extension = '.txt'
result = picker.pick_files_by_extension(file_extension)
for file in result:
    print(file)
```

## 5. 小结
在Python中从目录中选取文件或目录有多种方法，`os`模块和`pathlib`模块提供了强大的功能来满足不同的需求。理解基础概念、掌握使用方法，并遵循最佳实践，能够帮助我们更高效、可靠地处理文件系统操作。无论是简单的按扩展名选取文件，还是复杂的递归选取和性能优化，都可以通过合理运用这些技术来实现。

## 6. 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- 《Python Cookbook》（第3版） - 关于文件和目录处理的章节