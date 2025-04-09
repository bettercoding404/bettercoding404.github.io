---
title: "深入探究Python中列出文件夹中的文件"
description: "在Python编程中，经常会遇到需要列出文件夹中文件的需求。无论是进行数据处理、文件管理还是自动化任务，能够轻松获取文件夹内的文件列表都是一项基础且重要的技能。本文将深入探讨如何使用Python列出文件夹中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在Python编程中，经常会遇到需要列出文件夹中文件的需求。无论是进行数据处理、文件管理还是自动化任务，能够轻松获取文件夹内的文件列表都是一项基础且重要的技能。本文将深入探讨如何使用Python列出文件夹中的文件，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用`os.listdir()`**
    - **使用`os.walk()`**
    - **使用`pathlib`模块**
3. **常见实践**
    - **筛选特定类型的文件**
    - **递归列出所有文件**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
在操作系统中，文件夹（也称为目录）是用于组织和存储文件的容器。Python提供了多种内置的模块和函数来与操作系统进行交互，其中包括获取文件夹中文件列表的功能。这些功能允许我们遍历文件夹结构，获取文件名、文件路径等信息，以便进一步处理文件。

## 使用方法

### 使用`os.listdir()`
`os`模块是Python标准库中用于与操作系统交互的模块。`os.listdir()`函数可以列出指定文件夹中的所有文件和子文件夹的名称。

```python
import os

folder_path = '.'  # 当前文件夹
file_list = os.listdir(folder_path)

for file in file_list:
    print(file)
```

在上述代码中：
1. 首先导入`os`模块。
2. 定义了一个变量`folder_path`，这里使用`.`表示当前文件夹。
3. 使用`os.listdir()`函数获取文件夹中的文件和子文件夹列表，并将其存储在`file_list`变量中。
4. 最后通过循环打印出列表中的每个文件名。

### 使用`os.walk()`
`os.walk()`函数用于遍历文件夹树，它会递归地返回指定文件夹及其所有子文件夹中的文件和子文件夹信息。

```python
import os

folder_path = '.'  # 当前文件夹

for root, dirs, files in os.walk(folder_path):
    print(f"当前文件夹: {root}")
    print(f"子文件夹: {dirs}")
    print(f"文件: {files}")
    print("-" * 50)
```

在这段代码中：
1. `os.walk()`函数返回一个三元组`(root, dirs, files)`。
    - `root`是当前正在遍历的文件夹路径。
    - `dirs`是当前文件夹中的所有子文件夹名称列表。
    - `files`是当前文件夹中的所有文件名称列表。
2. 通过循环打印出每个文件夹的信息。

### 使用`pathlib`模块
`pathlib`模块是Python 3.4及以上版本引入的面向对象的文件路径处理模块，它提供了更加直观和简洁的方式来操作文件路径。

```python
from pathlib import Path

folder_path = Path('.')  # 当前文件夹
file_list = [file for file in folder_path.iterdir() if file.is_file()]

for file in file_list:
    print(file)
```

在这个示例中：
1. 从`pathlib`模块中导入`Path`类。
2. 创建一个`Path`对象`folder_path`，表示当前文件夹。
3. 使用列表推导式获取文件夹中的所有文件，`folder_path.iterdir()`方法遍历文件夹中的所有项，`file.is_file()`方法判断该项是否为文件。
4. 最后循环打印出文件路径。

## 常见实践

### 筛选特定类型的文件
在实际应用中，我们通常只需要获取特定类型的文件，比如所有的图片文件或文本文件。可以通过以下方式实现：

```python
import os

folder_path = '.'  # 当前文件夹
extension = '.txt'  # 筛选的文件扩展名

file_list = [file for file in os.listdir(folder_path) if file.endswith(extension)]

for file in file_list:
    print(file)
```

在上述代码中，通过`file.endswith(extension)`方法筛选出以指定扩展名结尾的文件。

### 递归列出所有文件
有时候我们需要递归地列出一个文件夹及其所有子文件夹中的所有文件，可以使用`os.walk()`函数来实现：

```python
import os

folder_path = '.'  # 当前文件夹

all_files = []
for root, dirs, files in os.walk(folder_path):
    for file in files:
        file_path = os.path.join(root, file)
        all_files.append(file_path)

for file in all_files:
    print(file)
```

在这段代码中，通过`os.walk()`遍历所有文件夹，并使用`os.path.join()`函数将文件夹路径和文件名组合成完整的文件路径。

## 最佳实践

### 错误处理
在获取文件夹中的文件列表时，可能会遇到文件夹不存在、权限不足等问题。因此，进行适当的错误处理是很重要的。

```python
import os

folder_path = 'non_existent_folder'  # 不存在的文件夹路径

try:
    file_list = os.listdir(folder_path)
    for file in file_list:
        print(file)
except FileNotFoundError:
    print(f"文件夹 {folder_path} 不存在。")
except PermissionError:
    print(f"没有权限访问文件夹 {folder_path}。")
```

### 性能优化
如果文件夹中包含大量文件，遍历文件夹可能会消耗较多时间。可以考虑使用多线程或异步编程来提高性能。例如，使用`concurrent.futures`模块进行多线程处理：

```python
import os
import concurrent.futures

folder_path = '.'  # 当前文件夹

def process_file(file):
    file_path = os.path.join(folder_path, file)
    # 在这里进行文件处理操作
    print(f"处理文件: {file_path}")

with concurrent.futures.ThreadPoolExecutor() as executor:
    file_list = os.listdir(folder_path)
    executor.map(process_file, file_list)
```

在上述代码中，`concurrent.futures.ThreadPoolExecutor`创建了一个线程池，`executor.map()`方法将`process_file`函数应用到每个文件上，实现多线程处理。

## 小结
本文详细介绍了在Python中列出文件夹中文件的多种方法，包括`os.listdir()`、`os.walk()`和`pathlib`模块的使用。同时，通过常见实践和最佳实践示例展示了如何筛选特定类型的文件、递归列出所有文件以及进行错误处理和性能优化。掌握这些技巧将有助于提高文件处理任务的效率和可靠性。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - pathlib模块](https://docs.python.org/3/library/pathlib.html){: rel="nofollow"}
- [Python多线程编程 - concurrent.futures模块](https://docs.python.org/3/library/concurrent.futures.html){: rel="nofollow"}