---
title: "Python 运行 Shell 命令：从基础到实践"
description: "在 Python 编程中，经常会有需要调用系统的 Shell 命令来执行特定任务的场景。这可能包括文件操作、系统管理、运行外部脚本等。掌握如何在 Python 中运行 Shell 命令，能极大地扩展 Python 的功能边界，使开发者可以将 Python 的灵活性与 Shell 命令的强大功能相结合。本文将深入探讨 Python 运行 Shell 命令的相关知识，从基础概念到实际应用和最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 编程中，经常会有需要调用系统的 Shell 命令来执行特定任务的场景。这可能包括文件操作、系统管理、运行外部脚本等。掌握如何在 Python 中运行 Shell 命令，能极大地扩展 Python 的功能边界，使开发者可以将 Python 的灵活性与 Shell 命令的强大功能相结合。本文将深入探讨 Python 运行 Shell 命令的相关知识，从基础概念到实际应用和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.system`
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 文件操作
    - 系统监控
    - 运行外部脚本
4. 最佳实践
    - 安全考量
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
Shell 是一种命令行解释器，它提供了用户与操作系统内核进行交互的接口。在 Linux 和 macOS 系统中，常见的 Shell 有 Bash；在 Windows 系统中，则是命令提示符（CMD）或 PowerShell。当我们在 Python 中运行 Shell 命令时，实际上是通过 Python 程序启动一个子进程来执行相应的 Shell 命令，并获取命令执行的结果或状态。

## 使用方法

### 使用 `os.system`
`os.system` 是 Python 标准库 `os` 模块中的一个函数，用于在系统 shell 中执行命令。

```python
import os

# 执行简单的 Shell 命令，例如列出当前目录下的文件
return_code = os.system('ls -l')
print(f"命令执行返回码: {return_code}")
```

在这个示例中，`os.system` 执行了 `ls -l` 命令，并返回命令的退出状态码。如果命令成功执行，返回码通常为 0；否则返回一个非零值。

### 使用 `os.popen`
`os.popen` 同样来自 `os` 模块，它可以执行 Shell 命令并返回一个文件对象，通过这个对象可以读取命令的输出。

```python
import os

# 执行命令并读取输出
result = os.popen('ls -l').read()
print(result)
```

`os.popen` 会返回命令的标准输出内容，在这个例子中，`result` 变量存储了 `ls -l` 命令的输出结果。

### 使用 `subprocess` 模块
`subprocess` 模块是 Python 3 中推荐使用的运行 Shell 命令的方式，它提供了更强大、更灵活的功能，包括处理输入输出、错误处理等。

```python
import subprocess

# 执行命令并获取输出和返回码
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(f"命令输出: {result.stdout}")
print(f"命令返回码: {result.returncode}")
```

在这个示例中，`subprocess.run` 方法执行了 `ls -l` 命令。`capture_output=True` 表示捕获命令的标准输出和标准错误输出，`text=True` 表示以文本形式返回输出内容。`result.stdout` 存储了标准输出，`result.returncode` 存储了命令的返回码。

## 常见实践

### 文件操作
使用 Shell 命令进行文件操作是常见的需求。例如，复制文件可以使用 `cp` 命令。

```python
import subprocess

source_file = 'example.txt'
destination_folder = 'backup/'

# 构建复制文件的 Shell 命令
command = ['cp', source_file, destination_folder]

# 执行命令
result = subprocess.run(command, capture_output=True, text=True)

if result.returncode == 0:
    print(f"{source_file} 已成功复制到 {destination_folder}")
else:
    print(f"复制文件时出错: {result.stderr}")
```

### 系统监控
可以使用 Shell 命令获取系统信息，如 CPU 使用率、内存使用情况等。

```python
import subprocess

# 获取 CPU 使用率
command = ['top', '-bn1', '|', 'grep', '%Cpu']
result = subprocess.run(' '.join(command), shell=True, capture_output=True, text=True)
print(f"CPU 使用率: {result.stdout}")

# 获取内存使用情况
command = ['free', '-h']
result = subprocess.run(command, capture_output=True, text=True)
print(f"内存使用情况: {result.stdout}")
```

### 运行外部脚本
在 Python 中可以运行其他的 Shell 脚本或可执行文件。

```python
import subprocess

# 运行一个 Shell 脚本
script_path = './example.sh'
result = subprocess.run(['bash', script_path], capture_output=True, text=True)
print(f"脚本输出: {result.stdout}")
```

## 最佳实践

### 安全考量
避免使用 `shell=True`，尤其是在处理用户输入的命令时。因为 `shell=True` 会将命令字符串传递给系统 shell 执行，这可能导致安全漏洞，如命令注入攻击。如果必须使用 `shell=True`，请确保命令字符串是完全可信的。

### 错误处理
始终对命令执行的返回码进行检查，以确定命令是否成功执行。同时，捕获并处理命令的标准错误输出，以便及时发现和解决问题。

### 性能优化
如果需要频繁执行 Shell 命令，可以考虑将相关的功能封装成函数或类，以提高代码的可维护性和性能。另外，合理使用缓存机制，避免重复执行相同的命令。

## 小结
在 Python 中运行 Shell 命令有多种方式，每种方式都有其特点和适用场景。`os.system` 和 `os.popen` 简单易用，但功能相对有限；`subprocess` 模块则提供了更强大、更安全和灵活的功能，是推荐的使用方式。在实际应用中，需要根据具体需求选择合适的方法，并遵循最佳实践，确保代码的安全性、稳定性和性能。

## 参考资料
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Real Python - Running Shell Commands in Python](https://realpython.com/run-shell-commands-in-python/){: rel="nofollow"}