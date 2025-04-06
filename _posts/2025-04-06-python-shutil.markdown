---
title: "Python shutil 模块：文件和目录操作的得力助手"
description: "在 Python 编程中，处理文件和目录是一项常见的任务。`shutil` 模块（即 shell utilities 的缩写）提供了一系列用于高级文件操作的函数，它建立在 Python 内置的 `os` 模块之上，让文件和目录的复制、移动、删除等操作变得更加便捷。无论是小型脚本还是大型项目，`shutil` 模块都能发挥重要作用。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---

<!-- more -->

## 简介
在 Python 编程中，处理文件和目录是一项常见的任务。`shutil` 模块（即 shell utilities 的缩写）提供了一系列用于高级文件操作的函数，它建立在 Python 内置的 `os` 模块之上，让文件和目录的复制、移动、删除等操作变得更加便捷。无论是小型脚本还是大型项目，`shutil` 模块都能发挥重要作用。

## 目录
1. **基础概念**
2. **使用方法**
    - **文件操作**
    - **目录操作**
3. **常见实践**
    - **备份文件和目录**
    - **整理文件**
4. **最佳实践**
    - **错误处理**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
`shutil` 模块是 Python 标准库的一部分，它提供了许多与文件和目录操作相关的函数。这些函数可以处理文件的复制、移动、删除，目录的创建、删除以及递归操作等。与 `os` 模块相比，`shutil` 的函数通常更加高级和方便，提供了更简洁的接口来完成复杂的文件系统任务。

## 使用方法

### 文件操作
1. **复制文件**
    ```python
    import shutil

    # 复制单个文件
    shutil.copy('source_file.txt', 'destination_file.txt')

    # 复制文件并保留元数据（如权限、时间戳等）
    shutil.copy2('source_file.txt', 'destination_file.txt')
    ```
2. **移动文件**
    ```python
    import shutil

    # 移动文件
    shutil.move('source_file.txt', 'new_location/destination_file.txt')
    ```
3. **删除文件**
    ```python
    import os

    # 删除单个文件
    os.remove('file_to_delete.txt')
    ```
    这里使用 `os.remove` 是因为 `shutil` 没有专门的删除文件函数，`os.remove` 是标准的删除文件方式。

### 目录操作
1. **复制目录**
    ```python
    import shutil

    # 递归复制目录及其内容
    shutil.copytree('source_directory', 'destination_directory')
    ```
2. **移动目录**
    ```python
    import shutil

    # 移动目录
    shutil.move('source_directory', 'new_location/destination_directory')
    ```
3. **删除目录**
    ```python
    import shutil

    # 递归删除目录及其内容
    shutil.rmtree('directory_to_delete')
    ```

## 常见实践

### 备份文件和目录
备份是日常开发和系统维护中常见的需求。使用 `shutil` 可以轻松实现文件和目录的备份。
```python
import shutil
import time

# 获取当前时间戳用于备份文件名
timestamp = int(time.time())
backup_dir = f'backup_{timestamp}'

# 备份单个文件
shutil.copy('important_file.txt', backup_dir)

# 备份目录
shutil.copytree('project_directory', f'{backup_dir}/project_directory')
```

### 整理文件
可以根据文件的扩展名或其他规则将文件整理到不同的目录中。
```python
import os
import shutil

# 创建分类目录
categories = ['images', 'documents', 'videos']
for category in categories:
    if not os.path.exists(category):
        os.makedirs(category)

# 遍历当前目录下的文件并分类移动
for file in os.listdir('.'):
    if os.path.isfile(file):
        file_extension = file.split('.')[-1].lower()
        if file_extension in ['jpg', 'png', 'jpeg']:
            shutil.move(file, 'images')
        elif file_extension in ['pdf', 'docx', 'txt']:
            shutil.move(file, 'documents')
        elif file_extension in ['mp4', 'avi','mkv']:
            shutil.move(file, 'videos')
```

## 最佳实践

### 错误处理
在使用 `shutil` 函数时，可能会遇到各种错误，如文件不存在、权限不足等。因此，进行适当的错误处理是很重要的。
```python
import shutil
import os

source_file ='source.txt'
destination_file = 'destination.txt'

try:
    shutil.copy(source_file, destination_file)
except FileNotFoundError:
    print(f"源文件 {source_file} 未找到。")
except PermissionError:
    print(f"权限不足，无法复制文件。")
```

### 性能优化
对于大规模的文件和目录操作，性能可能会成为一个问题。以下是一些优化建议：
- **批量操作**：尽量一次性处理多个文件，而不是逐个处理，减少系统调用次数。
- **使用缓冲**：在复制大文件时，可以使用 `shutil.copyfileobj` 并设置适当的缓冲区大小，提高复制速度。
    ```python
    import shutil

    with open('source_large_file', 'rb') as src, open('destination_large_file', 'wb') as dst:
        shutil.copyfileobj(src, dst, buffer_size=65536)
    ```

## 小结
`shutil` 模块为 Python 开发者提供了丰富而强大的文件和目录操作功能。通过学习其基础概念、掌握常用的使用方法，并遵循最佳实践，我们可以更加高效、可靠地处理文件系统相关的任务。无论是简单的文件复制还是复杂的备份和整理操作，`shutil` 都能帮助我们轻松实现。

## 参考资料
- [Python 官方文档 - shutil 模块](https://docs.python.org/3/library/shutil.html){: rel="nofollow"}
- 《Python 核心编程》
- 各种 Python 技术论坛和博客