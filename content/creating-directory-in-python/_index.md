---
title: "在Python中创建目录"
description: "在Python编程中，处理文件和目录是一项常见任务。创建目录是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是构建复杂的文件系统结构，掌握在Python中创建目录的方法都至关重要。本文将深入探讨在Python中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一功能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---

<!-- more -->

## 简介
在Python编程中，处理文件和目录是一项常见任务。创建目录是其中基础且重要的操作之一。无论是组织项目文件、存储临时数据还是构建复杂的文件系统结构，掌握在Python中创建目录的方法都至关重要。本文将深入探讨在Python中创建目录的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地运用这一功能。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os`模块创建目录
    - 使用`pathlib`模块创建目录
3. 常见实践
    - 创建单级目录
    - 创建多级目录
4. 最佳实践
    - 错误处理
    - 确保目录结构的一致性
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织文件和其他目录的容器。在Python中，创建目录意味着在文件系统中生成一个新的目录对象，我们可以在其中存储文件或进一步创建子目录。不同的操作系统对目录的命名规则和路径分隔符略有不同，例如在Windows系统中路径分隔符是`\`，而在Unix-like系统（如Linux和macOS）中是`/`。Python提供了一些模块来处理这些差异，使得我们可以编写跨平台的代码来创建目录。

## 使用方法

### 使用`os`模块创建目录
`os`模块是Python标准库中用于与操作系统进行交互的模块，提供了许多操作文件和目录的函数。要使用`os`模块创建目录，可以使用`os.mkdir()`函数。该函数接受一个路径参数，用于指定要创建的目录的名称和位置。

```python
import os

# 创建单级目录
directory_name = 'new_directory'
os.mkdir(directory_name)
```

在上述代码中，我们使用`os.mkdir()`函数创建了一个名为`new_directory`的目录。如果指定的目录已经存在，`os.mkdir()`函数将引发`FileExistsError`异常。

如果要创建多级目录（即包含子目录的目录结构），可以使用`os.makedirs()`函数。

```python
import os

# 创建多级目录
nested_directory = 'parent_directory/child_directory'
os.makedirs(nested_directory)
```

`os.makedirs()`函数会自动创建所有必要的中间目录。如果在创建过程中某个目录已经存在，它将继续创建剩余的目录，而不会引发异常。

### 使用`pathlib`模块创建目录
`pathlib`模块是Python 3.4及以上版本中引入的标准库模块，提供了一种面向对象的方式来处理文件系统路径。使用`pathlib`模块创建目录更加直观和简洁。

```python
from pathlib import Path

# 创建单级目录
directory_name = 'new_directory'
Path(directory_name).mkdir()

# 创建多级目录
nested_directory = Path('parent_directory/child_directory')
nested_directory.mkdir(parents=True)
```

在上述代码中，首先使用`Path`类创建一个路径对象，然后调用`mkdir()`方法创建目录。对于创建多级目录，通过设置`parents=True`参数，`mkdir()`方法会自动创建所有必要的父目录。

## 常见实践

### 创建单级目录
创建单级目录是最基本的操作。通常用于在当前工作目录下创建一个简单的目录来存储相关文件。例如，在开发一个小型项目时，可能需要创建一个目录来存放项目生成的日志文件。

```python
import os

log_directory = 'logs'
os.mkdir(log_directory)
```

### 创建多级目录
在处理复杂项目时，往往需要创建一个多层次的目录结构来组织不同类型的文件。比如，一个Web应用项目可能需要一个如下的目录结构：

```
project/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── src/
│   ├── models/
│   ├── views/
│   └── controllers/
│
└── tests/
```

使用`os.makedirs()`或`pathlib`模块的`mkdir(parents=True)`方法可以很方便地创建这样的目录结构。

```python
import os

# 使用 os.makedirs() 创建多级目录
project_directory = 'project'
data_raw_directory = os.path.join(project_directory, 'data', 'raw')
data_processed_directory = os.path.join(project_directory, 'data', 'processed')
src_models_directory = os.path.join(project_directory,'src','models')
src_views_directory = os.path.join(project_directory,'src', 'views')
src_controllers_directory = os.path.join(project_directory,'src', 'controllers')
tests_directory = os.path.join(project_directory, 'tests')

os.makedirs(data_raw_directory)
os.makedirs(data_processed_directory)
os.makedirs(src_models_directory)
os.makedirs(src_views_directory)
os.makedirs(src_controllers_directory)
os.makedirs(tests_directory)

# 使用 pathlib 创建多级目录
from pathlib import Path

Path(data_raw_directory).mkdir(parents=True)
Path(data_processed_directory).mkdir(parents=True)
Path(src_models_directory).mkdir(parents=True)
Path(src_views_directory).mkdir(parents=True)
Path(src_controllers_directory).mkdir(parents=True)
Path(tests_directory).mkdir(parents=True)
```

## 最佳实践

### 错误处理
在创建目录时，应该始终进行错误处理，以确保程序的健壮性。例如，当尝试创建一个已经存在的目录时，`os.mkdir()`会引发`FileExistsError`异常，`pathlib`的`mkdir()`方法在相同情况下也会引发`FileExistsError`异常。我们可以使用`try - except`语句来捕获并处理这些异常。

```python
import os

directory_name = 'new_directory'
try:
    os.mkdir(directory_name)
except FileExistsError:
    print(f"目录 {directory_name} 已经存在")

from pathlib import Path

directory_name = 'new_directory'
try:
    Path(directory_name).mkdir()
except FileExistsError:
    print(f"目录 {directory_name} 已经存在")
```

### 确保目录结构的一致性
在创建目录时，尤其是多级目录，要确保目录结构的一致性和可读性。可以提前规划好目录结构，并使用有意义的名称。同时，尽量遵循操作系统和项目的约定，例如将配置文件放在`config`目录下，将日志文件放在`logs`目录下等。

## 小结
在Python中创建目录是一个相对简单但非常实用的操作。通过`os`模块和`pathlib`模块，我们可以轻松地创建单级或多级目录。在实际应用中，要注意错误处理和目录结构的规划，以提高代码的可靠性和可维护性。无论是小型脚本还是大型项目，掌握这些创建目录的方法都能帮助我们更好地组织和管理文件系统。

## 参考资料