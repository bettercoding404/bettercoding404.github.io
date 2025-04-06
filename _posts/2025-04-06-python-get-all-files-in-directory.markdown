---
title: "Python获取目录下所有文件：从基础到最佳实践"
description: "在Python编程中，经常会遇到需要获取某个目录下所有文件的需求。无论是进行数据处理、文件管理还是项目构建，这都是一个非常基础且实用的操作。本文将详细介绍Python中获取目录下所有文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---

<!-- more -->

## 简介
在Python编程中，经常会遇到需要获取某个目录下所有文件的需求。无论是进行数据处理、文件管理还是项目构建，这都是一个非常基础且实用的操作。本文将详细介绍Python中获取目录下所有文件的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。

## 目录
1. **基础概念**
2. **使用方法**
    - `os.listdir()`
    - `os.walk()`
    - `pathlib.Path.iterdir()`
3. **常见实践**
    - **遍历特定类型文件**
    - **递归遍历目录**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 1. 基础概念
在深入学习获取目录下所有文件的方法之前，我们需要了解一些基本概念。在操作系统中，目录（也称为文件夹）是用于组织和管理文件的容器。每个文件都有其所在的目录路径，路径可以是相对路径（相对于当前工作目录）或绝对路径（从文件系统的根目录开始的完整路径）。

Python提供了多个标准库模块来处理文件和目录操作，其中`os`模块和`pathlib`模块是最常用的。`os`模块是Python标准库中与操作系统交互的主要接口，包含了许多用于文件和目录操作的函数。`pathlib`模块是Python 3.4及以上版本引入的面向对象的文件路径处理模块，它提供了更直观、更符合Python风格的方式来处理文件路径。

## 2. 使用方法

### 2.1 `os.listdir()`
`os.listdir()`函数用于返回指定目录下的所有文件和子目录的名称列表。其基本语法如下：

```python
import os

directory = '.'  # 当前目录
file_list = os.listdir(directory)
for file in file_list:
    print(file)
```

在上述代码中，我们首先导入了`os`模块，然后指定了要列出文件的目录（这里使用当前目录`'.'`），接着使用`os.listdir()`函数获取目录下的所有文件和子目录名称，并通过循环打印出来。

需要注意的是，`os.listdir()`返回的只是文件名或目录名，而不是完整的路径。如果需要完整路径，可以使用`os.path.join()`函数进行拼接：

```python
import os

directory = '.'
file_list = os.listdir(directory)
for file in file_list:
    full_path = os.path.join(directory, file)
    print(full_path)
```

### 2.2 `os.walk()`
`os.walk()`函数用于递归地遍历目录树。它会返回一个三元组`(dirpath, dirnames, filenames)`，其中`dirpath`是当前目录的路径，`dirnames`是当前目录下的所有子目录名称列表，`filenames`是当前目录下的所有文件名称列表。其基本语法如下：

```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        full_path = os.path.join(root, file)
        print(full_path)
```

在上述代码中，通过`os.walk()`函数遍历指定目录及其所有子目录。在每次循环中，`root`表示当前目录路径，`dirs`表示当前目录下的子目录列表，`files`表示当前目录下的文件列表。然后，我们通过`os.path.join()`函数将文件名称与当前目录路径拼接成完整路径并打印出来。

### 2.3 `pathlib.Path.iterdir()`
`pathlib.Path`类提供了一种面向对象的方式来处理文件路径。`iterdir()`方法用于迭代指定路径下的所有文件和目录，返回一个生成器对象。其基本语法如下：

```python
from pathlib import Path

directory = Path('.')
for file in directory.iterdir():
    if file.is_file():
        print(file)
```

在上述代码中，我们首先从`pathlib`模块导入`Path`类，然后创建一个`Path`对象表示当前目录。接着，使用`iterdir()`方法迭代目录下的所有文件和目录，并通过`is_file()`方法判断是否为文件，如果是则打印其路径。

## 3. 常见实践

### 3.1 遍历特定类型文件
在实际应用中，我们通常只需要遍历特定类型的文件，比如所有的`.txt`文件。可以通过以下方法实现：

```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith('.txt'):
            full_path = os.path.join(root, file)
            print(full_path)
```

使用`pathlib`模块实现同样的功能：

```python
from pathlib import Path

directory = Path('.')
for file in directory.rglob('*.txt'):
    print(file)
```

`rglob()`方法会递归地搜索指定路径下的所有匹配文件，这里`*.txt`表示匹配所有以`.txt`结尾的文件。

### 3.2 递归遍历目录
前面已经介绍了`os.walk()`函数可以递归遍历目录，使用`pathlib`模块也可以实现递归遍历：

```python
from pathlib import Path

directory = Path('.')
for file in directory.glob('**/*', recursive=True):
    if file.is_file():
        print(file)
```

`glob()`方法用于根据指定的模式匹配文件路径，`**/*`表示匹配所有文件和目录，`recursive=True`参数表示递归匹配。

## 4. 最佳实践

### 4.1 性能优化
在处理大量文件时，性能是一个重要问题。`os.walk()`和`pathlib.Path.glob()`（递归模式）都会进行递归操作，可能会消耗较多的资源。如果只需要遍历一层目录，可以优先使用`os.listdir()`或`pathlib.Path.iterdir()`。

另外，使用生成器可以避免一次性将所有文件信息加载到内存中，提高内存使用效率。例如`os.walk()`和`pathlib.Path.iterdir()`返回的都是生成器对象，可以逐行处理文件，而不是一次性处理所有文件。

### 4.2 错误处理
在进行文件和目录操作时，可能会遇到各种错误，如目录不存在、权限不足等。因此，进行适当的错误处理是非常必要的。可以使用`try - except`语句来捕获并处理可能的异常：

```python
import os

directory = 'nonexistent_directory'
try:
    file_list = os.listdir(directory)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"目录 {directory} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {directory}")
```

使用`pathlib`模块时同样可以进行错误处理：

```python
from pathlib import Path

directory = Path('nonexistent_directory')
try:
    for file in directory.iterdir():
        if file.is_file():
            print(file)
except FileNotFoundError:
    print(f"目录 {directory} 不存在")
except PermissionError:
    print(f"没有权限访问目录 {directory}")
```

## 5. 小结
本文详细介绍了Python中获取目录下所有文件的方法，包括`os.listdir()`、`os.walk()`和`pathlib.Path.iterdir()`等函数的使用。同时，还介绍了常见实践，如遍历特定类型文件和递归遍历目录，以及最佳实践，如性能优化和错误处理。通过掌握这些知识，读者可以在Python编程中更加高效地处理文件和目录操作。

## 6. 参考资料
- [Python官方文档 - os模块](https://docs.python.org/zh-cn/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/zh-cn/3/library/pathlib.html){: rel="nofollow"}