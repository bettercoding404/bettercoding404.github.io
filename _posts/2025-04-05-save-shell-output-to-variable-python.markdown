---
title: "在Python中保存 shell 输出到变量"
description: "在Python编程中，我们经常需要与操作系统的 shell 进行交互，获取 shell 命令执行的结果并将其保存到变量中，以便后续在程序中进行处理和分析。这一操作在系统管理、自动化脚本编写以及与外部工具集成等场景中尤为重要。本文将详细介绍如何在Python中实现将 shell 输出保存到变量的功能，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，我们经常需要与操作系统的 shell 进行交互，获取 shell 命令执行的结果并将其保存到变量中，以便后续在程序中进行处理和分析。这一操作在系统管理、自动化脚本编写以及与外部工具集成等场景中尤为重要。本文将详细介绍如何在Python中实现将 shell 输出保存到变量的功能，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.system`
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 获取系统信息
    - 文件操作相关
4. 最佳实践
    - 错误处理
    - 安全性
5. 小结
6. 参考资料

## 基础概念
在Python中，要与 shell 进行交互并获取其输出，我们需要借助一些内置模块。不同的方法在功能、易用性和安全性上有所不同。基本思路是调用系统的 shell 命令，捕获其标准输出（有时还包括标准错误输出），并将这些输出存储在Python变量中，以便在程序中进一步使用。

## 使用方法

### 使用 `os.system`
`os.system` 是Python标准库 `os` 模块中的一个函数，用于在操作系统 shell 中执行命令。然而，它的返回值是命令的退出状态码，而不是命令的输出。不过，我们可以通过将命令的输出重定向到文件，然后读取文件内容来获取输出。

```python
import os

# 执行命令并将输出重定向到临时文件
os.system('ls -l > output.txt')

# 读取临时文件内容
with open('output.txt', 'r') as f:
    output = f.read()

# 删除临时文件
os.remove('output.txt')

print(output)
```

### 使用 `os.popen`
`os.popen` 函数可以执行 shell 命令并返回一个文件对象，通过该对象可以读取命令的输出。

```python
import os

# 执行命令并获取输出文件对象
p = os.popen('ls -l')
output = p.read()
p.close()

print(output)
```

### 使用 `subprocess` 模块
`subprocess` 模块是Python 3中推荐的用于与子进程交互的模块，它提供了更强大、更灵活的功能，包括获取标准输出、标准错误输出以及设置超时等。

```python
import subprocess

# 执行命令并获取输出
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
output = result.stdout

print(output)
```

在上述代码中：
- `subprocess.run` 是执行命令的主要函数。
- `['ls', '-l']` 是要执行的命令和参数列表。
- `capture_output=True` 表示捕获标准输出和标准错误输出。
- `text=True` 表示以文本形式返回输出，而不是字节形式。

## 常见实践

### 获取系统信息
```python
import subprocess

# 获取系统内存信息
result = subprocess.run(['free', '-h'], capture_output=True, text=True)
memory_info = result.stdout

print(memory_info)
```

### 文件操作相关
```python
import subprocess

# 获取当前目录下文件列表
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
file_list = result.stdout

print(file_list)
```

## 最佳实践

### 错误处理
在执行 shell 命令时，可能会出现各种错误，如命令不存在、权限不足等。`subprocess` 模块提供了方便的错误处理机制。

```python
import subprocess

try:
    result = subprocess.run(['nonexistent_command'], capture_output=True, text=True, check=True)
    output = result.stdout
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，错误码: {e.returncode}")
    print(f"标准错误输出: {e.stderr}")
```

在上述代码中，`check=True` 表示如果命令返回非零退出状态码，将抛出 `subprocess.CalledProcessError` 异常。

### 安全性
当使用用户输入构建 shell 命令时，要特别注意安全性，防止命令注入攻击。推荐使用 `subprocess` 模块的列表形式传递命令和参数，而不是直接拼接字符串。

```python
import subprocess

user_input = "malicious_command; rm -rf /"  # 模拟恶意输入

# 正确方式，使用列表传递参数
result = subprocess.run(['echo', user_input], capture_output=True, text=True)
output = result.stdout

print(output)

# 错误方式，可能导致命令注入
command = 'echo'+ user_input
result = subprocess.run(command, shell=True, capture_output=True, text=True)
output = result.stdout

print(output)  # 这种方式可能会执行恶意命令
```

## 小结
在Python中保存 shell 输出到变量有多种方法，每种方法都有其优缺点。`os.system` 和 `os.popen` 是较老的方法，功能相对有限，而 `subprocess` 模块提供了更强大、更安全的功能，是推荐使用的方式。在实际应用中，要注意错误处理和安全性，确保程序的稳定性和可靠性。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}