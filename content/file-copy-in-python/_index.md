---
title: "Python 文件复制：基础、实践与最佳方法"
description: "在Python编程中，文件复制是一项常见且重要的操作。无论是备份数据、迁移文件还是在不同环境中复制资源，掌握文件复制的方法都至关重要。Python提供了多种方式来实现文件复制，本文将详细介绍这些方法，包括基础概念、使用方式、常见实践以及最佳实践，帮助读者在实际项目中高效地处理文件复制任务。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，文件复制是一项常见且重要的操作。无论是备份数据、迁移文件还是在不同环境中复制资源，掌握文件复制的方法都至关重要。Python提供了多种方式来实现文件复制，本文将详细介绍这些方法，包括基础概念、使用方式、常见实践以及最佳实践，帮助读者在实际项目中高效地处理文件复制任务。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `open()` 和循环读取写入**
    - **使用 `shutil` 模块**
3. **常见实践**
    - **复制文件夹及其内容**
    - **处理大文件复制**
4. **最佳实践**
    - **错误处理与异常捕获**
    - **优化性能**
5. **小结**
6. **参考资料**

## 基础概念
文件复制，简单来说，就是将一个文件的内容完整地创建一份副本到另一个位置。在Python中，文件操作基于文件对象进行。文件对象提供了读取和写入文件的方法。复制文件时，我们需要从源文件读取数据，然后将这些数据写入到目标文件。

## 使用方法

### 使用 `open()` 和循环读取写入
这是一种最基本的文件复制方法。通过 `open()` 函数分别打开源文件和目标文件，然后逐行读取源文件内容并写入目标文件。

```python
def copy_file_basic(src, dst):
    with open(src, 'rb') as source_file:
        with open(dst, 'wb') as target_file:
            for line in source_file:
                target_file.write(line)


```

### 使用 `shutil` 模块
`shutil` 模块是Python标准库中专门用于处理文件和目录的高级操作的模块。其中的 `copyfile()` 函数可以方便地实现文件复制。

```python
import shutil


def copy_file_shutil(src, dst):
    shutil.copyfile(src, dst)


```

## 常见实践

### 复制文件夹及其内容
要复制整个文件夹及其所有子文件和子文件夹，可以使用递归方法结合 `shutil` 模块的 `copytree()` 函数。

```python
import shutil


def copy_folder(src, dst):
    shutil.copytree(src, dst)


```

### 处理大文件复制
对于大文件，逐块读取和写入可以提高性能，避免一次性将整个文件内容读入内存。

```python
def copy_large_file(src, dst):
    block_size = 1024 * 1024  # 1MB 块大小
    with open(src, 'rb') as source_file:
        with open(dst, 'wb') as target_file:
            while True:
                block = source_file.read(block_size)
                if not block:
                    break
                target_file.write(block)


```

## 最佳实践

### 错误处理与异常捕获
在文件复制过程中，可能会遇到各种错误，如文件不存在、权限不足等。因此，进行适当的错误处理和异常捕获是非常必要的。

```python
import shutil
import os


def copy_file_with_error_handling(src, dst):
    try:
        if not os.path.exists(src):
            raise FileNotFoundError(f"源文件 {src} 不存在")
        shutil.copyfile(src, dst)
        print(f"文件 {src} 已成功复制到 {dst}")
    except PermissionError as e:
        print(f"权限错误: {e}")
    except Exception as e:
        print(f"发生错误: {e}")


```

### 优化性能
除了逐块读取大文件外，还可以考虑使用多线程或异步编程来提高文件复制的效率，特别是在处理多个文件复制任务时。

```python
import shutil
import os
import threading


def copy_file_threaded(src, dst):
    def copy():
        try:
            if not os.path.exists(src):
                raise FileNotFoundError(f"源文件 {src} 不存在")
            shutil.copyfile(src, dst)
            print(f"文件 {src} 已成功复制到 {dst}")
        except PermissionError as e:
            print(f"权限错误: {e}")
        except Exception as e:
            print(f"发生错误: {e}")


    thread = threading.Thread(target=copy)
    thread.start()


```

## 小结
本文详细介绍了Python中文件复制的相关知识，从基础概念到多种使用方法，再到常见实践和最佳实践。通过不同的方法，读者可以根据实际需求选择合适的方式进行文件复制操作。同时，注意错误处理和性能优化，能使文件复制操作更加健壮和高效。

## 参考资料
- 《Python Cookbook》