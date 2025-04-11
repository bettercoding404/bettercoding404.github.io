---
title: "Python Globbing：文件路径模式匹配的利器"
description: "在Python编程中，处理文件和目录是常见的任务。而`globbing`是一种用于文件路径名模式匹配的机制，它提供了一种简洁且灵活的方式来指定一组文件或目录。通过特定的通配符，我们可以轻松地匹配文件名、目录名，从而方便地对一组相关文件进行批量操作。本文将深入探讨Python中的`globbing`，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，处理文件和目录是常见的任务。而`globbing`是一种用于文件路径名模式匹配的机制，它提供了一种简洁且灵活的方式来指定一组文件或目录。通过特定的通配符，我们可以轻松地匹配文件名、目录名，从而方便地对一组相关文件进行批量操作。本文将深入探讨Python中的`globbing`，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - `glob`模块的基本使用
    - 递归匹配
    - 不同操作系统下的差异
3. 常见实践
    - 文件批量处理
    - 特定目录结构遍历
4. 最佳实践
    - 性能优化
    - 代码可读性优化
5. 小结
6. 参考资料

## 基础概念
`Globbing`使用特定的字符作为通配符来表示文件名或目录名中的任意字符或字符序列。常见的通配符有：
- `*`：匹配任意数量（包括零个）的任意字符。例如，`*.txt`可以匹配所有以`.txt`结尾的文件。
- `?`：匹配单个任意字符。例如，`file?.txt`可以匹配`file1.txt`、`file2.txt`等，但不能匹配`file.txt`。

这些通配符让我们可以根据文件名的模式来选择一组文件，而不需要逐个指定文件名。

## 使用方法
### `glob`模块的基本使用
在Python中，`glob`模块提供了用于文件路径名模式匹配的功能。以下是基本的使用示例：

```python
import glob

# 获取当前目录下所有的.py文件
file_list = glob.glob('*.py')
for file in file_list:
    print(file)
```

在上述代码中，`glob.glob('*.py')`函数返回当前目录下所有以`.py`结尾的文件列表。然后通过循环遍历该列表，打印出每个文件名。

### 递归匹配
如果要递归地匹配目录及其子目录中的文件，可以使用`**`通配符。但需要设置`recursive=True`参数。

```python
import glob

# 获取当前目录及其所有子目录下的所有.py文件
file_list = glob.glob('**/*.py', recursive=True)
for file in file_list:
    print(file)
```

### 不同操作系统下的差异
虽然`glob`模块在不同操作系统上都能工作，但在一些特殊字符和路径分隔符的处理上可能会有差异。例如，在Windows系统上路径分隔符是`\`，而在Unix-like系统上是`/`。`glob`模块会自动处理这些差异，使得代码在不同操作系统上具有较好的兼容性。

## 常见实践
### 文件批量处理
假设我们有一个目录，里面包含多个文本文件，我们需要对这些文件进行批量处理，例如读取每个文件的内容并进行统计分析。

```python
import glob

# 获取所有的.txt文件
file_list = glob.glob('*.txt')
for file in file_list:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
        word_count = len(content.split())
        print(f"{file} 单词数: {word_count}")
```

### 特定目录结构遍历
有时候我们需要遍历特定目录结构下的文件。例如，在一个项目目录中，我们只想处理`src`目录下的所有Python文件。

```python
import glob

# 获取src目录及其子目录下的所有.py文件
file_list = glob.glob('src/**/*.py', recursive=True)
for file in file_list:
    print(file)
```

## 最佳实践
### 性能优化
在处理大量文件时，性能是一个重要的考虑因素。尽量避免不必要的递归匹配，因为递归匹配会遍历大量的目录和文件，消耗较多的时间和资源。如果只需要匹配一级目录下的文件，就不要使用`**`通配符。

### 代码可读性优化
为了提高代码的可读性，可以将`glob`模式匹配的逻辑封装成函数。这样在主代码中调用函数时，代码结构更加清晰。

```python
import glob


def get_py_files_in_dir(dir_path):
    return glob.glob(f"{dir_path}/*.py")


file_list = get_py_files_in_dir('.')
for file in file_list:
    print(file)
```

## 小结
Python的`globbing`通过`glob`模块为我们提供了强大而灵活的文件路径模式匹配功能。通过掌握通配符的使用方法，我们可以轻松地处理各种文件和目录匹配需求。在实际应用中，结合常见实践和最佳实践，可以提高代码的效率和可读性，使文件处理任务更加高效和可靠。

## 参考资料
- [Python官方文档 - glob模块](https://docs.python.org/3/library/glob.html){: rel="nofollow"}
- [Python Cookbook - 文件与目录操作](https://python3-cookbook.readthedocs.io/zh_CN/latest/c05/p02_matching_filenames_using_glob.html){: rel="nofollow"}