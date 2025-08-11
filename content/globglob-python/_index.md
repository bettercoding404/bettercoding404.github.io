---
title: "深入探索 Python 中的 glob.glob"
description: "在 Python 的文件处理和路径操作领域，`glob.glob` 是一个极为实用的工具。它提供了一种简单直观的方式来根据特定模式匹配文件路径名，在处理大量文件时，能够极大地提高开发效率。无论是数据处理、脚本编写还是项目自动化，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握这一强大功能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的文件处理和路径操作领域，`glob.glob` 是一个极为实用的工具。它提供了一种简单直观的方式来根据特定模式匹配文件路径名，在处理大量文件时，能够极大地提高开发效率。无论是数据处理、脚本编写还是项目自动化，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握这一强大功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 基本语法
    - 简单模式匹配
    - 递归匹配
3. **常见实践**
    - 文件批量处理
    - 特定格式文件查找
4. **最佳实践**
    - 性能优化
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
`glob` 是 Python 标准库中的一个模块，用于文件路径名的模式匹配。`glob.glob` 函数是该模块的核心，它接受一个路径名模式作为参数，并返回与该模式匹配的所有文件路径名的列表。模式可以包含特殊字符，如 `*`（匹配任意数量的任意字符）和 `?`（匹配单个任意字符），这些特殊字符在正则表达式中也有类似的功能，但 `glob` 的模式匹配相对更简单和直观。

## 使用方法

### 基本语法
`glob.glob` 的基本语法如下：
```python
import glob

file_list = glob.glob(pathname, recursive=False)
```
- `pathname`：必需参数，指定要匹配的路径名模式。
- `recursive`：可选参数，默认为 `False`。如果设置为 `True`，则会递归匹配指定目录及其所有子目录中的文件路径。

### 简单模式匹配
以下是一些简单模式匹配的示例：
```python
import glob

# 匹配当前目录下的所有.py 文件
file_list = glob.glob('*.py')
for file in file_list:
    print(file)

# 匹配当前目录下的所有文件
all_files = glob.glob('*')
for file in all_files:
    print(file)
```
在上述示例中，`*.py` 模式匹配当前目录下所有以 `.py` 结尾的文件，`*` 模式则匹配当前目录下的所有文件。

### 递归匹配
要进行递归匹配，可以将 `recursive` 参数设置为 `True`：
```python
import glob

# 递归匹配当前目录及其所有子目录下的所有.py 文件
recursive_file_list = glob.glob('**/*.py', recursive=True)
for file in recursive_file_list:
    print(file)
```
在这个例子中，`**/*.py` 模式表示递归匹配所有目录下的 `.py` 文件。`**` 是递归匹配的特殊字符，它可以匹配任意数量的目录层级。

## 常见实践

### 文件批量处理
在数据处理项目中，经常需要对一组具有相同扩展名的文件进行批量处理。例如，有一组文本文件，需要读取并统计每个文件中的单词数量：
```python
import glob

def count_words_in_files():
    file_list = glob.glob('*.txt')
    for file in file_list:
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()
            word_count = len(content.split())
            print(f'{file} 中的单词数量: {word_count}')

count_words_in_files()
```
在这个示例中，首先使用 `glob.glob` 获取当前目录下所有的 `.txt` 文件列表，然后遍历该列表，对每个文件进行读取和单词数量统计。

### 特定格式文件查找
有时需要查找特定格式的文件，例如在一个项目目录中查找所有的配置文件（通常以 `.conf` 结尾）：
```python
import glob

config_files = glob.glob('**/*.conf', recursive=True)
for config in config_files:
    print(config)
```
这段代码会递归查找项目目录及其所有子目录下的所有 `.conf` 文件，并打印出它们的路径。

## 最佳实践

### 性能优化
当处理大量文件时，性能可能成为一个问题。为了提高性能，可以尽量减少递归匹配的使用，因为递归匹配需要遍历更多的目录层级，消耗更多的时间和资源。如果只需要在特定目录层级进行匹配，应避免使用 `**` 递归匹配模式。

### 错误处理
在使用 `glob.glob` 时，可能会遇到路径不存在或权限不足等问题。为了确保程序的健壮性，应添加适当的错误处理代码：
```python
import glob
import os

try:
    file_list = glob.glob('some_non_existent_path/*.py')
    for file in file_list:
        if os.path.isfile(file):
            # 进行文件处理操作
            pass
except Exception as e:
    print(f'发生错误: {e}')
```
在这个示例中，使用 `try - except` 块捕获可能出现的异常，并打印错误信息。同时，在处理文件列表时，使用 `os.path.isfile` 检查路径是否为有效文件，避免对目录或不存在的路径进行错误操作。

## 小结
`glob.glob` 是 Python 中一个非常实用的文件路径匹配工具，通过简单的模式匹配语法，能够方便地获取符合特定规则的文件路径列表。在实际应用中，掌握其基本概念、使用方法以及最佳实践，可以提高文件处理的效率和代码的健壮性。无论是初学者还是有经验的开发者，都能从合理运用 `glob.glob` 中受益。

## 参考资料
- [Python 官方文档 - glob 模块](https://docs.python.org/3/library/glob.html)
- 《Python 核心编程》
- 各种 Python 技术论坛和博客

希望通过本文的介绍，你对 `glob.glob` 有了更深入的理解，并能在实际项目中灵活运用。如果你有任何问题或建议，欢迎在评论区留言。 