---
title: "深入理解Python中的文件列表操作：列出文件夹中的文件"
description: "在Python编程中，处理文件和文件夹是一项常见的任务。能够列出文件夹中的文件列表，对于文件管理、数据处理、自动化脚本编写等多个领域都非常关键。本文将详细探讨如何使用Python获取文件夹中的文件列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的编程技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，处理文件和文件夹是一项常见的任务。能够列出文件夹中的文件列表，对于文件管理、数据处理、自动化脚本编写等多个领域都非常关键。本文将详细探讨如何使用Python获取文件夹中的文件列表，涵盖基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一重要的编程技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os`模块
    - 使用`pathlib`模块
3. 常见实践
    - 遍历多层文件夹
    - 筛选特定类型的文件
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在Python中，文件系统操作主要涉及到对文件和文件夹的各种操作。获取文件夹中的文件列表，简单来说，就是获取指定文件夹路径下所有文件的名称（包括文件扩展名）。这可以帮助我们对文件夹中的内容进行查看、分类、处理等操作。例如，在一个包含多个数据文件的文件夹中，我们可能需要获取所有CSV文件的列表，以便进行数据处理。

## 使用方法

### 使用`os`模块
`os`模块是Python标准库中用于操作系统相关功能的模块，其中`listdir`函数可以用来获取指定目录下的所有文件和文件夹的名称列表。

```python
import os

folder_path = '.'  # 当前目录
file_list = os.listdir(folder_path)
for file in file_list:
    print(file)
```

在上述代码中：
1. 首先导入`os`模块。
2. 定义了一个`folder_path`变量，这里使用`'.'`表示当前目录。
3. 使用`os.listdir`函数获取指定目录下的文件和文件夹名称列表，并存储在`file_list`中。
4. 最后通过循环打印出列表中的每个元素。

如果需要获取文件的完整路径，可以结合`os.path.join`函数：

```python
import os

folder_path = '.'
file_list = os.listdir(folder_path)
for file in file_list:
    full_path = os.path.join(folder_path, file)
    if os.path.isfile(full_path):
        print(full_path)
```

这里通过`os.path.join`将文件夹路径和文件名拼接成完整路径，再使用`os.path.isfile`判断是否为文件，只有文件才会被打印。

### 使用`pathlib`模块
`pathlib`模块是Python 3.4及以上版本引入的面向对象的文件路径操作模块，使用起来更加直观和方便。

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file for file in folder_path.iterdir() if file.is_file()]
for file in file_list:
    print(file)
```

在这段代码中：
1. 从`pathlib`模块导入`Path`类。
2. 创建一个`Path`对象`folder_path`，表示当前目录。
3. 使用列表推导式获取文件夹中所有文件的路径对象列表。`folder_path.iterdir()`遍历目录中的所有项，`file.is_file()`判断该项是否为文件。
4. 最后循环打印出文件路径。

## 常见实践

### 遍历多层文件夹
有时候我们需要遍历文件夹及其所有子文件夹中的文件。使用`os`模块的`walk`函数可以实现这一点：

```python
import os

folder_path = '.'
for root, dirs, files in os.walk(folder_path):
    for file in files:
        full_path = os.path.join(root, file)
        print(full_path)
```

`os.walk`函数会递归地遍历指定目录及其子目录，`root`表示当前目录路径，`dirs`表示当前目录下的子目录列表，`files`表示当前目录下的文件列表。

使用`pathlib`模块也可以实现类似功能：

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file for file in folder_path.rglob('*') if file.is_file()]
for file in file_list:
    print(file)
```

`rglob`方法会递归地搜索指定路径下的所有文件，`'*'`表示匹配所有文件。

### 筛选特定类型的文件
在实际应用中，我们通常只对特定类型的文件感兴趣，比如只获取所有的图片文件或文本文件。以下是使用`os`模块筛选Python文件的示例：

```python
import os

folder_path = '.'
file_list = os.listdir(folder_path)
for file in file_list:
    if file.endswith('.py'):
        full_path = os.path.join(folder_path, file)
        print(full_path)
```

使用`pathlib`模块实现同样功能：

```python
from pathlib import Path

folder_path = Path('.')
file_list = [file for file in folder_path.iterdir() if file.is_file() and file.suffix == '.py']
for file in file_list:
    print(file)
```

## 最佳实践

### 错误处理
在进行文件系统操作时，可能会遇到各种错误，比如文件夹不存在、权限不足等。因此，进行适当的错误处理是很重要的。

```python
import os
from pathlib import Path

folder_path = Path('nonexistent_folder')

try:
    if folder_path.exists():
        file_list = [file for file in folder_path.iterdir() if file.is_file()]
        for file in file_list:
            print(file)
    else:
        print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有访问文件夹 {folder_path} 的权限。")
```

### 性能优化
当处理大量文件时，性能优化就变得至关重要。避免不必要的文件访问和操作，合理使用生成器等方式可以提高效率。例如，使用生成器来遍历文件列表可以减少内存占用：

```python
from pathlib import Path

folder_path = Path('.')


def file_generator(folder):
    for file in folder.iterdir():
        if file.is_file():
            yield file


file_gen = file_generator(folder_path)
for file in file_gen:
    print(file)
```

## 小结
本文详细介绍了在Python中获取文件夹中文件列表的方法，包括使用`os`模块和`pathlib`模块。我们探讨了基础概念、不同的使用方法，以及常见实践，如遍历多层文件夹和筛选特定类型的文件。同时，还介绍了一些最佳实践，如错误处理和性能优化。通过掌握这些知识和技巧，读者能够更加高效地处理文件系统相关的任务，为编写健壮、高效的Python程序打下坚实的基础。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}