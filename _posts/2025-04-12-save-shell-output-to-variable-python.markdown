---
title: "在 Python 中保存 shell 输出到变量"
description: "在 Python 编程中，我们经常需要与系统的 shell 进行交互，获取 shell 命令执行的输出结果，并将其保存到变量中以便后续处理。这一操作在很多场景下都非常有用，比如获取系统信息、执行外部脚本并处理其返回值等。本文将详细介绍如何在 Python 中实现将 shell 输出保存到变量中，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在 Python 编程中，我们经常需要与系统的 shell 进行交互，获取 shell 命令执行的输出结果，并将其保存到变量中以便后续处理。这一操作在很多场景下都非常有用，比如获取系统信息、执行外部脚本并处理其返回值等。本文将详细介绍如何在 Python 中实现将 shell 输出保存到变量中，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 获取系统磁盘使用情况
    - 执行自定义 shell 脚本并获取输出
4. 最佳实践
    - 错误处理
    - 安全考量
5. 小结
6. 参考资料

## 基础概念
在 Python 中，要与 shell 进行交互并获取输出，我们需要借助一些内置的模块和函数。主要涉及到的模块有 `os` 和 `subprocess`。`os` 模块提供了与操作系统交互的功能，而 `subprocess` 模块则用于创建新进程、连接到它们的输入/输出/错误管道，并获取它们的返回码。将 shell 输出保存到变量，就是在执行 shell 命令后，捕获其标准输出（有时也包括标准错误输出）并存储在 Python 的变量中，以便进一步分析和处理。

## 使用方法
### 使用 `os.popen`
`os.popen` 是一种较简单的方法来执行 shell 命令并获取输出。它返回一个文件对象，我们可以通过读取这个文件对象来获取命令的输出。

```python
import os

# 执行命令并获取输出
command = "ls -l"
output = os.popen(command).read()
print(output)
```

在上述代码中，我们使用 `os.popen` 执行了 `ls -l` 命令，并通过 `read()` 方法将输出读取到 `output` 变量中。然后打印出 `output` 变量的内容。

### 使用 `subprocess` 模块
`subprocess` 模块是 Python 3 推荐使用的与子进程交互的方式，它提供了更强大和灵活的功能。

```python
import subprocess

# 执行命令并获取输出
command = ["ls", "-l"]
result = subprocess.run(command, capture_output=True, text=True)
output = result.stdout
print(output)
```

在这段代码中，我们使用 `subprocess.run` 方法执行了 `ls -l` 命令。`capture_output=True` 表示捕获标准输出和标准错误输出，`text=True` 表示以文本形式返回输出。`result.stdout` 存储了命令的标准输出，我们将其赋值给 `output` 变量并打印。

## 常见实践
### 获取系统磁盘使用情况
```python
import subprocess

# 执行 df -h 命令获取磁盘使用情况
command = ["df", "-h"]
result = subprocess.run(command, capture_output=True, text=True)
disk_usage = result.stdout
print(disk_usage)
```

### 执行自定义 shell 脚本并获取输出
假设我们有一个名为 `my_script.sh` 的 shell 脚本：

```bash
#!/bin/bash
echo "This is a custom shell script"
```

在 Python 中执行该脚本并获取输出：

```python
import subprocess

# 执行自定义 shell 脚本
command = ["./my_script.sh"]
result = subprocess.run(command, capture_output=True, text=True)
script_output = result.stdout
print(script_output)
```

## 最佳实践
### 错误处理
在执行 shell 命令时，可能会发生各种错误，如命令不存在、权限不足等。我们需要对这些错误进行处理。

```python
import subprocess

command = ["non_existent_command"]
try:
    result = subprocess.run(command, capture_output=True, text=True, check=True)
    output = result.stdout
    print(output)
except subprocess.CalledProcessError as e:
    print(f"Error occurred: {e}")
    print(f"Error output: {e.stderr}")
```

在上述代码中，`check=True` 表示如果命令返回非零退出码，将引发 `subprocess.CalledProcessError` 异常。我们通过捕获这个异常来处理错误，并打印错误信息和错误输出。

### 安全考量
当执行用户输入的 shell 命令时，要特别注意安全问题，防止命令注入攻击。避免直接拼接用户输入到命令字符串中，尽量使用 `subprocess` 模块的参数形式传递命令和参数。

```python
import subprocess

user_input = "some_input"
# 正确的方式
command = ["command", user_input]
subprocess.run(command, capture_output=True, text=True)

# 错误的方式（可能存在命令注入风险）
command = f"command {user_input}"
subprocess.run(command, shell=True, capture_output=True, text=True)
```

## 小结
在 Python 中保存 shell 输出到变量有多种方法，`os.popen` 简单易用但功能相对有限，`subprocess` 模块则提供了更强大和灵活的功能，是推荐的方式。在实际应用中，我们要注意错误处理和安全考量，确保程序的健壮性和安全性。通过合理运用这些方法和实践，可以有效地与 shell 进行交互并处理其输出。

## 参考资料
- 《Python 核心编程》