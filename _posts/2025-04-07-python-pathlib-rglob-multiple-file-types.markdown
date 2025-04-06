---
title: "探索Python中Pathlib的rglob方法匹配多种文件类型"
description: "在Python的文件处理和路径操作中，`pathlib` 模块提供了强大且直观的方式来处理文件系统路径。其中，`rglob` 方法尤为实用，它允许我们递归地搜索指定目录及其所有子目录中的文件。而当我们需要匹配多种文件类型时，掌握相关技巧和最佳实践能够显著提升代码的效率和可读性。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在Python的文件处理和路径操作中，`pathlib` 模块提供了强大且直观的方式来处理文件系统路径。其中，`rglob` 方法尤为实用，它允许我们递归地搜索指定目录及其所有子目录中的文件。而当我们需要匹配多种文件类型时，掌握相关技巧和最佳实践能够显著提升代码的效率和可读性。本文将深入探讨如何使用 `pathlib` 的 `rglob` 方法来匹配多种文件类型，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
    - `pathlib` 模块介绍
    - `rglob` 方法原理
2. **使用方法**
    - 匹配单一文件类型
    - 匹配多种文件类型
3. **常见实践**
    - 在项目中查找特定类型文件
    - 批量处理多种类型文件
4. **最佳实践**
    - 性能优化
    - 代码结构优化
5. **小结**
6. **参考资料**

## 基础概念
### `pathlib` 模块介绍
`pathlib` 是Python 3.4 及以上版本引入的标准库模块，它提供了面向对象的方式来处理文件系统路径。与传统的 `os.path` 模块相比，`pathlib` 更加直观和易用，它将路径表示为对象，提供了丰富的方法来操作路径、检查文件属性、遍历目录等。

### `rglob` 方法原理
`rglob` 是 `pathlib.Path` 对象的一个方法，用于递归地搜索指定目录及其所有子目录中的文件。它接受一个 glob 模式作为参数，返回所有匹配该模式的文件路径的迭代器。例如，`path.rglob('*.txt')` 会返回 `path` 目录及其所有子目录中所有扩展名为 `.txt` 的文件路径。

## 使用方法
### 匹配单一文件类型
以下是使用 `rglob` 匹配单一文件类型（例如 `.txt` 文件）的示例：

```python
from pathlib import Path

# 创建一个Path对象，指向当前目录
current_dir = Path('.')

# 使用rglob方法匹配所有txt文件
txt_files = current_dir.rglob('*.txt')

for file in txt_files:
    print(file)
```

### 匹配多种文件类型
要匹配多种文件类型，可以使用多个 `rglob` 调用，然后将结果合并。例如，匹配 `.txt` 和 `.csv` 文件：

```python
from pathlib import Path

current_dir = Path('.')

txt_files = current_dir.rglob('*.txt')
csv_files = current_dir.rglob('*.csv')

# 将两个迭代器合并
all_files = list(txt_files) + list(csv_files)

for file in all_files:
    print(file)
```

另一种更简洁的方式是使用 `|` 运算符（Python 3.10 及以上版本支持）：

```python
from pathlib import Path

current_dir = Path('.')

# 使用|运算符合并匹配结果
all_files = current_dir.rglob('*.txt') | current_dir.rglob('*.csv')

for file in all_files:
    print(file)
```

## 常见实践
### 在项目中查找特定类型文件
假设我们有一个项目目录，需要查找所有的Python源文件（`.py`）和配置文件（`.cfg`）。

```python
from pathlib import Path

project_dir = Path('my_project')

py_files = project_dir.rglob('*.py')
cfg_files = project_dir.rglob('*.cfg')

all_files = list(py_files) + list(cfg_files)

for file in all_files:
    print(file)
```

### 批量处理多种类型文件
在处理数据时，我们可能需要对多种类型的文件进行批量处理。例如，读取 `.txt` 和 `.csv` 文件并进行数据清洗：

```python
import pandas as pd
from pathlib import Path

current_dir = Path('.')

txt_files = current_dir.rglob('*.txt')
csv_files = current_dir.rglob('*.csv')

all_files = list(txt_files) + list(csv_files)

for file in all_files:
    if file.suffix == '.txt':
        with open(file, 'r', encoding='utf-8') as f:
            data = f.read()
            # 进行文本数据清洗操作
            cleaned_data = data.strip()
            print(f"Cleaned text from {file}: {cleaned_data}")
    elif file.suffix == '.csv':
        df = pd.read_csv(file)
        # 进行CSV数据清洗操作
        cleaned_df = df.dropna()
        print(f"Cleaned CSV data from {file}: {cleaned_df}")
```

## 最佳实践
### 性能优化
在处理大量文件时，性能是一个重要问题。避免不必要的重复搜索和数据转换可以提升性能。例如，尽量减少将迭代器转换为列表的操作，因为这会占用额外的内存。

### 代码结构优化
为了提高代码的可读性和可维护性，可以将文件搜索和处理逻辑封装成函数。例如：

```python
from pathlib import Path
import pandas as pd

def find_files(directory, patterns):
    all_files = []
    for pattern in patterns:
        files = directory.rglob(pattern)
        all_files.extend(files)
    return all_files

def process_files(files):
    for file in files:
        if file.suffix == '.txt':
            with open(file, 'r', encoding='utf-8') as f:
                data = f.read()
                cleaned_data = data.strip()
                print(f"Cleaned text from {file}: {cleaned_data}")
        elif file.suffix == '.csv':
            df = pd.read_csv(file)
            cleaned_df = df.dropna()
            print(f"Cleaned CSV data from {file}: {cleaned_df}")

if __name__ == "__main__":
    current_dir = Path('.')
    patterns = ['*.txt', '*.csv']
    found_files = find_files(current_dir, patterns)
    process_files(found_files)
```

## 小结
通过使用 `pathlib` 模块的 `rglob` 方法，我们可以方便地递归搜索文件系统中的文件，并轻松匹配多种文件类型。在实际应用中，掌握不同的使用方法和最佳实践能够提高代码的效率和可读性，从而更高效地处理文件相关任务。

## 参考资料
- [Python官方文档 - pathlib](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python基础教程 - 文件操作与pathlib](https://www.python.org/dev/peps/pep-0428/){: rel="nofollow"}