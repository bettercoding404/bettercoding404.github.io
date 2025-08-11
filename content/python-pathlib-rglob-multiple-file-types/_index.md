---
title: "Python Pathlib rglob 匹配多种文件类型：深入解析与实践"
description: "在 Python 的文件操作中，`pathlib` 模块提供了一种面向对象的方式来处理文件路径。其中的 `rglob` 方法是一个强大的工具，用于递归地搜索指定目录及其所有子目录中的文件。而能够匹配多种文件类型则进一步扩展了其功能，使得我们在处理复杂文件结构时更加灵活高效。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法匹配多种文件类型，涵盖基础概念、使用方法、常见实践及最佳实践等方面。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 的文件操作中，`pathlib` 模块提供了一种面向对象的方式来处理文件路径。其中的 `rglob` 方法是一个强大的工具，用于递归地搜索指定目录及其所有子目录中的文件。而能够匹配多种文件类型则进一步扩展了其功能，使得我们在处理复杂文件结构时更加灵活高效。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法匹配多种文件类型，涵盖基础概念、使用方法、常见实践及最佳实践等方面。

<!-- more -->
## 目录
1. **基础概念**
    - `pathlib` 模块简介
    - `rglob` 方法概述
2. **使用方法**
    - 匹配单一文件类型
    - 匹配多种文件类型
3. **常见实践**
    - 文件处理流程示例
    - 结合其他模块使用
4. **最佳实践**
    - 性能优化
    - 代码结构与可读性
5. **小结**
6. **参考资料**

## 基础概念
### `pathlib` 模块简介
`pathlib` 模块是 Python 3.4 引入的标准库模块，它提供了表示文件系统路径的类，这些类根据操作系统的不同，提供了不同的实现方式。与传统的 `os.path` 模块相比，`pathlib` 具有更直观的面向对象接口，使得文件路径的操作更加简洁和易于理解。

### `rglob` 方法概述
`rglob` 是 `pathlib.Path` 类的一个方法，用于递归地搜索指定目录及其所有子目录中的文件。它接受一个 glob 模式作为参数，返回一个生成器对象，该生成器对象可以迭代出所有匹配指定模式的文件路径。

## 使用方法
### 匹配单一文件类型
首先，我们来看如何使用 `rglob` 匹配单一文件类型。假设我们要在当前目录及其所有子目录中搜索所有的 `.txt` 文件。

```python
from pathlib import Path

# 获取当前目录
current_dir = Path('.')

# 使用 rglob 搜索所有.txt 文件
txt_files = current_dir.rglob('*.txt')

# 打印所有匹配的文件路径
for file in txt_files:
    print(file)
```

### 匹配多种文件类型
要匹配多种文件类型，我们可以使用多个 `rglob` 调用，并将结果合并。例如，我们要搜索所有的 `.txt` 和 `.csv` 文件。

```python
from pathlib import Path

current_dir = Path('.')

# 搜索所有.txt 文件
txt_files = current_dir.rglob('*.txt')

# 搜索所有.csv 文件
csv_files = current_dir.rglob('*.csv')

# 合并结果
all_files = list(txt_files) + list(csv_files)

# 打印所有匹配的文件路径
for file in all_files:
    print(file)
```

另一种更简洁的方法是使用 `|` 运算符（Python 3.10 及以上版本支持）来合并生成器。

```python
from pathlib import Path

current_dir = Path('.')

# 使用 | 运算符合并生成器
txt_csv_files = current_dir.rglob('*.txt') | current_dir.rglob('*.csv')

# 打印所有匹配的文件路径
for file in txt_csv_files:
    print(file)
```

## 常见实践
### 文件处理流程示例
假设我们要对搜索到的所有 `.txt` 和 `.csv` 文件进行处理，例如读取文件内容并进行简单的统计。

```python
from pathlib import Path

current_dir = Path('.')
txt_csv_files = current_dir.rglob('*.txt') | current_dir.rglob('*.csv')

for file in txt_csv_files:
    if file.suffix == '.txt':
        with file.open('r', encoding='utf-8') as f:
            content = f.read()
            word_count = len(content.split())
            print(f"{file} 是文本文件，单词数: {word_count}")
    elif file.suffix == '.csv':
        with file.open('r', encoding='utf-8') as f:
            lines = f.readlines()
            row_count = len(lines)
            print(f"{file} 是 CSV 文件，行数: {row_count}")
```

### 结合其他模块使用
`pathlib` 的 `rglob` 方法可以与其他模块很好地结合使用。例如，我们可以使用 `pandas` 模块来处理搜索到的 `.csv` 文件。

```python
import pandas as pd
from pathlib import Path

current_dir = Path('.')
csv_files = current_dir.rglob('*.csv')

for file in csv_files:
    df = pd.read_csv(file)
    print(f"{file} 的数据形状: {df.shape}")
```

## 最佳实践
### 性能优化
- **减少不必要的搜索**：在使用 `rglob` 时，尽量缩小搜索范围。如果已知文件大致所在的目录层次，可以先定位到相关目录，再进行 `rglob` 操作。
- **避免多次遍历**：如果需要对搜索结果进行多次操作，考虑将生成器转换为列表或其他数据结构，以避免多次遍历文件系统。

### 代码结构与可读性
- **模块化代码**：将文件搜索和处理逻辑封装成函数，提高代码的可维护性和复用性。
- **注释清晰**：在代码中添加适当的注释，尤其是在复杂的文件处理逻辑部分，以便他人理解代码的意图。

## 小结
通过本文的介绍，我们深入了解了 `python pathlib rglob multiple file types` 的相关知识。`pathlib` 模块的 `rglob` 方法为我们提供了强大的文件搜索功能，通过灵活运用，可以轻松地在复杂的文件系统中找到所需的多种类型文件，并结合其他模块进行高效处理。在实际应用中，遵循最佳实践可以提高代码的性能和可读性，使我们的文件操作更加顺畅。

## 参考资料
- [Python官方文档 - pathlib](https://docs.python.org/3/library/pathlib.html)
- [Python 3.10 新特性 - 合并生成器](https://docs.python.org/3/whatsnew/3.10.html#pep-614-generalized-annotated-assignments)