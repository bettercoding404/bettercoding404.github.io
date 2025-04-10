---
title: "深入探索 Python Pathlib 的 rglob 方法：匹配多种文件类型"
description: "在 Python 的文件处理和目录遍历任务中，`pathlib` 模块提供了强大且直观的工具。其中，`rglob` 方法是一个非常实用的功能，它允许我们递归地在目录及其子目录中查找文件。而在实际应用中，我们常常需要匹配多种不同类型的文件。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的文件处理和目录遍历任务中，`pathlib` 模块提供了强大且直观的工具。其中，`rglob` 方法是一个非常实用的功能，它允许我们递归地在目录及其子目录中查找文件。而在实际应用中，我们常常需要匹配多种不同类型的文件。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **匹配单一文件类型**
    - **匹配多种文件类型**
3. **常见实践**
    - **处理找到的文件**
    - **结合条件筛选文件**
4. **最佳实践**
    - **性能优化**
    - **代码结构优化**
5. **小结**
6. **参考资料**

## 基础概念
`pathlib` 是 Python 标准库中用于处理文件路径的模块，它提供了面向对象的方式来操作文件和目录路径。`Path` 类是 `pathlib` 模块的核心，它代表文件系统路径。

`rglob` 是 `Path` 类的一个方法，其名称源自 “recursive glob”。它会递归地遍历指定目录及其所有子目录，查找与给定模式匹配的文件路径。“glob” 模式是一种用于指定文件名或目录名的通配符模式，例如 `*.txt` 表示所有以 `.txt` 结尾的文件。

## 使用方法

### 匹配单一文件类型
首先，让我们看一下如何使用 `rglob` 匹配单一文件类型。假设我们要在当前目录及其子目录中查找所有的 Python 脚本文件（`.py`）。

```python
from pathlib import Path

# 创建一个 Path 对象表示当前目录
current_dir = Path('.')

# 使用 rglob 查找所有的.py 文件
python_files = current_dir.rglob('*.py')

# 打印找到的文件路径
for file in python_files:
    print(file)
```

在上述代码中：
1. 我们从 `pathlib` 模块导入 `Path` 类。
2. 创建了一个 `Path` 对象 `current_dir`，表示当前目录（`.`）。
3. 使用 `rglob` 方法，并传入模式 `*.py`，这会返回一个生成器对象 `python_files`，其中包含所有匹配的文件路径。
4. 最后，通过循环遍历生成器，打印出每个找到的 Python 文件的路径。

### 匹配多种文件类型
要匹配多种文件类型，我们可以使用多个 `rglob` 调用，并将结果合并。例如，我们要查找所有的 Python 文件（`.py`）和文本文件（`.txt`）。

```python
from pathlib import Path

# 创建一个 Path 对象表示当前目录
current_dir = Path('.')

# 查找所有的.py 文件
python_files = current_dir.rglob('*.py')

# 查找所有的.txt 文件
txt_files = current_dir.rglob('*.txt')

# 将两个生成器的结果合并
all_files = list(python_files) + list(txt_files)

# 打印所有找到的文件路径
for file in all_files:
    print(file)
```

另外，我们也可以使用更简洁的方式，通过在循环中直接处理不同类型的匹配：

```python
from pathlib import Path

# 创建一个 Path 对象表示当前目录
current_dir = Path('.')

file_types = ['*.py', '*.txt']

for file_type in file_types:
    for file in current_dir.rglob(file_type):
        print(file)
```

在这个代码示例中：
1. 我们定义了一个包含两种文件类型模式的列表 `file_types`。
2. 通过外层循环遍历这个列表，对于每种文件类型模式，使用 `rglob` 方法查找匹配的文件，并通过内层循环打印出找到的文件路径。

## 常见实践

### 处理找到的文件
一旦我们找到了匹配的文件，通常需要对它们进行进一步处理。例如，读取文件内容、修改文件或者删除文件等。下面是一个读取并打印 Python 文件内容的示例：

```python
from pathlib import Path

current_dir = Path('.')
python_files = current_dir.rglob('*.py')

for file in python_files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
        print(f"File: {file}\nContent:\n{content}\n{'=' * 50}")
```

### 结合条件筛选文件
有时候，我们不仅要匹配文件类型，还需要根据其他条件筛选文件。例如，只处理文件大小超过一定阈值的文件。

```python
from pathlib import Path

current_dir = Path('.')
file_types = ['*.py', '*.txt']

size_threshold = 1024  # 1KB

for file_type in file_types:
    for file in current_dir.rglob(file_type):
        if file.stat().st_size > size_threshold:
            print(f"Large file: {file} (size: {file.stat().st_size} bytes)")
```

## 最佳实践

### 性能优化
当处理大量文件和深层目录结构时，性能可能会成为一个问题。为了优化性能，可以考虑以下几点：
1. **减少不必要的遍历**：如果可能，尽量缩小搜索范围，只在必要的目录中进行递归搜索。
2. **避免频繁的文件系统操作**：例如，尽量减少打开和关闭文件的次数。可以批量读取或处理文件。

### 代码结构优化
为了提高代码的可读性和可维护性，可以将文件查找和处理的逻辑封装到函数中。

```python
from pathlib import Path


def find_and_process_files(directory, file_types, size_threshold=0):
    results = []
    for file_type in file_types:
        for file in directory.rglob(file_type):
            if file.stat().st_size > size_threshold:
                results.append(file)
    return results


if __name__ == "__main__":
    current_dir = Path('.')
    file_types = ['*.py', '*.txt']
    large_files = find_and_process_files(current_dir, file_types, 1024)
    for file in large_files:
        print(file)
```

在这个示例中，我们将文件查找和筛选的逻辑封装到了 `find_and_process_files` 函数中，使得主代码更加简洁和清晰。

## 小结
通过本文，我们深入了解了 `pathlib` 模块中 `rglob` 方法的使用，包括匹配单一文件类型和多种文件类型的方法，以及常见实践和最佳实践。`rglob` 方法为我们在文件系统中递归查找文件提供了便捷的方式，结合适当的优化和代码结构设计，可以高效地处理各种文件处理任务。

## 参考资料
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python文件处理教程](https://www.python-course.eu/python3_files.php){: rel="nofollow"}