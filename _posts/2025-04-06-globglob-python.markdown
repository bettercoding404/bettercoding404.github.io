---
title: "深入探索 Python 中的 glob.glob"
description: "在 Python 的文件处理与路径操作领域，`glob.glob` 是一个强大且实用的工具。它提供了一种简单直观的方式来根据特定模式查找文件路径名。无论是处理大量文件、按特定规则筛选文件，还是在不同操作系统上进行统一的文件路径匹配，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握这一功能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 的文件处理与路径操作领域，`glob.glob` 是一个强大且实用的工具。它提供了一种简单直观的方式来根据特定模式查找文件路径名。无论是处理大量文件、按特定规则筛选文件，还是在不同操作系统上进行统一的文件路径匹配，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者熟练掌握这一功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 基本用法
    - 递归匹配
    - 特定模式匹配
3. **常见实践**
    - 文件批量处理
    - 特定类型文件查找
4. **最佳实践**
    - 性能优化
    - 跨平台兼容性
5. **小结**
6. **参考资料**

## 基础概念
`glob` 是 Python 标准库中的一个模块，用于实现文件路径名的模式匹配。`glob.glob` 是该模块中最常用的函数，它接受一个路径名模式作为参数，并返回所有匹配该模式的路径名列表。路径名模式可以使用通配符来指定匹配规则，常见的通配符有：
- `*`：匹配任意数量（包括零个）的任意字符。
- `?`：匹配单个任意字符。

例如，`*.txt` 可以匹配当前目录下所有扩展名为 `.txt` 的文件；`file?.txt` 可以匹配文件名以 `file` 开头，后跟一个任意字符，扩展名为 `.txt` 的文件。

## 使用方法

### 基本用法
在当前目录下查找所有扩展名为 `.py` 的文件：

```python
import glob

file_list = glob.glob('*.py')
for file in file_list:
    print(file)
```

在上述代码中，`glob.glob('*.py')` 返回当前目录下所有 `.py` 文件的路径名列表，然后通过循环打印出每个文件名。

### 递归匹配
要递归地查找目录及其子目录中的文件，可以使用 `**` 通配符，并设置 `recursive=True` 参数。例如，查找当前目录及其所有子目录下的所有 `.txt` 文件：

```python
import glob

file_list = glob.glob('**/*.txt', recursive=True)
for file in file_list:
    print(file)
```

### 特定模式匹配
可以使用更复杂的模式进行匹配。例如，查找当前目录下文件名以 `test` 开头，后跟一个任意字符，扩展名为 `.py` 的文件：

```python
import glob

file_list = glob.glob('test?.py')
for file in file_list:
    print(file)
```

## 常见实践

### 文件批量处理
假设要对当前目录下所有的 `.txt` 文件进行内容读取和处理：

```python
import glob

file_list = glob.glob('*.txt')
for file in file_list:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
        # 在这里进行对文件内容的处理
        print(f"Processing {file}: {content[:50]}...")
```

### 特定类型文件查找
在一个复杂的项目目录结构中，查找所有的图片文件（假设图片文件扩展名为 `.jpg`、`.png` 和 `.jpeg`）：

```python
import glob

image_extensions = ['*.jpg', '*.png', '*.jpeg']
image_files = []
for ext in image_extensions:
    image_files.extend(glob.glob(f'**/{ext}', recursive=True))
for image in image_files:
    print(image)
```

## 最佳实践

### 性能优化
当处理大量文件或复杂目录结构时，性能可能成为一个问题。为了提高 `glob.glob` 的性能，可以考虑以下几点：
- **尽量避免使用递归匹配**：递归匹配会遍历整个目录树，开销较大。如果只需要在当前目录进行匹配，不要使用 `**` 通配符和 `recursive=True`。
- **缩小匹配范围**：在模式中尽可能明确路径和文件名信息，减少不必要的匹配。例如，如果知道文件在某个特定子目录下，先指定该子目录。

### 跨平台兼容性
`glob.glob` 在不同操作系统上的行为基本一致，但在处理路径分隔符时需要注意。为了确保代码在不同操作系统上都能正常工作，可以使用 `os.path.join` 来构建路径：

```python
import glob
import os

base_dir = os.path.expanduser('~')  # 用户主目录
pattern = os.path.join(base_dir, '*.txt')
file_list = glob.glob(pattern)
for file in file_list:
    print(file)
```

## 小结
`glob.glob` 是 Python 中一个非常实用的文件路径匹配工具，通过简单的模式匹配规则，可以轻松地查找和筛选文件。本文介绍了 `glob.glob` 的基础概念、多种使用方法、常见实践场景以及最佳实践。希望读者通过学习本文，能够在实际项目中灵活运用 `glob.glob`，提高文件处理的效率和代码的可读性。

## 参考资料
- [Python 官方文档 - glob 模块](https://docs.python.org/3/library/glob.html){: rel="nofollow"}
- 《Python 核心编程》
- [Stack Overflow - glob.glob 相关问题与解答](https://stackoverflow.com/questions/tagged/glob.glob){: rel="nofollow"}