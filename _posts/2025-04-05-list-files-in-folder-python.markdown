---
title: "用Python列出文件夹中的文件"
description: "在Python编程中，列出文件夹中的文件是一项常见且基础的操作。无论是数据处理、文件管理还是自动化脚本编写，都经常需要获取指定文件夹下的文件列表。本文将深入探讨如何使用Python实现这一功能，从基础概念到常见实践，再到最佳实践，帮助读者全面掌握这一技能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

# 用Python列出文件夹中的文件

## 简介
在Python编程中，列出文件夹中的文件是一项常见且基础的操作。无论是数据处理、文件管理还是自动化脚本编写，都经常需要获取指定文件夹下的文件列表。本文将深入探讨如何使用Python实现这一功能，从基础概念到常见实践，再到最佳实践，帮助读者全面掌握这一技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.listdir()`
    - 使用`os.scandir()`
    - 使用`pathlib`模块
3. 常见实践
    - 列出特定类型的文件
    - 递归列出文件夹中的文件
4. 最佳实践
    - 性能优化
    - 错误处理
5. 小结
6. 参考资料

## 基础概念
在Python中，文件系统操作是通过标准库中的`os`模块和`pathlib`模块来完成的。`os`模块提供了与操作系统交互的功能，其中包含了许多用于文件和目录操作的函数。`pathlib`模块则是Python 3.4引入的面向对象的文件路径处理模块，它提供了更加直观和面向对象的方式来处理文件路径。

列出文件夹中的文件，本质上就是获取指定目录下的所有文件和子目录的名称列表，或者获取这些文件和目录的详细信息。

## 使用方法

### 使用`os.listdir()`
`os.listdir()`是`os`模块中用于列出指定目录下所有文件和目录名称的函数。其基本语法如下：

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

在上述代码中，首先导入`os`模块，然后定义了一个文件夹路径`folder_path`（这里使用当前目录`'.'`）。接着，使用`os.listdir()`函数获取该文件夹下的所有文件和目录名称，并存储在`file_list`列表中。最后，通过循环打印出每个文件和目录的名称。

### 使用`os.scandir()`
`os.scandir()`是Python 3.5引入的函数，它比`os.listdir()`更高效，因为它返回的是一个迭代器，迭代器中的每个元素是一个`DirEntry`对象，包含了文件或目录的详细信息，如名称、路径、是否为目录等。示例代码如下：

```python
import os

folder_path = '.'
with os.scandir(folder_path) as entries:
    for entry in entries:
        if entry.is_file():
            print(entry.name)
```

在这段代码中，使用`os.scandir()`打开指定文件夹，并通过迭代`entries`获取每个`DirEntry`对象。然后，通过`entry.is_file()`方法判断是否为文件，如果是，则打印其名称。

### 使用`pathlib`模块
`pathlib`模块提供了更直观的面向对象的方式来处理文件路径。以下是使用`pathlib`列出文件夹中文件的示例：

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file.name for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

这里首先从`pathlib`模块导入`Path`类，然后创建一个`Path`对象`folder_path`表示当前目录。通过`folder_path.iterdir()`方法获取目录下的所有文件和目录，再通过列表推导式筛选出文件，并获取其名称存储在`file_list`中，最后打印每个文件名。

## 常见实践

### 列出特定类型的文件
在实际应用中，常常需要列出特定类型的文件，比如只列出文件夹中的所有图片文件或文本文件。可以通过文件扩展名来进行筛选。以下是列出当前目录下所有`txt`文件的示例：

```python
import os

folder_path = '.'
for file in os.listdir(folder_path):
    if file.endswith('.txt'):
        print(file)
```

### 递归列出文件夹中的文件
有时候需要列出一个文件夹及其所有子文件夹中的文件。可以通过递归函数来实现。以下是使用`os.walk()`函数实现递归列出文件的示例：

```python
import os

folder_path = '.'
for root, dirs, files in os.walk(folder_path):
    for file in files:
        print(os.path.join(root, file))
```

在上述代码中，`os.walk()`函数会递归遍历指定目录及其所有子目录。`root`表示当前目录路径，`dirs`表示当前目录下的所有子目录名称列表，`files`表示当前目录下的所有文件名称列表。通过循环遍历`files`并使用`os.path.join()`函数将文件路径和文件名拼接起来，打印出完整的文件路径。

## 最佳实践

### 性能优化
如果需要处理大量文件，`os.scandir()`通常比`os.listdir()`更高效，因为它返回的是迭代器，而不是一次性将所有文件和目录信息加载到内存中。同时，使用`pathlib`模块在处理路径操作时更加直观和面向对象，在性能上也有不错的表现。

### 错误处理
在进行文件系统操作时，可能会遇到各种错误，如文件夹不存在、权限不足等。因此，需要进行适当的错误处理。以下是一个简单的错误处理示例：

```python
import os

folder_path = 'non_existent_folder'
try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在")
except PermissionError:
    print(f"没有访问文件夹 {folder_path} 的权限")
```

在上述代码中，使用`try-except`语句捕获可能出现的`FileNotFoundError`和`PermissionError`异常，并进行相应的处理。

## 小结
本文详细介绍了在Python中列出文件夹中文件的多种方法，包括使用`os.listdir()`、`os.scandir()`和`pathlib`模块。同时，探讨了常见实践，如列出特定类型的文件和递归列出文件，以及最佳实践，如性能优化和错误处理。通过掌握这些知识和技巧，读者能够更加高效地处理文件系统相关的任务，在Python编程中更加得心应手。

## 参考资料