---
title: "在Python中保存 shell 输出到变量"
description: "在Python编程中，经常需要与操作系统的 shell 进行交互并获取 shell 命令执行的输出结果。将这些输出保存到变量中，能方便后续对输出信息进行处理、分析或展示。本文将详细介绍如何在Python中把 shell 输出保存到变量中，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践技巧。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，经常需要与操作系统的 shell 进行交互并获取 shell 命令执行的输出结果。将这些输出保存到变量中，能方便后续对输出信息进行处理、分析或展示。本文将详细介绍如何在Python中把 shell 输出保存到变量中，涵盖基础概念、不同的使用方法、常见实践场景以及最佳实践技巧。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `subprocess` 模块
    - `os.popen()` 方法
3. **常见实践**
    - 获取系统信息
    - 文件操作相关
4. **最佳实践**
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在Python中，要与 shell 进行交互并获取输出，主要是通过调用操作系统的 shell 来执行命令，并捕获命令执行后的输出内容。不同的操作系统（如 Linux、Windows 和 macOS）在底层实现上有一些差异，但Python提供了一些跨平台的方法来处理这种需求。将 shell 输出保存到变量中，就是把命令执行后的标准输出（stdout）或者标准错误输出（stderr）存储在Python的变量里，以便后续在程序中进一步处理。

## 使用方法

### `subprocess` 模块
`subprocess` 模块是Python 3中推荐使用的与外部进程进行交互的模块，它提供了一种更高级、更灵活且更安全的方式来执行 shell 命令并获取输出。

```python
import subprocess

# 执行命令并获取输出
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)

# 输出存储在 result.stdout 中
print(result.stdout)
```

在上述代码中：
- `subprocess.run()` 函数用于执行 shell 命令。第一个参数是一个包含命令及其参数的列表。
- `capture_output=True` 表示捕获标准输出和标准错误输出。
- `text=True` 确保输出以文本形式返回，而不是字节形式。

如果要单独获取标准错误输出，可以使用 `result.stderr`。

### `os.popen()` 方法
`os.popen()` 是一个较旧的方法，它返回一个连接到外部命令的管道对象。虽然它使用起来相对简单，但在功能和安全性上不如 `subprocess` 模块。

```python
import os

# 执行命令并获取输出
output = os.popen('ls -l').read()
print(output)
```

在这个例子中，`os.popen()` 执行 `ls -l` 命令，并通过 `read()` 方法读取命令的输出，将其存储在 `output` 变量中。

## 常见实践

### 获取系统信息
通过执行系统命令来获取系统相关信息，例如系统内存使用情况。

```python
import subprocess

# 获取内存使用信息
result = subprocess.run(['free', '-h'], capture_output=True, text=True)
print(result.stdout)
```

### 文件操作相关
列出指定目录下的文件列表是常见的文件操作场景。

```python
import subprocess

# 列出当前目录下的文件
result = subprocess.run(['ls', '-a'], capture_output=True, text=True)
print(result.stdout)
```

## 最佳实践

### 错误处理
在执行 shell 命令时，可能会因为各种原因导致命令执行失败。因此，合理的错误处理是非常重要的。

```python
import subprocess

try:
    result = subprocess.run(['non_existent_command'], capture_output=True, text=True)
    print(result.stdout)
except FileNotFoundError:
    print("命令未找到")
```

在上述代码中，通过 `try - except` 块捕获 `FileNotFoundError` 异常，以处理命令不存在的情况。

### 性能优化
对于频繁执行的 shell 命令，可以考虑缓存结果以提高性能。

```python
import subprocess
import time

cached_result = None
cache_time = 60  # 缓存有效期 60 秒
last_cache_time = 0

def get_system_info():
    global cached_result, last_cache_time
    current_time = time.time()
    if cached_result is None or current_time - last_cache_time > cache_time:
        result = subprocess.run(['free', '-h'], capture_output=True, text=True)
        cached_result = result.stdout
        last_cache_time = current_time
    return cached_result

print(get_system_info())
```

在这个示例中，使用了缓存机制，只有当缓存过期或者缓存为空时才重新执行命令获取输出。

## 小结
在Python中把 shell 输出保存到变量有多种方法，`subprocess` 模块由于其灵活性和安全性成为推荐的选择，而 `os.popen()` 虽然简单但功能有限。在实际应用中，要根据具体需求选择合适的方法，并注意错误处理和性能优化等最佳实践，以确保程序的稳定性和高效性。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}