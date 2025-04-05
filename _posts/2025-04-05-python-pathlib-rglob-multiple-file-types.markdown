---
title: "探索Python的Pathlib库：使用rglob匹配多种文件类型"
description: "在Python的文件处理和目录遍历任务中，`pathlib`库提供了一种面向对象且直观的方式来处理文件路径。其中，`rglob`方法是一个强大的工具，它允许我们递归地搜索目录树，找到匹配特定模式的文件。本文将深入探讨如何使用`pathlib`的`rglob`方法来匹配多种文件类型，为你在文件操作任务中提供更多便利。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python的文件处理和目录遍历任务中，`pathlib`库提供了一种面向对象且直观的方式来处理文件路径。其中，`rglob`方法是一个强大的工具，它允许我们递归地搜索目录树，找到匹配特定模式的文件。本文将深入探讨如何使用`pathlib`的`rglob`方法来匹配多种文件类型，为你在文件操作任务中提供更多便利。

<!-- more -->
## 目录
1. **基础概念**
    - `pathlib`库简介
    - `rglob`方法的作用
2. **使用方法**
    - 匹配单个文件类型
    - 匹配多种文件类型
3. **常见实践**
    - 遍历目录并处理多种文件类型
    - 统计多种文件类型的数量
4. **最佳实践**
    - 提高匹配效率
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
### `pathlib`库简介
`pathlib`是Python 3.4及以上版本引入的标准库，它提供了表示文件系统路径的类，这些类以面向对象的方式操作路径。与传统的`os.path`模块相比，`pathlib`更加直观和易用。例如，创建一个路径对象可以这样做：

```python
from pathlib import Path

# 创建一个路径对象
p = Path('/home/user/Documents')
```

### `rglob`方法的作用
`rglob`方法是`Path`类的一个方法，用于递归地遍历目录树，找到所有匹配指定模式的文件路径。模式可以是简单的文件名或使用通配符来指定文件类型。例如，要查找当前目录及其所有子目录下的所有`.txt`文件：

```python
from pathlib import Path

p = Path('.')
for file in p.rglob('*.txt'):
    print(file)
```

## 使用方法
### 匹配单个文件类型
匹配单个文件类型是`rglob`方法的基本用法。例如，要查找当前目录及其所有子目录下的所有`.py`文件：

```python
from pathlib import Path

# 创建路径对象
base_path = Path('.')

# 使用rglob查找所有.py文件
for py_file in base_path.rglob('*.py'):
    print(py_file)
```

### 匹配多种文件类型
要匹配多种文件类型，可以多次调用`rglob`方法，并将结果合并。例如，要查找`.jpg`和`.png`文件：

```python
from pathlib import Path

base_path = Path('.')

jpg_files = list(base_path.rglob('*.jpg'))
png_files = list(base_path.rglob('*.png'))

all_image_files = jpg_files + png_files

for image_file in all_image_files:
    print(image_file)
```

或者，使用正则表达式模式来一次匹配多种文件类型。虽然`rglob`本身不支持完整的正则表达式，但可以通过一些技巧实现类似功能：

```python
import re
from pathlib import Path

base_path = Path('.')
pattern = re.compile(r'\.(jpg|png|gif)$')

for file in base_path.rglob('*'):
    if pattern.search(str(file)):
        print(file)
```

## 常见实践
### 遍历目录并处理多种文件类型
假设我们要遍历一个目录及其子目录，对找到的`.txt`文件读取内容并打印行数，对`.jpg`文件打印文件大小：

```python
from pathlib import Path

base_path = Path('.')

for txt_file in base_path.rglob('*.txt'):
    with open(txt_file, 'r') as f:
        lines = f.readlines()
        print(f"{txt_file}: {len(lines)} lines")

for jpg_file in base_path.rglob('*.jpg'):
    file_size = jpg_file.stat().st_size
    print(f"{jpg_file}: {file_size} bytes")
```

### 统计多种文件类型的数量
统计当前目录及其子目录下`.pdf`和`.docx`文件的数量：

```python
from pathlib import Path

base_path = Path('.')

pdf_count = len(list(base_path.rglob('*.pdf')))
docx_count = len(list(base_path.rglob('*.docx')))

print(f"Number of PDF files: {pdf_count}")
print(f"Number of DOCX files: {docx_count}")
```

## 最佳实践
### 提高匹配效率
如果目录结构非常大，多次调用`rglob`可能会效率低下。可以考虑一次性获取所有文件路径，然后进行类型筛选：

```python
from pathlib import Path

base_path = Path('.')
all_files = list(base_path.rglob('*'))

image_pattern = re.compile(r'\.(jpg|png|gif)$')
image_files = [file for file in all_files if image_pattern.search(str(file))]

for image_file in image_files:
    print(image_file)
```

### 错误处理
在遍历目录和访问文件时，可能会遇到权限问题或文件不存在等错误。使用`try - except`块来捕获并处理这些错误：

```python
from pathlib import Path

base_path = Path('.')

for file in base_path.rglob('*'):
    try:
        # 对文件进行操作，例如读取文件内容
        with open(file, 'r') as f:
            content = f.read()
            print(f"Successfully read {file}")
    except PermissionError:
        print(f"Permission denied for {file}")
    except FileNotFoundError:
        print(f"{file} not found")
    except Exception as e:
        print(f"An error occurred while processing {file}: {e}")
```

## 小结
通过本文，我们深入了解了`pathlib`库中`rglob`方法的使用，包括基础概念、匹配多种文件类型的方法、常见实践以及最佳实践。`rglob`方法为我们在Python中递归遍历目录并查找特定文件类型提供了强大的支持，合理运用这些技巧可以提高文件处理任务的效率和可靠性。

## 参考资料
- [Python官方文档 - pathlib](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python教程 - 文件和目录操作](https://www.runoob.com/python3/python3-file-methods.html){: rel="nofollow"}