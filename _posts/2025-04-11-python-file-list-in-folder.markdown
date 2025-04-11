---
title: "探索Python中的文件列表操作：获取文件夹中的文件列表"
description: "在Python编程中，经常需要处理文件和文件夹。获取文件夹中的文件列表是一项基础且实用的操作，它在许多场景中都非常有用，比如批量处理文件、整理数据文件等等。本文将深入探讨如何使用Python获取文件夹中的文件列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，经常需要处理文件和文件夹。获取文件夹中的文件列表是一项基础且实用的操作，它在许多场景中都非常有用，比如批量处理文件、整理数据文件等等。本文将深入探讨如何使用Python获取文件夹中的文件列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用`os`模块**
    - **使用`pathlib`模块**
3. **常见实践**
    - **列出特定类型的文件**
    - **递归列出文件夹中的文件**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
在Python中，文件和文件夹是操作系统中的基本概念。文件夹（也称为目录）是用于组织和存储文件的容器。获取文件夹中的文件列表，就是获取该文件夹内所有文件的名称集合。这可以帮助我们对文件进行进一步的操作，如读取、写入、重命名或删除等。

## 使用方法

### 使用`os`模块
`os`模块是Python标准库中用于与操作系统进行交互的模块，其中包含了许多处理文件和目录的函数。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

在上述代码中：
1. 首先导入`os`模块。
2. 定义了要列出文件的文件夹路径，这里使用`.`表示当前目录。
3. 使用`os.listdir()`函数获取指定文件夹中的文件和文件夹列表。
4. 通过循环遍历列表并打印每个文件和文件夹的名称。

### 使用`pathlib`模块
`pathlib`模块是Python 3.4及以上版本中引入的，它提供了一种面向对象的方式来处理文件路径。

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file.name for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

在这段代码中：
1. 从`pathlib`模块导入`Path`类。
2. 创建一个`Path`对象表示指定的文件夹路径。
3. 使用`folder_path.iterdir()`方法遍历文件夹中的所有条目，通过`file.is_file()`判断是否为文件，并将文件名存储在列表中。
4. 最后遍历列表打印文件名。

## 常见实践

### 列出特定类型的文件
有时候我们只需要获取特定类型的文件，比如所有的`.txt`文件。

```python
import os

folder_path = '.'
file_extension = '.txt'
file_list = [file for file in os.listdir(folder_path) if file.endswith(file_extension)]
for file in file_list:
    print(file)
```

在这段代码中，通过`file.endswith(file_extension)`筛选出以`.txt`结尾的文件，并将其存储在列表中。

### 递归列出文件夹中的文件
有时候我们需要获取一个文件夹及其所有子文件夹中的文件列表。

```python
import os

folder_path = '.'
file_list = []
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_list.append(os.path.join(root, file))
for file in file_list:
    print(file)
```

在上述代码中，`os.walk()`函数会递归地遍历指定文件夹及其所有子文件夹。`root`表示当前目录，`dirs`表示当前目录下的所有子文件夹，`files`表示当前目录下的所有文件。通过`os.path.join()`函数将文件路径和文件名组合成完整的文件路径。

## 最佳实践

### 错误处理
在处理文件和文件夹时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，进行适当的错误处理是很重要的。

```python
import os

folder_path = 'nonexistent_folder'
try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}。")
```

在这段代码中，使用`try-except`语句捕获可能出现的`FileNotFoundError`和`PermissionError`异常，并进行相应的处理。

### 性能优化
当处理大量文件时，性能优化就变得很关键。例如，使用`pathlib`模块的`glob`方法可以更高效地获取文件列表。

```python
from pathlib import Path

folder_path = Path('.')
file_list = list(folder_path.glob('**/*', recursive=True))
for file in file_list:
    print(file)
```

`folder_path.glob('**/*', recursive=True)`会递归地获取指定文件夹及其子文件夹中的所有文件和文件夹，这种方式在性能上通常比`os.walk()`更好。

## 小结
本文详细介绍了在Python中获取文件夹中文件列表的方法，包括使用`os`模块和`pathlib`模块。同时，通过示例展示了常见实践，如列出特定类型的文件和递归列出文件。在最佳实践部分，强调了错误处理和性能优化的重要性。希望读者通过本文的学习，能够熟练掌握并灵活运用这些技巧，在实际编程中高效地处理文件列表。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}