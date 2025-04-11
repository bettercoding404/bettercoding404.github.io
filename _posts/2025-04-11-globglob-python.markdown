---
title: "深入探索 Python 中的 glob.glob"
description: "在 Python 的世界里，文件操作是一项极为常见的任务。`glob.glob` 作为 Python 标准库 `glob` 模块中的重要函数，为我们提供了一种简单而强大的方式来进行文件路径的匹配和查找。通过使用特定的通配符模式，它可以快速定位到符合条件的文件列表，无论是在当前目录还是嵌套的子目录中。这篇博客将深入探讨 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一实用工具。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的世界里，文件操作是一项极为常见的任务。`glob.glob` 作为 Python 标准库 `glob` 模块中的重要函数，为我们提供了一种简单而强大的方式来进行文件路径的匹配和查找。通过使用特定的通配符模式，它可以快速定位到符合条件的文件列表，无论是在当前目录还是嵌套的子目录中。这篇博客将深入探讨 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一实用工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 基本通配符匹配
    - 递归匹配
3. **常见实践**
    - 读取特定类型文件
    - 批量文件操作
4. **最佳实践**
    - 优化匹配性能
    - 处理不同操作系统路径
5. **小结**
6. **参考资料**

## 基础概念
`glob.glob` 是 Python `glob` 模块中的函数，用于根据指定的路径名模式返回所有匹配的文件路径列表。路径名模式可以包含以下通配符：
- `*`：匹配任意数量（包括零个）的任意字符。
- `?`：匹配单个任意字符。

例如，`*.txt` 可以匹配当前目录下所有以 `.txt` 结尾的文件；`file?.txt` 可以匹配 `file1.txt`、`file2.txt` 等，但不能匹配 `file.txt`。

## 使用方法

### 基本通配符匹配
以下是使用 `glob.glob` 进行基本通配符匹配的示例代码：

```python
import glob

# 获取当前目录下所有的.py 文件
file_list = glob.glob('*.py')
for file in file_list:
    print(file)
```

在上述代码中，`glob.glob('*.py')` 会返回当前目录下所有以 `.py` 结尾的文件路径列表，并通过循环打印出每个文件的路径。

### 递归匹配
如果要在目录及其所有子目录中进行文件匹配，可以使用递归匹配。在 Python 3.5 及以上版本中，可以使用双星号 `**` 来实现递归匹配。示例代码如下：

```python
import glob

# 获取当前目录及其所有子目录下的所有.py 文件
file_list = glob.glob('**/*.py', recursive=True)
for file in file_list:
    print(file)
```

在这个例子中，`glob.glob('**/*.py', recursive=True)` 会递归地查找当前目录及其所有子目录下的所有 `.py` 文件，并将它们的路径存储在 `file_list` 中。

## 常见实践

### 读取特定类型文件
在数据处理中，经常需要读取特定类型的文件，例如读取目录下所有的 CSV 文件。示例代码如下：

```python
import glob
import pandas as pd

# 获取所有 CSV 文件路径
csv_files = glob.glob('*.csv')

for csv_file in csv_files:
    data = pd.read_csv(csv_file)
    # 对数据进行处理
    print(data.head())
```

### 批量文件操作
有时候需要对一组匹配的文件进行批量操作，比如重命名文件。以下是一个简单的示例：

```python
import glob
import os

# 获取所有.txt 文件路径
txt_files = glob.glob('*.txt')

for txt_file in txt_files:
    new_name = txt_file.replace('.txt', '_new.txt')
    os.rename(txt_file, new_name)
```

## 最佳实践

### 优化匹配性能
如果要匹配大量文件，性能可能会成为问题。可以通过缩小搜索范围来提高匹配效率。例如，先定位到包含目标文件的目录，再在该目录下进行匹配。示例代码如下：

```python
import glob

# 先定位到特定目录
target_dir ='specific_directory'
file_list = glob.glob(os.path.join(target_dir, '*.py'))
```

### 处理不同操作系统路径
不同操作系统的路径分隔符不同（Windows 下是 `\`，Linux 和 macOS 下是 `/`）。为了确保代码的跨平台性，可以使用 `os.path.join` 函数来构建路径。示例代码如下：

```python
import glob
import os

# 构建跨平台路径
file_path = os.path.join('parent_dir', 'child_dir', '*.txt')
file_list = glob.glob(file_path)
```

## 小结
`glob.glob` 是 Python 文件操作中一个非常实用的函数，通过灵活运用通配符模式，可以方便地进行文件路径的匹配和查找。掌握其基本概念、使用方法、常见实践以及最佳实践，能够帮助我们更高效地处理文件相关任务，无论是在简单的脚本编写还是复杂的项目开发中。

## 参考资料
- [Python 官方文档 - glob 模块](https://docs.python.org/3/library/glob.html){: rel="nofollow"}
- [Python 基础教程 - 文件操作](https://www.runoob.com/python3/python3-file-methods.html){: rel="nofollow"}