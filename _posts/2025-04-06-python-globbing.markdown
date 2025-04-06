---
title: "Python Globbing：文件路径模式匹配的利器"
description: "在处理文件和目录时，我们常常需要根据特定的模式来查找一组文件。Python 的 `globbing` 机制提供了一种简单而强大的方式来实现这一目标。`globbing` 允许我们使用特定的通配符模式来匹配文件名和目录名，从而方便地获取满足特定条件的文件列表。本文将深入探讨 Python `globbing` 的基础概念、使用方法、常见实践以及最佳实践，帮助你在文件操作中更加高效地运用这一特性。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在处理文件和目录时，我们常常需要根据特定的模式来查找一组文件。Python 的 `globbing` 机制提供了一种简单而强大的方式来实现这一目标。`globbing` 允许我们使用特定的通配符模式来匹配文件名和目录名，从而方便地获取满足特定条件的文件列表。本文将深入探讨 Python `globbing` 的基础概念、使用方法、常见实践以及最佳实践，帮助你在文件操作中更加高效地运用这一特性。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 简单通配符
    - 递归匹配
3. **常见实践**
    - 查找特定类型的文件
    - 遍历多层目录
4. **最佳实践**
    - 性能优化
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
`Globbing` 是一种使用特定字符作为通配符来匹配文件名或目录名的机制。在 Python 中，主要通过 `glob` 模块来实现 `globbing` 功能。以下是一些常见的通配符及其含义：
- `*`：匹配任意数量（包括零个）的任意字符。例如，`*.txt` 可以匹配所有以 `.txt` 结尾的文件。
- `?`：匹配单个任意字符。例如，`file?.txt` 可以匹配 `file1.txt`、`file2.txt` 等，但不能匹配 `file.txt`。

## 使用方法

### 简单通配符
使用 `glob` 模块的 `glob` 函数可以进行简单的文件路径模式匹配。以下是一个基本示例：

```python
import glob

# 获取当前目录下所有的.py 文件
file_list = glob.glob('*.py')
for file in file_list:
    print(file)
```

在上述代码中，`glob.glob('*.py')` 会返回当前目录下所有以 `.py` 结尾的文件列表。然后通过循环打印出每个文件名。

### 递归匹配
如果需要递归地匹配目录及其子目录中的文件，可以使用 `**` 通配符。不过，需要在 `glob` 函数中设置 `recursive=True` 参数。

```python
import glob

# 获取当前目录及其所有子目录下的所有.py 文件
file_list = glob.glob('**/*.py', recursive=True)
for file in file_list:
    print(file)
```

这段代码中，`glob.glob('**/*.py', recursive=True)` 会递归地搜索当前目录及其所有子目录，返回所有以 `.py` 结尾的文件列表。

## 常见实践

### 查找特定类型的文件
假设我们要查找项目目录下所有的图片文件（`.jpg`、`.png` 等），可以使用以下代码：

```python
import glob

image_extensions = ['*.jpg', '*.png', '*.jpeg']
image_files = []
for ext in image_extensions:
    image_files.extend(glob.glob(f'**/{ext}', recursive=True))

for image in image_files:
    print(image)
```

在这个示例中，我们定义了一个包含多种图片文件扩展名的列表，然后通过循环遍历这些扩展名，使用 `glob` 函数查找所有匹配的图片文件，并将结果合并到 `image_files` 列表中。

### 遍历多层目录
有时候我们需要对多层目录进行操作，例如统计每个目录下的文件数量。可以结合 `glob` 和 `os` 模块来实现：

```python
import glob
import os

# 获取所有目录
dir_list = glob.glob('**/', recursive=True)

for directory in dir_list:
    file_count = len(glob.glob(f'{directory}*'))
    print(f'{directory}: {file_count} files')
```

这段代码首先使用 `glob` 函数获取所有的目录，然后对于每个目录，再次使用 `glob` 函数统计该目录下的文件数量，并打印结果。

## 最佳实践

### 性能优化
在处理大量文件和目录时，性能是一个重要考虑因素。尽量避免使用过于复杂的通配符模式，因为这可能会导致搜索范围过大，影响性能。例如，如果只需要查找当前目录下的文件，避免使用递归匹配（`**`）。

### 错误处理
在使用 `glob` 函数时，可能会遇到文件路径不存在或权限不足等问题。建议进行适当的错误处理，例如：

```python
import glob

try:
    file_list = glob.glob('*.py')
    for file in file_list:
        print(file)
except Exception as e:
    print(f'Error: {e}')
```

这样可以在出现问题时捕获异常并进行相应处理，提高程序的健壮性。

## 小结
Python 的 `globbing` 机制通过 `glob` 模块为我们提供了便捷的文件路径模式匹配功能。通过简单的通配符，我们可以轻松地查找特定类型的文件，遍历多层目录等。在实际应用中，遵循最佳实践，如性能优化和错误处理，可以使我们的代码更加高效和健壮。希望本文能帮助你更好地理解和运用 Python `globbing`，在文件操作中更加得心应手。

## 参考资料
- [Python官方文档 - glob模块](https://docs.python.org/3/library/glob.html){: rel="nofollow"}
- [Learn Enough Command Line Tutorial - Globbing](https://www.learnenough.com/command-tutorial/basics#sec-globbing){: rel="nofollow"}