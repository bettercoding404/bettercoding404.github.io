---
title: "Python 文件复制：从基础到最佳实践"
description: "在Python编程中，文件复制是一项常见的操作。无论是备份数据、移动文件还是创建文件的副本，掌握文件复制的方法都至关重要。本文将深入探讨Python中文件复制的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一功能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，文件复制是一项常见的操作。无论是备份数据、移动文件还是创建文件的副本，掌握文件复制的方法都至关重要。本文将深入探讨Python中文件复制的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面理解并高效运用这一功能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `shutil` 模块
    - 使用 `os` 模块
    - 使用 `open` 函数手动复制
3. 常见实践
    - 复制单个文件
    - 复制整个目录
    - 复制特定类型的文件
4. 最佳实践
    - 错误处理
    - 优化性能
    - 处理大文件
5. 小结
6. 参考资料

## 基础概念
文件复制是指将一个文件的内容完整地创建到另一个文件中，新文件在内容上与原始文件完全相同，但在存储位置和文件名上可以不同。在Python中，有多种方式可以实现文件复制，每种方式都有其特点和适用场景。

## 使用方法

### 使用 `shutil` 模块
`shutil` 模块是Python标准库中用于高级文件操作的模块，其中提供了便捷的文件复制函数。

```python
import shutil

# 复制单个文件
shutil.copy('source_file.txt', 'destination_file.txt')

# 复制文件并保留元数据（文件权限、时间戳等）
shutil.copy2('source_file.txt', 'destination_file.txt')

# 复制整个目录
shutil.copytree('source_directory', 'destination_directory')
```

### 使用 `os` 模块
`os` 模块提供了基本的操作系统交互功能，结合 `os` 模块和 `open` 函数也可以实现文件复制。

```python
import os

def copy_file_with_os(source, destination):
    with open(source, 'rb') as src:
        data = src.read()
    with open(destination, 'wb') as dst:
        dst.write(data)

copy_file_with_os('source_file.txt', 'destination_file.txt')
```

### 使用 `open` 函数手动复制
可以直接使用 `open` 函数逐块读取和写入文件内容来实现复制。

```python
def copy_file_manually(source, destination):
    buffer_size = 1024 * 1024  # 1MB buffer
    with open(source, 'rb') as src:
        with open(destination, 'wb') as dst:
            while True:
                data = src.read(buffer_size)
                if not data:
                    break
                dst.write(data)

copy_file_manually('source_file.txt', 'destination_file.txt')
```

## 常见实践

### 复制单个文件
这是最基本的文件复制操作，通常使用 `shutil.copy` 或 `shutil.copy2` 函数即可。

```python
import shutil

shutil.copy('important_file.txt', 'backup_important_file.txt')
```

### 复制整个目录
要复制整个目录及其所有子目录和文件，可以使用 `shutil.copytree` 函数。

```python
import shutil

shutil.copytree('project_folder', 'project_folder_backup')
```

### 复制特定类型的文件
可以通过遍历目录，筛选出特定类型的文件并进行复制。

```python
import os
import shutil

def copy_specific_files(source_dir, destination_dir, file_extension):
    if not os.path.exists(destination_dir):
        os.makedirs(destination_dir)

    for root, dirs, files in os.walk(source_dir):
        for file in files:
            if file.endswith(file_extension):
                source_file_path = os.path.join(root, file)
                destination_file_path = os.path.join(destination_dir, file)
                shutil.copy(source_file_path, destination_file_path)

copy_specific_files('source_directory', 'destination_directory', '.jpg')
```

## 最佳实践

### 错误处理
在进行文件复制操作时，可能会遇到各种错误，如文件不存在、权限不足等。因此，需要进行适当的错误处理。

```python
import shutil

try:
    shutil.copy('nonexistent_file.txt', 'destination.txt')
except FileNotFoundError as e:
    print(f"源文件未找到: {e}")
except PermissionError as e:
    print(f"权限不足: {e}")
```

### 优化性能
对于大文件的复制，可以通过设置合理的缓冲区大小来提高性能。例如，在使用 `open` 函数手动复制时，增大缓冲区大小。

```python
def copy_file_optimized(source, destination):
    buffer_size = 8192  # 8KB buffer
    with open(source, 'rb') as src:
        with open(destination, 'wb') as dst:
            while True:
                data = src.read(buffer_size)
                if not data:
                    break
                dst.write(data)

copy_file_optimized('large_file.iso', 'large_file_backup.iso')
```

### 处理大文件
对于超大文件，为了避免内存占用过高，可以采用分块读取和写入的方式，并且可以考虑使用异步操作来提高效率。

```python
import asyncio

async def copy_large_file_async(source, destination):
    buffer_size = 1024 * 1024  # 1MB buffer
    with open(source, 'rb') as src:
        with open(destination, 'wb') as dst:
            while True:
                data = src.read(buffer_size)
                if not data:
                    break
                dst.write(data)
                await asyncio.sleep(0)  # 释放CPU时间片

loop = asyncio.get_event_loop()
loop.run_until_complete(copy_large_file_async('huge_file.dat', 'huge_file_backup.dat'))
```

## 小结
Python提供了多种灵活的方式来实现文件复制，从简单的 `shutil` 模块函数到手动使用 `open` 函数进行底层操作。在实际应用中，根据具体需求选择合适的方法，并注意错误处理、性能优化以及大文件处理等方面的最佳实践，能够高效、稳定地完成文件复制任务。

## 参考资料
- 《Python Cookbook》