---
title: "Python Pathlib：使用 rglob 匹配多种文件类型"
description: "在 Python 的文件处理和路径操作中，`pathlib` 模块提供了一种面向对象的方式来处理文件系统路径。`rglob` 方法是 `pathlib` 中一个强大的工具，它可以递归地搜索指定路径下的所有文件。而在实际应用中，我们常常需要搜索多种不同类型的文件。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 的文件处理和路径操作中，`pathlib` 模块提供了一种面向对象的方式来处理文件系统路径。`rglob` 方法是 `pathlib` 中一个强大的工具，它可以递归地搜索指定路径下的所有文件。而在实际应用中，我们常常需要搜索多种不同类型的文件。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
3. **常见实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
### `pathlib` 模块
`pathlib` 是 Python 3.4 及以上版本引入的标准库模块，它提供了 `Path` 类来表示文件系统路径。`Path` 类的实例可以方便地进行路径操作，如创建、删除、检查路径是否存在等。

### `rglob` 方法
`rglob` 是 `Path` 类的一个方法，用于递归地搜索指定路径下的所有文件和目录。它接受一个 glob 模式作为参数，返回所有匹配该模式的文件路径。例如，`path.rglob('*.txt')` 会返回 `path` 及其所有子目录下的所有 `.txt` 文件。

## 使用方法
### 匹配单一文件类型
首先，让我们看一下如何使用 `rglob` 匹配单一文件类型。假设我们要在当前目录及其子目录中搜索所有的 `.py` 文件：

```python
from pathlib import Path

# 创建一个 Path 对象表示当前目录
current_dir = Path('.')

# 使用 rglob 方法搜索所有.py 文件
python_files = current_dir.rglob('*.py')

for file in python_files:
    print(file)
```

### 匹配多种文件类型
要匹配多种文件类型，我们可以多次调用 `rglob` 方法，并将结果合并。例如，要搜索 `.py` 和 `.txt` 文件：

```python
from pathlib import Path

current_dir = Path('.')

# 搜索.py 文件
python_files = current_dir.rglob('*.py')

# 搜索.txt 文件
txt_files = current_dir.rglob('*.txt')

# 合并结果
all_files = list(python_files) + list(txt_files)

for file in all_files:
    print(file)
```

另一种更简洁的方法是使用 `|` 运算符（Python 3.10 及以上版本支持）来合并 glob 模式：

```python
from pathlib import Path

current_dir = Path('.')

# 使用 | 运算符合并 glob 模式
all_files = current_dir.rglob('*.py|*.txt')

for file in all_files:
    print(file)
```

## 常见实践
### 处理搜索到的文件
找到文件后，我们通常需要对其进行一些操作。例如，读取文件内容：

```python
from pathlib import Path

current_dir = Path('.')
all_files = current_dir.rglob('*.txt')

for file in all_files:
    with file.open('r', encoding='utf-8') as f:
        content = f.read()
        print(f"File: {file}, Content: {content}")
```

### 统计文件数量
我们可以统计匹配到的文件数量：

```python
from pathlib import Path

current_dir = Path('.')
all_files = current_dir.rglob('*.py|*.txt')
file_count = len(list(all_files))
print(f"Total number of files: {file_count}")
```

## 最佳实践
### 优化搜索性能
如果目录结构非常庞大，递归搜索可能会消耗大量时间。可以考虑限制搜索的深度，例如只搜索当前目录的下一级子目录：

```python
from pathlib import Path

current_dir = Path('.')
# 只搜索当前目录的下一级子目录中的.py 和.txt 文件
sub_dirs = current_dir.glob('*')
for sub_dir in sub_dirs:
    if sub_dir.is_dir():
        files = sub_dir.rglob('*.py|*.txt')
        for file in files:
            print(file)
```

### 错误处理
在进行文件操作时，要注意错误处理。例如，当文件不存在或无法读取时，捕获相应的异常：

```python
from pathlib import Path

current_dir = Path('.')
all_files = current_dir.rglob('*.txt')

for file in all_files:
    try:
        with file.open('r', encoding='utf-8') as f:
            content = f.read()
            print(f"File: {file}, Content: {content}")
    except FileNotFoundError:
        print(f"File {file} not found.")
    except PermissionError:
        print(f"Permission denied for {file}.")
```

## 小结
通过本文，我们了解了 `pathlib` 模块中 `rglob` 方法的基础概念，学习了如何使用它来匹配单一和多种文件类型。同时，我们还探讨了常见实践和最佳实践，包括文件处理、统计文件数量、优化搜索性能以及错误处理等方面。希望这些知识能帮助你在 Python 开发中更高效地处理文件系统路径和文件搜索任务。

## 参考资料
- [Python官方文档 - pathlib](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python官方文档 - glob](https://docs.python.org/3/library/glob.html){: rel="nofollow"}