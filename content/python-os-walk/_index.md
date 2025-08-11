---
layout: post
title:  "Python使用os.walk递归读取文件和目录"
description: "本文详细介绍了如何使用 Python 的递归与 os.walk 轻松读取目录树，并附上一些实际应用的示例。"
date:   2024-11-08 00:00:00 +0000
categories: [Python，os.walk]
cascade:
  - type: docs
---


在日常开发工作中，处理文件和目录的需求无处不在，特别是在需要读取大量文件夹、分析文件结构、或者批量处理文件时更为常见。Python 提供了强大的 os.walk 函数，可以用来遍历目录树。结合递归，os.walk 能帮我们轻松实现深度优先搜索，快速而优雅地处理复杂的目录结构。在这篇博客中，我们将探讨如何使用 Python 的递归与 os.walk 轻松读取目录树，并附上一些实际应用的示例。

## 为什么选择 os.walk？
os.walk 是 Python 的标准库 os 中的一个函数，它用于生成一个目录树的文件名，它会递归地进入目录并生成子文件夹和文件的路径。我们可以利用 os.walk 来遍历目录中的每个文件或子目录，而不需要手动处理递归问题，非常适合多层嵌套的文件结构。

## os.walk 的基本用法
os.walk 的典型输出是一个三元组 (dirpath, dirnames, filenames)，其中：

* dirpath 是当前遍历的目录路径；
* dirnames 是当前目录下的子目录名称列表；
* filenames 是当前目录下的文件名称列表。
```python

import os

for dirpath, dirnames, filenames in os.walk('/path/to/directory'):
   print(f'Found directory: {dirpath}')
   for filename in filenames:
      print(f'\t{filename}')

```
上面的代码会从根目录 '/path/to/directory' 开始，递归地遍历其下的每一个子目录和文件。


## 使用递归读取目录
虽然 os.walk 本身是递归的，但有时候我们希望用递归函数来控制遍历过程。通过自定义递归函数，我们可以更灵活地定义处理逻辑，比如筛选文件、计数文件数量、或者按照特定规则排序等。

## 示例：递归统计特定文件类型的数量
假设我们要统计某个目录下所有 .txt 文件的数量，可以借助递归函数来实现：

```python
import os

def count_txt_files(dir_path):
    count = 0
    for root, dirs, files in os.walk(dir_path):
        # 过滤出所有 .txt 文件
        txt_files = [f for f in files if f.endswith('.txt')]
        count += len(txt_files)

        # 打印当前目录及 .txt 文件
        print(f'Directory: {root}, .txt files: {len(txt_files)}')

        for dir_name in dirs:
            count += count_txt_files(os.path.join(root, dir_name))
    return count


directory_path = '/path/to/directory'
txt_file_count = count_txt_files(directory_path)
print(f'Total .txt files: {txt_file_count}')

```
此代码将递归遍历 directory_path 下的所有子目录，并统计 .txt 文件的数量。

## os.walk 与递归：探索更深的应用
递归与 os.walk 的结合，能够很好地实现对文件树的复杂操作。以下是一些具体应用的场景示例。

### 批量重命名文件
   通过 os.walk 与递归，我们可以遍历目录树并按照特定规则批量重命名文件，比如给所有文件添加前缀 project_：

```python

import os

def rename_files_with_prefix(dir_path, prefix):
    for root, dirs, files in os.walk(dir_path):
        for filename in files:
            new_name = prefix + filename
            os.rename(
                os.path.join(root, filename),
                os.path.join(root, new_name)
            )
            print(f'Renamed {filename} to {new_name}')

directory_path = '/path/to/directory'
rename_files_with_prefix(directory_path, 'project_')

```
### 按文件大小排序并输出路径
   想要在目录中找出最大的文件？我们可以利用 os.walk 和递归将文件按大小排序，并输出前几个最大的文件路径：

```python
import os

def find_largest_files(dir_path, n=5):
    file_list = []
    for root, dirs, files in os.walk(dir_path):
        for filename in files:
            filepath = os.path.join(root, filename)
            file_size = os.path.getsize(filepath)
            file_list.append((filepath, file_size))

    # 按文件大小降序排序
    file_list.sort(key=lambda x: x[1], reverse=True)
    for filepath, size in file_list[:n]:
        print(f'{filepath}: {size} bytes')

directory_path = '/path/to/directory'
find_largest_files(directory_path)

```

这段代码将输出目录中最大的 n 个文件路径及其大小。

## 注意事项
* 符号链接：在递归过程中，os.walk 默认会遍历符号链接指向的目录，如果不小心可能会造成无限递归。可以在遍历前过滤掉符号链接。

* 文件权限：在遍历文件时，可能遇到没有权限访问的文件或目录，这会导致异常。在处理这些情况时，可以使用 try-except 块捕获异常并处理。

* 效率问题：os.walk 本身在大部分场景下效率足够，但如果目录结构极其庞大，可以考虑多线程或多进程来提高性能。

## 总结
Python 提供了强大的 os.walk 函数，使我们能够轻松实现对目录树的递归遍历。结合递归函数，我们可以对目录树进行更加灵活的控制，不仅可以进行统计、重命名等操作，还能实现排序、筛选等复杂功能。

希望通过本文，大家能对 os.walk 与递归有更深入的理解，并在实际项目中灵活运用。无论是日志清理、批量处理，还是文件分析，os.walk 都能成为你手中不可或缺的利器。



## 参考链接
* [Python 官方文档：os.walk](https://docs.python.org/3/library/os.html#os.walk)
* [递归](https://zh.wikipedia.org/wiki/%E9%80%92%E5%BD%92%E5%87%BD%E6%95%B0)
