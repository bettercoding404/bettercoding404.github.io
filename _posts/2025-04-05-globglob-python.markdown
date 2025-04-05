---
title: "深入探索 Python 中的 glob.glob"
description: "在 Python 的世界里，文件操作是一项极为常见的任务。`glob.glob` 作为 Python 标准库 `glob` 模块中的一个强大函数，为我们提供了一种简单而有效的方式来查找符合特定模式的文件路径。无论是在处理大量文件的数据分析项目中，还是在日常脚本编写时需要批量操作文件，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一实用工具。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 的世界里，文件操作是一项极为常见的任务。`glob.glob` 作为 Python 标准库 `glob` 模块中的一个强大函数，为我们提供了一种简单而有效的方式来查找符合特定模式的文件路径。无论是在处理大量文件的数据分析项目中，还是在日常脚本编写时需要批量操作文件，`glob.glob` 都能发挥重要作用。本文将详细介绍 `glob.glob` 的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一实用工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本用法**
    - **递归匹配**
    - **指定文件类型**
3. **常见实践**
    - **批量读取文件**
    - **筛选特定目录下的文件**
4. **最佳实践**
    - **性能优化**
    - **错误处理**
5. **小结**
6. **参考资料**

## 基础概念
`glob` 模块是 Python 标准库的一部分，用于文件路径名的模式匹配。`glob.glob` 函数返回所有匹配指定路径名模式的路径名列表。这里的路径名模式使用类似于 Unix shell 中使用的通配符规则：
- `*`：匹配任意数量（包括零个）的任意字符。
- `?`：匹配单个任意字符。
- `[]`：匹配方括号内指定范围内的任意一个字符。例如，`[0-9]` 匹配任意一个数字，`[a-zA-Z]` 匹配任意一个字母。

## 使用方法

### 基本用法
以下是 `glob.glob` 的基本语法：
```python
import glob

file_list = glob.glob('path/to/directory/*.txt')
print(file_list)
```
在这个示例中，`path/to/directory` 是你要搜索的目录路径，`*.txt` 是文件模式，表示匹配该目录下所有以 `.txt` 结尾的文件。运行这段代码后，`file_list` 将包含所有符合条件的文件路径。

### 递归匹配
如果你想递归地匹配目录及其子目录中的文件，可以使用 `**` 通配符。不过，要启用递归匹配，需要设置 `recursive=True` 参数。
```python
import glob

file_list = glob.glob('path/to/directory/**/*.txt', recursive=True)
print(file_list)
```
这样，`file_list` 将包含 `path/to/directory` 及其所有子目录中所有以 `.txt` 结尾的文件路径。

### 指定文件类型
除了使用 `*.extension` 来匹配特定扩展名的文件，你还可以使用 `[]` 来指定更复杂的文件类型。例如，如果你想匹配所有以数字开头的 `.txt` 文件：
```python
import glob

file_list = glob.glob('path/to/directory/[0-9]*.txt')
print(file_list)
```

## 常见实践

### 批量读取文件
在数据分析等场景中，经常需要批量读取一组文件。`glob.glob` 可以很方便地获取文件列表，然后通过循环读取这些文件。
```python
import glob
import pandas as pd

file_list = glob.glob('data/*.csv')
dataframes = []

for file in file_list:
    df = pd.read_csv(file)
    dataframes.append(df)

combined_df = pd.concat(dataframes)
print(combined_df)
```
在这个示例中，我们使用 `glob.glob` 获取 `data` 目录下所有的 `.csv` 文件，然后使用 `pandas` 逐一把它们读取到 DataFrame 中，并最终合并成一个 DataFrame。

### 筛选特定目录下的文件
有时候我们只对特定目录层次结构中的文件感兴趣。例如，我们想获取 `parent_directory` 下第二层目录中所有的 `.jpg` 文件：
```python
import glob

file_list = glob.glob('parent_directory/*/*/*.jpg')
print(file_list)
```

## 最佳实践

### 性能优化
当处理大量文件时，性能是一个重要问题。避免不必要的递归匹配，因为递归匹配会遍历更多的目录，消耗更多的时间和资源。如果已知文件只存在于特定目录中，不要使用递归匹配。另外，在使用 `[]` 进行字符范围匹配时，尽量缩小范围，以减少匹配的复杂度。

### 错误处理
在使用 `glob.glob` 时，可能会遇到目录不存在等错误情况。建议进行适当的错误处理，例如：
```python
import glob
import os

directory = 'path/to/directory'
if not os.path.exists(directory):
    print(f"目录 {directory} 不存在")
else:
    file_list = glob.glob(directory + '/*.txt')
    print(file_list)
```

## 小结
`glob.glob` 是 Python 中一个非常实用的文件路径匹配工具。通过掌握其基础概念、灵活运用不同的使用方法，并遵循最佳实践，我们可以在文件操作中更加高效和准确。无论是简单的文件查找，还是复杂的批量文件处理，`glob.glob` 都能为我们提供强大的支持。

## 参考资料
- [Python 官方文档 - glob 模块](https://docs.python.org/3/library/glob.html){: rel="nofollow"}
- 《Python 核心编程》
- 《Effective Python》