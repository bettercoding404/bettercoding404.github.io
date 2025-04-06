---
title: "在Python中创建目录"
description: "在Python编程中，创建目录是一项常见的任务。无论是组织项目文件、存储临时数据还是为特定应用程序构建文件结构，了解如何在Python中创建目录都至关重要。本文将详细介绍在Python中创建目录的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要的编程技巧。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---

<!-- more -->

## 简介
在Python编程中，创建目录是一项常见的任务。无论是组织项目文件、存储临时数据还是为特定应用程序构建文件结构，了解如何在Python中创建目录都至关重要。本文将详细介绍在Python中创建目录的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一重要的编程技巧。

## 目录
1. 基础概念
2. 使用方法
    - 使用`os`模块
    - 使用`pathlib`模块
3. 常见实践
    - 创建单个目录
    - 创建多层级目录
4. 最佳实践
    - 错误处理
    - 确保目录结构的一致性
    - 与其他文件操作结合
5. 小结
6. 参考资料

## 基础概念
在操作系统中，目录（也称为文件夹）是用于组织和存储文件的容器。在Python中，创建目录意味着在文件系统中生成一个新的文件夹，你可以在其中存储相关的文件。理解文件路径的概念对于创建目录非常关键，文件路径指定了目录在文件系统中的位置。在Python中有绝对路径和相对路径之分：
- **绝对路径**：从文件系统的根目录开始，完整地指定目录的位置。例如在Windows系统中可能是`C:\Users\username\Documents\my_directory`，在Unix/Linux系统中可能是`/home/username/Documents/my_directory`。
- **相对路径**：相对于当前工作目录的路径。例如`new_folder`表示在当前工作目录下创建一个名为`new_folder`的目录。

## 使用方法

### 使用`os`模块
`os`模块是Python标准库的一部分，提供了许多与操作系统交互的功能，包括创建目录。以下是使用`os`模块创建目录的方法：

#### 创建单个目录
```python
import os

# 在当前工作目录下创建一个名为new_directory的目录
os.mkdir('new_directory')
```
在上述代码中，`os.mkdir()`函数接受一个参数，即要创建的目录的名称。如果目录已存在，将会引发`FileExistsError`异常。

#### 创建多层级目录
```python
import os

# 创建多层级目录，例如parent_directory/child_directory
os.makedirs('parent_directory/child_directory')
```
`os.makedirs()`函数可以创建多层级目录。如果中间的目录不存在，它会自动创建。同样，如果目录已存在，会引发`FileExistsError`异常。

### 使用`pathlib`模块
`pathlib`模块是Python 3.4及以上版本中引入的，它提供了一种面向对象的方式来处理文件路径。

#### 创建单个目录
```python
from pathlib import Path

# 在当前工作目录下创建一个名为new_directory的目录
Path('new_directory').mkdir()
```
#### 创建多层级目录
```python
from pathlib import Path

# 创建多层级目录，例如parent_directory/child_directory
Path('parent_directory/child_directory').mkdir(parents=True)
```
在使用`Path`类的`mkdir()`方法时，`parents=True`参数表示如果父目录不存在，会自动创建所有必要的父目录。

## 常见实践

### 创建单个目录
在许多情况下，你可能只需要在当前工作目录下创建一个简单的目录来存储相关文件。例如，你正在编写一个数据处理脚本，需要一个目录来存储处理后的结果：
```python
import os

result_dir ='results'
os.mkdir(result_dir)

# 后续可以将处理后的数据保存到这个目录中
```

### 创建多层级目录
当构建复杂的项目结构时，多层级目录是必不可少的。例如，一个Web项目可能需要以下目录结构：
```
project/
│
├── app/
│   ├── models/
│   ├── views/
│   └── controllers/
│
├── static/
│   ├── css/
│   ├── js/
│   └── images/
│
└── templates/
```
使用`os.makedirs()`或`pathlib`模块的`mkdir(parents=True)`方法可以轻松创建这样的目录结构：
```python
from pathlib import Path

project_dir = 'project'
app_dir = Path(project_dir) / 'app'
static_dir = Path(project_dir) /'static'
templates_dir = Path(project_dir) / 'templates'

app_dir.mkdir(parents=True)
static_dir.mkdir(parents=True)
templates_dir.mkdir(parents=True)

(Path(app_dir) /'models').mkdir(parents=True)
(Path(app_dir) / 'views').mkdir(parents=True)
(Path(app_dir) / 'controllers').mkdir(parents=True)

(Path(static_dir) / 'css').mkdir(parents=True)
(Path(static_dir) / 'js').mkdir(parents=True)
(Path(static_dir) / 'images').mkdir(parents=True)
```

## 最佳实践

### 错误处理
在创建目录时，务必进行错误处理，以确保程序的健壮性。例如，当目录已存在时，捕获`FileExistsError`异常并进行适当处理：
```python
import os

try:
    os.mkdir('new_directory')
except FileExistsError:
    print("目录已存在")
```
使用`pathlib`模块时类似：
```python
from pathlib import Path

try:
    Path('new_directory').mkdir()
except FileExistsError:
    print("目录已存在")
```

### 确保目录结构的一致性
在创建目录时，遵循一致的命名规范和结构有助于提高代码的可读性和可维护性。例如，所有项目相关的目录都以项目名称为前缀，并且目录名使用小写字母和下划线。

### 与其他文件操作结合
创建目录通常是文件操作的一部分。例如，在创建目录后，可能需要将文件写入该目录或者从该目录读取文件。确保在进行其他文件操作时，正确引用创建的目录路径。

```python
import os
from pathlib import Path

# 创建目录
dir_path = 'data'
os.makedirs(dir_path)

# 在创建的目录中写入文件
file_path = Path(dir_path) / 'example.txt'
with open(file_path, 'w') as f:
    f.write("这是一个示例文件")
```

## 小结
在Python中创建目录可以通过`os`模块和`pathlib`模块来实现。`os`模块提供了传统的函数式方法，而`pathlib`模块提供了更面向对象的方式。了解绝对路径和相对路径的概念，并在创建目录时进行适当的错误处理和遵循最佳实践，将有助于编写高效、健壮的代码。无论是简单的单个目录创建还是复杂的多层级目录结构构建，掌握这些技巧都能让你的编程工作更加顺利。

## 参考资料
- 《Python基础教程》
- 《Python Cookbook》

希望通过本文，你对在Python中创建目录有了更深入的理解和掌握。祝你在Python编程中取得更多的成果！  