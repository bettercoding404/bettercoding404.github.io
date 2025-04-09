---
title: "深入探索 Python 的 Pathlib 模块：使用 rglob 匹配多种文件类型"
description: "在 Python 的文件操作领域中，Pathlib 模块为我们提供了一种面向对象且直观的方式来处理文件路径。其中，`rglob` 方法是一个强大的工具，用于递归地搜索文件路径下匹配特定模式的文件。而能够同时匹配多种文件类型则进一步扩展了其应用场景，无论是在数据处理、项目打包还是代码整理等方面都大有用处。本文将深入探讨如何使用 `Pathlib` 模块的 `rglob` 方法来匹配多种文件类型。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 的文件操作领域中，Pathlib 模块为我们提供了一种面向对象且直观的方式来处理文件路径。其中，`rglob` 方法是一个强大的工具，用于递归地搜索文件路径下匹配特定模式的文件。而能够同时匹配多种文件类型则进一步扩展了其应用场景，无论是在数据处理、项目打包还是代码整理等方面都大有用处。本文将深入探讨如何使用 `Pathlib` 模块的 `rglob` 方法来匹配多种文件类型。

<!-- more -->
## 目录
1. **Pathlib 与 rglob 基础概念**
2. **使用 rglob 匹配单一文件类型**
3. **使用 rglob 匹配多种文件类型**
4. **常见实践场景**
5. **最佳实践建议**
6. **小结**
7. **参考资料**

## Pathlib 与 rglob 基础概念
`Pathlib` 模块是 Python 标准库的一部分，它提供了 `Path` 类，用于表示文件系统路径。`Path` 类具有许多方法来操作路径，例如创建、删除、重命名文件或目录等。

`rglob` 方法是 `Path` 类的一个实例方法，其名称 “rglob” 代表 “recursive glob”。它会递归地遍历指定路径及其所有子目录，查找与给定模式匹配的文件路径。模式使用类似于 Unix shell 通配符的语法，例如 `*.txt` 表示所有以 `.txt` 结尾的文件。

```python
from pathlib import Path

# 创建一个 Path 对象，表示当前目录
current_dir = Path('.')

# 使用 rglob 查找所有的.py 文件
python_files = current_dir.rglob('*.py')
for file in python_files:
    print(file)
```

## 使用 rglob 匹配单一文件类型
匹配单一文件类型是 `rglob` 方法最基本的用法。例如，如果你想查找当前目录及其所有子目录下的所有文本文件（`.txt`），可以这样做：

```python
from pathlib import Path

# 创建 Path 对象
root_dir = Path('.')

# 使用 rglob 查找所有.txt 文件
txt_files = root_dir.rglob('*.txt')

for txt_file in txt_files:
    print(txt_file)
```

在上述代码中，`root_dir.rglob('*.txt')` 会返回一个生成器对象，包含所有匹配 `.txt` 扩展名的文件路径。通过遍历这个生成器，我们可以打印出每个文件的路径。

## 使用 rglob 匹配多种文件类型
要匹配多种文件类型，有几种不同的方法。

### 方法一：多次调用 rglob
可以多次调用 `rglob` 方法，然后将结果合并。例如，要查找所有的 Python 文件（`.py`）和文本文件（`.txt`）：

```python
from pathlib import Path

root_dir = Path('.')

# 查找所有.py 文件
py_files = root_dir.rglob('*.py')

# 查找所有.txt 文件
txt_files = root_dir.rglob('*.txt')

# 合并结果
all_files = list(py_files) + list(txt_files)

for file in all_files:
    print(file)
```

### 方法二：使用多个通配符
另一种方法是使用多个通配符模式，将它们组合在一个列表中，然后分别处理每个模式。

```python
from pathlib import Path

root_dir = Path('.')
patterns = ['*.py', '*.txt']

for pattern in patterns:
    files = root_dir.rglob(pattern)
    for file in files:
        print(file)
```

### 方法三：使用正则表达式风格匹配
如果你熟悉正则表达式，可以使用 `re` 模块结合 `rglob` 来实现更灵活的匹配。

```python
import re
from pathlib import Path

root_dir = Path('.')
regex_pattern = re.compile(r'.*\.(py|txt)$')

for file in root_dir.rglob('*'):
    if regex_pattern.match(str(file)):
        print(file)
```

在这个例子中，我们使用正则表达式 `.*\.(py|txt)$` 来匹配文件名以 `.py` 或 `.txt` 结尾的文件。通过遍历 `rglob('*')` 返回的所有文件路径，使用 `regex_pattern.match` 方法来判断是否匹配。

## 常见实践场景
### 数据处理项目
在数据处理项目中，可能需要收集不同格式的数据文件，如 `.csv`、`.json` 和 `.xml`。使用 `rglob` 匹配多种文件类型可以轻松获取所有相关数据文件，以便进行统一处理。

```python
from pathlib import Path

data_dir = Path('data')
patterns = ['*.csv', '*.json', '*.xml']

for pattern in patterns:
    data_files = data_dir.rglob(pattern)
    for file in data_files:
        # 这里可以进行数据处理操作
        print(f"Processing {file}")
```

### 项目打包
在打包项目时，需要收集所有的源文件（如 `.py`）和配置文件（如 `.ini`、`.yaml`）。通过 `rglob` 匹配多种文件类型，可以确保不会遗漏任何必要的文件。

```python
from pathlib import Path

project_dir = Path('.')
patterns = ['*.py', '*.ini', '*.yaml']

for pattern in patterns:
    files = project_dir.rglob(pattern)
    for file in files:
        # 这里可以进行文件打包相关操作
        print(f"Packing {file}")
```

## 最佳实践建议
- **性能优化**：如果目录结构非常庞大，多次调用 `rglob` 可能会影响性能。在这种情况下，使用正则表达式风格匹配（结合 `re` 模块）可能更高效，因为它只需要遍历一次文件列表。
- **错误处理**：在使用 `rglob` 时，要注意路径是否存在以及权限问题。可以在创建 `Path` 对象后，使用 `exists` 方法检查路径是否存在，并使用 `stat` 方法检查权限。
- **代码可读性**：根据具体情况选择合适的匹配方法。如果只是简单的几种文件类型匹配，多次调用 `rglob` 或使用多个通配符模式可能更易读；如果需要复杂的匹配逻辑，正则表达式风格匹配更合适，但要确保正则表达式的正确性和可读性。

## 小结
通过本文，我们深入了解了 Python 的 `Pathlib` 模块中 `rglob` 方法的基础概念以及如何使用它来匹配多种文件类型。我们探讨了不同的匹配方法及其适用场景，并给出了常见实践和最佳实践建议。掌握这些知识将有助于你在文件处理任务中更加高效地编写代码，无论是处理简单的文件搜索还是复杂的项目管理。

## 参考资料
- [Python 官方文档 - pathlib 模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python 正则表达式文档](https://docs.python.org/3/library/re.html){: rel="nofollow"}