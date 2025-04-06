---
title: "在 Python 中从目录中选取文件或目录：深入解析与实践"
description: "在 Python 编程中，处理文件和目录是一项常见任务。“how to pick from a directory in python” 即如何在 Python 中从目录里选取特定的文件或目录。这在许多场景下都非常有用，比如数据处理项目中需要选择特定格式的文件，或者系统管理脚本里需要对特定目录下的子目录进行操作等。本文将全面介绍相关的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---

<!-- more -->

## 简介
在 Python 编程中，处理文件和目录是一项常见任务。“how to pick from a directory in python” 即如何在 Python 中从目录里选取特定的文件或目录。这在许多场景下都非常有用，比如数据处理项目中需要选择特定格式的文件，或者系统管理脚本里需要对特定目录下的子目录进行操作等。本文将全面介绍相关的基础概念、使用方法、常见实践以及最佳实践，帮助读者掌握这一重要技能。

## 目录
1. 基础概念
2. 使用方法
    - 使用 `os` 模块
    - 使用 `pathlib` 模块
3. 常见实践
    - 按文件扩展名选取文件
    - 选取特定目录下的所有子目录
4. 最佳实践
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在 Python 中，文件系统操作主要围绕文件和目录展开。目录（也称为文件夹）是用于组织和存储文件的容器。从目录中选取意味着根据特定的条件（例如文件名模式、文件类型、目录层次结构等）从给定目录及其子目录中筛选出符合要求的文件或目录。这需要借助 Python 的标准库或第三方库来实现对文件系统的访问和操作。

## 使用方法

### 使用 `os` 模块
`os` 模块是 Python 标准库中用于与操作系统交互的模块，提供了许多处理文件和目录的函数。

#### 列出目录中的所有文件和目录
```python
import os

directory = '.'  # 当前目录
entries = os.listdir(directory)
for entry in entries:
    print(entry)
```
在上述代码中，`os.listdir` 函数返回指定目录下的所有文件和目录的名称列表。

#### 区分文件和目录
```python
import os

directory = '.'
entries = os.listdir(directory)
for entry in entries:
    entry_path = os.path.join(directory, entry)
    if os.path.isfile(entry_path):
        print(f"{entry} 是一个文件")
    elif os.path.isdir(entry_path):
        print(f"{entry} 是一个目录")
```
这里使用 `os.path.join` 函数将目录路径和文件名拼接成完整路径，然后通过 `os.path.isfile` 和 `os.path.isdir` 函数判断是文件还是目录。

### 使用 `pathlib` 模块
`pathlib` 模块是 Python 3.4 及以上版本引入的面向对象的文件路径处理模块，提供了更直观和易用的方式来处理文件和目录。

#### 列出目录中的所有文件和目录
```python
from pathlib import Path

directory = Path('.')
for entry in directory.iterdir():
    print(entry.name)
```
`Path` 对象的 `iterdir` 方法返回目录中的所有文件和目录的 `Path` 对象迭代器。

#### 区分文件和目录
```python
from pathlib import Path

directory = Path('.')
for entry in directory.iterdir():
    if entry.is_file():
        print(f"{entry.name} 是一个文件")
    elif entry.is_dir():
        print(f"{entry.name} 是一个目录")
```
通过 `Path` 对象的 `is_file` 和 `is_dir` 方法可以方便地判断是文件还是目录。

## 常见实践

### 按文件扩展名选取文件
假设要从一个目录中选取所有的 `.txt` 文件。

#### 使用 `os` 模块
```python
import os

directory = '.'
for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith('.txt'):
            file_path = os.path.join(root, file)
            print(file_path)
```
`os.walk` 函数用于遍历目录树，`root` 是当前目录路径，`dirs` 是当前目录下的子目录列表，`files` 是当前目录下的文件列表。通过 `file.endswith` 方法判断文件扩展名。

#### 使用 `pathlib` 模块
```python
from pathlib import Path

directory = Path('.')
txt_files = directory.glob('**/*.txt', recursive=True)
for txt_file in txt_files:
    print(txt_file)
```
`Path` 对象的 `glob` 方法用于按指定模式查找文件，`**` 表示递归匹配所有子目录，`recursive=True` 开启递归查找。

### 选取特定目录下的所有子目录
#### 使用 `os` 模块
```python
import os

parent_directory = '.'
subdirectories = [d for d in os.listdir(parent_directory) if os.path.isdir(os.path.join(parent_directory, d))]
for subdir in subdirectories:
    print(subdir)
```
通过列表推导式筛选出目录列表，并打印每个子目录名称。

#### 使用 `pathlib` 模块
```python
from pathlib import Path

parent_directory = Path('.')
subdirectories = [d for d in parent_directory.iterdir() if d.is_dir()]
for subdir in subdirectories:
    print(subdir.name)
```
同样使用列表推导式，利用 `Path` 对象的方法筛选出子目录并打印名称。

## 最佳实践

### 错误处理
在进行文件系统操作时，可能会遇到各种错误，如目录不存在、权限不足等。因此，良好的错误处理至关重要。

```python
import os
from pathlib import Path

directory = Path('.')
try:
    if not directory.exists():
        raise FileNotFoundError(f"目录 {directory} 不存在")
    for entry in directory.iterdir():
        print(entry.name)
except FileNotFoundError as e:
    print(e)
except PermissionError as e:
    print(f"权限不足: {e}")
```
通过 `try - except` 块捕获可能的错误并进行相应处理。

### 性能优化
当处理大量文件和目录时，性能优化很关键。例如，尽量减少不必要的文件系统访问，利用生成器而不是一次性加载所有文件列表等。

```python
from pathlib import Path

directory = Path('.')
def file_generator(directory):
    for entry in directory.iterdir():
        if entry.is_file():
            yield entry

file_gen = file_generator(directory)
for file in file_gen:
    # 处理文件的代码
    pass
```
这里使用生成器函数 `file_generator` 逐一生成文件对象，避免一次性加载所有文件。

## 小结
本文详细介绍了在 Python 中从目录选取文件或目录的相关内容。首先阐述了基础概念，接着介绍了使用 `os` 模块和 `pathlib` 模块的不同方法，包括列出目录内容、区分文件和目录。然后通过常见实践展示了按文件扩展名选取文件和选取特定目录下的子目录的具体实现。最后给出了错误处理和性能优化方面的最佳实践建议。希望读者通过本文能够深入理解并熟练运用这些知识，在 Python 编程中更高效地处理文件和目录操作。

## 参考资料
- 《Python 核心编程》