---
title: "在 Python 中保存 shell 输出到变量"
description: "在 Python 编程中，经常需要与操作系统的 shell 进行交互，获取 shell 命令执行后的输出结果并进行进一步处理。将 shell 输出保存到变量是一个非常实用的操作，它允许我们在 Python 脚本中灵活地使用这些输出数据，比如进行文本分析、数据提取或者基于输出结果进行后续的逻辑判断。本文将详细介绍在 Python 中如何将 shell 输出保存到变量，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，经常需要与操作系统的 shell 进行交互，获取 shell 命令执行后的输出结果并进行进一步处理。将 shell 输出保存到变量是一个非常实用的操作，它允许我们在 Python 脚本中灵活地使用这些输出数据，比如进行文本分析、数据提取或者基于输出结果进行后续的逻辑判断。本文将详细介绍在 Python 中如何将 shell 输出保存到变量，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **使用 `os.system` 模块（有限功能）**
    - **使用 `subprocess` 模块**
        - **`subprocess.run` 方法**
        - **`subprocess.Popen` 方法**
3. **常见实践**
    - **获取系统信息**
    - **文件操作相关输出处理**
4. **最佳实践**
    - **错误处理与异常捕获**
    - **安全性考量**
5. **小结**
6. **参考资料**

## 基础概念
在 Python 与 shell 交互的过程中，我们通过调用系统的 shell 环境来执行各种命令，例如查看文件列表、获取系统状态等。将 shell 输出保存到变量，就是在 Python 脚本中创建一个变量，把 shell 命令执行后返回的文本信息存储在这个变量里，以便后续在 Python 代码中对这些信息进行操作。

## 使用方法

### 使用 `os.system` 模块（有限功能）
`os.system` 是 Python 标准库 `os` 模块中的一个函数，用于在操作系统中执行 shell 命令。然而，它的返回值仅为命令执行的状态码（0 表示成功执行），并不直接返回命令的输出结果。如果要获取输出，需要一些额外的技巧。

```python
import os

# 执行命令并获取状态码
status = os.system('ls -l')

# 如果需要获取输出，一种简单但不太优雅的方法是将输出重定向到文件，然后读取文件内容
os.system('ls -l > output.txt')
with open('output.txt', 'r') as f:
    output = f.read()
    print(output)
```

这种方法有明显的局限性，比如处理复杂命令和实时获取输出不太方便，而且需要额外的文件操作。因此，更推荐使用 `subprocess` 模块。

### 使用 `subprocess` 模块
`subprocess` 模块是 Python 用于处理子进程的标准库，提供了更强大和灵活的方式来与 shell 进行交互并获取输出。

#### `subprocess.run` 方法
`subprocess.run` 是 `subprocess` 模块中较新且常用的方法，它会阻塞当前进程，直到子进程完成执行。

```python
import subprocess

# 执行命令并获取输出
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
if result.returncode == 0:
    output = result.stdout
    print(output)
else:
    error = result.stderr
    print(f"Error: {error}")
```

在上述代码中：
- `['ls', '-l']` 是要执行的命令及其参数，以列表形式传递。
- `capture_output=True` 表示捕获标准输出和标准错误输出。
- `text=True` 表示以文本形式返回输出，而不是字节流。

#### `subprocess.Popen` 方法
`subprocess.Popen` 方法用于创建一个新的子进程并返回一个 Popen 对象。它不会阻塞当前进程，适合需要与子进程进行实时交互的场景。

```python
import subprocess

# 创建子进程
process = subprocess.Popen(['ls', '-l'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
stdout, stderr = process.communicate()

if process.returncode == 0:
    output = stdout
    print(output)
else:
    error = stderr
    print(f"Error: {error}")
```

在这段代码中：
- `stdout=subprocess.PIPE` 和 `stderr=subprocess.PIPE` 表示将标准输出和标准错误输出通过管道返回。
- `process.communicate()` 方法用于与子进程进行通信，等待子进程完成并获取输出。

## 常见实践

### 获取系统信息
```python
import subprocess

# 获取系统内存信息
result = subprocess.run(['free', '-h'], capture_output=True, text=True)
if result.returncode == 0:
    memory_info = result.stdout
    print(memory_info)
else:
    print(f"Error: {result.stderr}")
```

### 文件操作相关输出处理
```python
import subprocess

# 获取当前目录下文件数量
result = subprocess.run(['ls', '-l | wc -l'], shell=True, capture_output=True, text=True)
if result.returncode == 0:
    file_count = result.stdout.strip()
    print(f"Number of files: {file_count}")
else:
    print(f"Error: {result.stderr}")
```

## 最佳实践

### 错误处理与异常捕获
在执行 shell 命令时，可能会出现各种错误，如命令不存在、权限不足等。因此，良好的错误处理和异常捕获机制是必不可少的。

```python
import subprocess

try:
    result = subprocess.run(['non_existent_command'], capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"Error occurred: {e}")
    print(f"Error output: {e.stderr}")
```

在上述代码中，`check=True` 会在命令返回非零状态码时抛出 `subprocess.CalledProcessError` 异常，我们可以捕获这个异常并进行相应处理。

### 安全性考量
当使用 `subprocess` 模块执行 shell 命令时，如果参数是由用户输入提供的，要特别注意安全性。避免使用 `shell=True`，因为这可能会导致命令注入漏洞。如果必须使用 `shell=True`，要对用户输入进行严格的验证和过滤。

```python
import subprocess

user_input = "ls -l; rm -rf /"  # 恶意输入示例
# 不要这样做
# subprocess.run(user_input, shell=True)

# 正确做法，使用列表形式传递参数
safe_command = ['ls', '-l']
subprocess.run(safe_command)
```

## 小结
在 Python 中，将 shell 输出保存到变量有多种方法，`os.system` 模块功能有限，而 `subprocess` 模块提供了更强大和灵活的方式，其中 `subprocess.run` 和 `subprocess.Popen` 各有适用场景。在实际应用中，要注重错误处理、异常捕获以及安全性考量，以确保代码的健壮性和可靠性。通过合理运用这些方法和最佳实践，我们可以更高效地在 Python 脚本中与 shell 进行交互，并处理 shell 命令的输出结果。

## 参考资料