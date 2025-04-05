---
title: "在 Python 中创建目录"
description: "在 Python 编程中，创建目录是一项常见的文件系统操作。无论是组织项目文件、存储临时数据还是管理用户生成的内容，能够动态创建目录都是非常有用的技能。本文将深入探讨在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一功能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---

<!-- more -->

## 简介
在 Python 编程中，创建目录是一项常见的文件系统操作。无论是组织项目文件、存储临时数据还是管理用户生成的内容，能够动态创建目录都是非常有用的技能。本文将深入探讨在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一功能。

## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `os` 模块
    - 使用 `pathlib` 模块
3. **常见实践**
    - 创建单层目录
    - 创建多层目录
4. **最佳实践**
    - 错误处理
    - 跨平台兼容性
5. **小结**
6. **参考资料**

## 基础概念
在计算机文件系统中，目录（也称为文件夹）是用于组织和存储文件及其他目录的容器。在 Python 中，创建目录就是在文件系统中生成一个新的文件夹，以便后续可以在其中存储文件或创建更多子目录。

## 使用方法

### 使用 `os` 模块
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中包含了许多操作文件和目录的函数。要使用 `os` 模块创建目录，可以使用 `os.mkdir()` 函数。

```python
import os

# 创建一个名为 new_directory 的单层目录
directory_name = 'new_directory'
os.mkdir(directory_name)
```

上述代码中，首先导入了 `os` 模块，然后定义了要创建的目录名称 `new_directory`，最后使用 `os.mkdir()` 函数创建了该目录。

如果要创建多层目录（即包含子目录的目录结构），可以使用 `os.makedirs()` 函数。

```python
import os

# 创建一个多层目录结构，parent_directory 下包含 sub_directory
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
path = os.path.join(parent_directory, sub_directory)
os.makedirs(path)
```

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本中引入的面向对象的文件路径处理模块，它提供了一种更直观、更符合 Python 风格的方式来处理文件路径和目录操作。

```python
from pathlib import Path

# 创建一个名为 new_directory 的单层目录
directory_name = 'new_directory'
Path(directory_name).mkdir()
```

创建多层目录时，`pathlib` 模块同样提供了方便的方法。

```python
from pathlib import Path

# 创建一个多层目录结构，parent_directory 下包含 sub_directory
parent_directory = 'parent_directory'
sub_directory ='sub_directory'
path = Path(parent_directory) / sub_directory
path.mkdir(parents=True)
```

在上述代码中，`Path(parent_directory) / sub_directory` 这一操作使用 `/` 运算符来组合路径，这是 `pathlib` 模块提供的简洁方式。`mkdir(parents=True)` 表示如果父目录不存在，会自动创建所有必要的父目录。

## 常见实践

### 创建单层目录
在很多情况下，我们只需要创建一个简单的单层目录。比如在一个数据处理项目中，我们可能需要创建一个目录来存储处理后的结果文件。

```python
import os

result_directory ='results'
os.mkdir(result_directory)
```

### 创建多层目录
当项目结构较为复杂时，多层目录结构可以更好地组织文件。例如，在一个 Web 项目中，我们可能需要创建如下目录结构：

```
project/
├── static/
│   ├── css/
│   └── js/
└── templates/
```

使用 `os.makedirs()` 可以这样创建：

```python
import os

project_directory = 'project'
static_directory = os.path.join(project_directory,'static')
css_directory = os.path.join(static_directory, 'css')
js_directory = os.path.join(static_directory, 'js')
templates_directory = os.path.join(project_directory, 'templates')

os.makedirs(css_directory)
os.makedirs(js_directory)
os.makedirs(templates_directory)
```

使用 `pathlib` 模块则可以这样写：

```python
from pathlib import Path

project_directory = Path('project')
static_directory = project_directory /'static'
css_directory = static_directory / 'css'
js_directory = static_directory / 'js'
templates_directory = project_directory / 'templates'

css_directory.mkdir(parents=True)
js_directory.mkdir(parents=True)
templates_directory.mkdir(parents=True)
```

## 最佳实践

### 错误处理
在创建目录时，可能会遇到各种错误，例如目录已存在、没有足够的权限等。因此，进行适当的错误处理是非常重要的。

使用 `os` 模块时，可以使用 `try - except` 块来捕获可能的错误。

```python
import os

directory_name = 'new_directory'
try:
    os.mkdir(directory_name)
except FileExistsError:
    print(f"目录 {directory_name} 已存在")
except PermissionError:
    print(f"没有权限创建目录 {directory_name}")
```

使用 `pathlib` 模块时，同样可以进行类似的错误处理。

```python
from pathlib import Path

directory_name = 'new_directory'
path = Path(directory_name)
try:
    path.mkdir()
except FileExistsError:
    print(f"目录 {directory_name} 已存在")
except PermissionError:
    print(f"没有权限创建目录 {directory_name}")
```

### 跨平台兼容性
不同的操作系统（如 Windows、Linux 和 macOS）在文件路径格式和目录操作上可能存在一些差异。为了确保代码具有良好的跨平台兼容性，推荐使用 `os.path.join()` 函数（`os` 模块）或 `pathlib` 模块。

`os.path.join()` 函数会根据当前操作系统的路径分隔符来正确组合路径。例如，在 Windows 上路径分隔符是 `\`，在 Linux 和 macOS 上是 `/`。

```python
import os

parent_directory = 'parent'
sub_directory ='sub'
path = os.path.join(parent_directory, sub_directory)
print(path)  # 在 Windows 上输出：parent\sub，在 Linux 和 macOS 上输出：parent/sub
```

`pathlib` 模块则自动处理了跨平台的路径格式问题，使得代码在不同操作系统上具有一致的行为。

## 小结
在 Python 中创建目录有多种方法，主要通过 `os` 模块和 `pathlib` 模块来实现。`os` 模块是标准库中经典的文件系统操作模块，而 `pathlib` 模块则提供了更面向对象、更符合 Python 风格的方式。在实际应用中，我们需要根据具体需求选择合适的模块和方法，并注意进行错误处理和确保跨平台兼容性。通过掌握这些知识和技巧，我们能够更高效地管理文件系统中的目录结构，为开发更健壮的 Python 应用程序打下坚实的基础。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/zh-cn/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - pathlib 模块](https://docs.python.org/zh-cn/3/library/pathlib.html){: rel="nofollow"}