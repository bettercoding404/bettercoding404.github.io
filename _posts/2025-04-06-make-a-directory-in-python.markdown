---
title: "在 Python 中创建目录"
description: "在 Python 编程中，操作文件和目录是一项常见任务。创建目录（文件夹）是其中基础且重要的一环。无论是为了组织项目文件、存储数据，还是进行其他各种操作，了解如何在 Python 中创建目录都是必不可少的技能。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---

<!-- more -->

## 简介
在 Python 编程中，操作文件和目录是一项常见任务。创建目录（文件夹）是其中基础且重要的一环。无论是为了组织项目文件、存储数据，还是进行其他各种操作，了解如何在 Python 中创建目录都是必不可少的技能。本文将详细介绍在 Python 中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践。

## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `os` 模块**
    - **使用 `pathlib` 模块**
3. **常见实践**
    - **创建单个目录**
    - **创建多层嵌套目录**
4. **最佳实践**
    - **错误处理**
    - **跨平台兼容性**
5. **小结**
6. **参考资料**

## 基础概念
在计算机系统中，目录（或文件夹）是用于组织和管理文件的容器。它可以包含文件和其他子目录，形成层次化的结构。在 Python 中，我们可以使用不同的模块和函数来与文件系统进行交互，从而创建目录。主要涉及到的模块有 `os` 和 `pathlib`，它们提供了丰富的功能来处理文件和目录相关的操作。

## 使用方法

### 使用 `os` 模块
`os` 模块是 Python 标准库中用于与操作系统进行交互的模块，其中包含了许多操作文件和目录的函数。要使用 `os` 模块创建目录，可以使用 `os.mkdir()` 函数。

```python
import os

# 创建单个目录
directory_name = "new_directory"
os.mkdir(directory_name)
```

在上述代码中，我们首先导入了 `os` 模块。然后定义了一个目录名 `new_directory`，接着使用 `os.mkdir()` 函数创建了这个目录。

如果要创建多层嵌套目录，可以使用 `os.makedirs()` 函数。

```python
import os

# 创建多层嵌套目录
nested_directory = "parent_directory/child_directory"
os.makedirs(nested_directory)
```

在这个例子中，`os.makedirs()` 函数会自动创建 `parent_directory` 以及它的子目录 `child_directory`。

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本引入的，它提供了一种面向对象的方式来处理文件路径。使用 `pathlib` 创建目录可以使用 `Path.mkdir()` 方法。

```python
from pathlib import Path

# 创建单个目录
directory = Path("new_directory_pathlib")
directory.mkdir()
```

这里我们从 `pathlib` 模块中导入了 `Path` 类，然后创建了一个 `Path` 对象，表示要创建的目录路径。接着调用 `mkdir()` 方法创建目录。

对于创建多层嵌套目录，可以在调用 `mkdir()` 方法时传入 `parents=True` 参数。

```python
from pathlib import Path

# 创建多层嵌套目录
nested_dir = Path("parent_dir_pathlib/child_dir_pathlib")
nested_dir.mkdir(parents=True)
```

## 常见实践

### 创建单个目录
在许多情况下，我们只需要创建一个简单的单个目录。比如在一个数据处理项目中，我们可能需要创建一个目录来存储处理后的结果。

```python
import os

result_dir = "processed_results"
os.mkdir(result_dir)
```

或者使用 `pathlib` 模块：

```python
from pathlib import Path

result_dir_pathlib = Path("processed_results_pathlib")
result_dir_pathlib.mkdir()
```

### 创建多层嵌套目录
当项目结构较为复杂时，可能需要创建多层嵌套的目录结构。例如在一个大型的 Web 项目中，可能有不同的模块，每个模块又有自己的子模块和资源目录。

```python
import os

project_structure = "project/modules/module1/resources"
os.makedirs(project_structure)
```

使用 `pathlib` 模块实现相同功能：

```python
from pathlib import Path

project_structure_pathlib = Path("project_pathlib/modules_pathlib/module1_pathlib/resources_pathlib")
project_structure_pathlib.mkdir(parents=True)
```

## 最佳实践

### 错误处理
在创建目录时，可能会遇到各种错误，比如目录已经存在、权限不足等。因此，进行适当的错误处理是非常重要的。

使用 `os` 模块时，可以通过捕获异常来处理错误：

```python
import os

directory_to_create = "new_dir"
try:
    os.mkdir(directory_to_create)
except FileExistsError:
    print(f"目录 {directory_to_create} 已经存在")
except PermissionError:
    print("没有足够的权限创建目录")
```

使用 `pathlib` 模块时，也可以进行类似的错误处理：

```python
from pathlib import Path

directory_to_create_pathlib = Path("new_dir_pathlib")
try:
    directory_to_create_pathlib.mkdir()
except FileExistsError:
    print(f"目录 {directory_to_create_pathlib} 已经存在")
except PermissionError:
    print("没有足够的权限创建目录")
```

### 跨平台兼容性
Python 代码可能需要在不同的操作系统上运行，如 Windows、Linux 和 macOS。`os` 模块在不同操作系统上基本能正常工作，但 `pathlib` 模块在处理路径时更加跨平台友好。例如，在 Windows 系统中路径分隔符是 `\`，而在 Linux 和 macOS 中是 `/`。`pathlib` 模块会自动处理这些差异，确保代码在不同平台上都能正确运行。

```python
from pathlib import Path

# 无论在什么操作系统，都能正确处理路径
cross_platform_dir = Path("cross_platform/new_dir")
cross_platform_dir.mkdir(parents=True)
```

## 小结
在 Python 中创建目录可以通过 `os` 模块和 `pathlib` 模块来实现。`os` 模块是 Python 标准库中常用的与操作系统交互的模块，提供了 `mkdir()` 和 `makedirs()` 函数来创建单个和多层目录。`pathlib` 模块则提供了更面向对象的方式，使用 `Path` 类和 `mkdir()` 方法。在实际应用中，我们需要根据具体需求选择合适的方法，并注意进行错误处理和保证跨平台兼容性。

## 参考资料