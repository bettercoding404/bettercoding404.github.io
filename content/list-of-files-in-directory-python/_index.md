---
title: "在Python中获取目录中的文件列表"
description: "在Python编程中，经常需要处理文件和目录。获取目录中的文件列表是一项基础且实用的操作。无论是进行数据处理、文件管理还是开发各种应用程序，能够准确地列出指定目录下的文件都是非常关键的一步。本文将深入探讨在Python中获取目录中文件列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---

<!-- more -->

## 简介
在Python编程中，经常需要处理文件和目录。获取目录中的文件列表是一项基础且实用的操作。无论是进行数据处理、文件管理还是开发各种应用程序，能够准确地列出指定目录下的文件都是非常关键的一步。本文将深入探讨在Python中获取目录中文件列表的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os`模块
    - 使用`pathlib`模块
3. 常见实践
    - 遍历多层目录
    - 筛选特定类型的文件
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织和管理文件的容器。获取目录中的文件列表，就是获取该目录下所有文件的名称集合。Python提供了不同的模块和方法来实现这一功能，主要涉及到`os`模块和`pathlib`模块。

`os`模块是Python标准库中用于与操作系统进行交互的模块，它提供了许多与文件和目录操作相关的函数。`pathlib`模块是Python 3.4及以上版本引入的，它提供了一种面向对象的方式来处理文件路径，相比`os`模块更加直观和易用。

## 使用方法

### 使用`os`模块
`os`模块中的`listdir`函数可以用于获取指定目录下的所有文件和目录的名称列表。以下是基本的代码示例：

```python
import os

# 获取当前目录下的文件和目录列表
file_list = os.listdir('.')
for file in file_list:
    print(file)
```

在上述代码中，`os.listdir('.')`中的`.`表示当前目录。如果要获取其他目录下的文件列表，只需将目录路径作为参数传入，例如`os.listdir('/path/to/directory')`。

然而，`os.listdir`返回的列表中包含文件和目录的名称，如果需要区分文件和目录，可以使用`os.path.isfile`和`os.path.isdir`函数进行判断：

```python
import os

# 获取当前目录下的文件列表
file_list = []
for item in os.listdir('.'):
    item_path = os.path.join('.', item)
    if os.path.isfile(item_path):
        file_list.append(item)

for file in file_list:
    print(file)
```

### 使用`pathlib`模块
`pathlib`模块中的`Path`类提供了更方便的方法来处理文件路径。要获取目录中的文件列表，可以使用`Path.iterdir`方法：

```python
from pathlib import Path

# 获取当前目录下的文件列表
file_list = []
for item in Path('.').iterdir():
    if item.is_file():
        file_list.append(item.name)

for file in file_list:
    print(file)
```

`Path.iterdir`方法返回一个可迭代对象，包含目录中的所有项。通过`item.is_file()`方法可以判断该项是否为文件。

## 常见实践

### 遍历多层目录
有时候需要遍历目录及其所有子目录中的文件。使用`os`模块可以通过`os.walk`函数来实现：

```python
import os

# 遍历目录及其所有子目录中的文件
for root, dirs, files in os.walk('.'):
    for file in files:
        file_path = os.path.join(root, file)
        print(file_path)
```

`os.walk`函数会递归地遍历指定目录及其所有子目录，`root`表示当前目录路径，`dirs`表示当前目录下的子目录列表，`files`表示当前目录下的文件列表。

使用`pathlib`模块也可以实现类似功能，通过递归调用`Path.iterdir`方法：

```python
from pathlib import Path

def list_files_recursively(directory):
    file_list = []
    for item in Path(directory).iterdir():
        if item.is_file():
            file_list.append(item)
        elif item.is_dir():
            file_list.extend(list_files_recursively(item))
    return file_list

# 获取当前目录及其所有子目录中的文件列表
files = list_files_recursively('.')
for file in files:
    print(file)
```

### 筛选特定类型的文件
在实际应用中，常常需要筛选出特定类型的文件，例如只获取`.txt`文件。可以通过检查文件的扩展名来实现：

```python
import os

# 获取当前目录下的所有txt文件
txt_file_list = []
for item in os.listdir('.'):
    item_path = os.path.join('.', item)
    if os.path.isfile(item_path) and item.endswith('.txt'):
        txt_file_list.append(item)

for file in txt_file_list:
    print(file)
```

使用`pathlib`模块同样可以实现：

```python
from pathlib import Path

# 获取当前目录下的所有txt文件
txt_file_list = []
for item in Path('.').iterdir():
    if item.is_file() and item.suffix == '.txt':
        txt_file_list.append(item.name)

for file in txt_file_list:
    print(file)
```

## 最佳实践

### 错误处理
在获取文件列表时，可能会遇到目录不存在等错误情况。因此，进行适当的错误处理是很有必要的。使用`os`模块时，可以使用`try - except`语句来捕获可能的异常：

```python
import os

directory = '/nonexistent/directory'
try:
    file_list = os.listdir(directory)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"目录 {directory} 不存在")
```

使用`pathlib`模块时，也可以进行类似的错误处理：

```python
from pathlib import Path

directory = Path('/nonexistent/directory')
if directory.exists():
    file_list = []
    for item in directory.iterdir():
        if item.is_file():
            file_list.append(item.name)
    for file in file_list:
        print(file)
else:
    print(f"目录 {directory} 不存在")
```

### 性能优化
如果目录中包含大量文件，获取文件列表的操作可能会比较耗时。为了提高性能，可以考虑使用生成器来逐一生成文件列表，而不是一次性将所有文件加载到内存中。使用`os.walk`函数时，可以将其作为生成器使用：

```python
import os

def file_generator(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            yield os.path.join(root, file)

# 使用生成器遍历文件
for file_path in file_generator('.'):
    print(file_path)
```

使用`pathlib`模块时，也可以通过生成器来提高性能：

```python
from pathlib import Path

def file_generator(directory):
    for item in Path(directory).rglob('*'):
        if item.is_file():
            yield item

# 使用生成器遍历文件
for file in file_generator('.'):
    print(file)
```

## 小结
在Python中获取目录中的文件列表有多种方法，`os`模块和`pathlib`模块都提供了相应的功能。`os`模块是Python标准库中传统的文件和目录操作模块，而`pathlib`模块提供了更加面向对象和直观的方式。在实际应用中，需要根据具体需求选择合适的方法，并注意进行错误处理和性能优化。掌握这些知识和技巧，能够帮助开发者更加高效地处理文件和目录相关的任务。

## 参考资料
- 《Python Cookbook》