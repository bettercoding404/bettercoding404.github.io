---
title: "Python调用外部进程：从基础到实践"
description: "在Python编程中，调用外部进程是一项非常实用的技能。通过调用外部进程，我们可以利用系统中已有的各种工具和程序，将它们的功能集成到我们的Python应用中。这不仅可以节省开发时间，还能充分发挥不同工具的优势。本文将详细介绍Python调用进程的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握这一技术。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，调用外部进程是一项非常实用的技能。通过调用外部进程，我们可以利用系统中已有的各种工具和程序，将它们的功能集成到我们的Python应用中。这不仅可以节省开发时间，还能充分发挥不同工具的优势。本文将详细介绍Python调用进程的基础概念、使用方法、常见实践以及最佳实践，帮助你全面掌握这一技术。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.system`
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 执行 shell 脚本
    - 调用外部可执行程序
    - 获取外部进程输出
4. 最佳实践
    - 错误处理
    - 安全考量
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
在操作系统中，进程是程序在操作系统中的一次执行过程，是系统进行资源分配和调度的基本单位。Python作为一种高级编程语言，提供了多种方式来调用外部进程。调用外部进程意味着在Python程序的运行过程中，启动并与其他独立的程序或脚本进行交互。这些外部进程可以是系统自带的命令行工具，也可以是我们自己开发的独立可执行程序。

## 使用方法

### 使用 `os.system`
`os.system` 是Python标准库 `os` 模块中的一个函数，用于在操作系统的 shell 中执行命令。它的语法很简单：
```python
import os

return_code = os.system('ls -l')
print(f"命令返回码: {return_code}")
```
在这个例子中，`os.system` 执行了 `ls -l` 命令，返回码 `return_code` 表示命令执行的结果。如果返回码为0，表示命令成功执行；非零值表示有错误发生。

### 使用 `os.popen`
`os.popen` 同样来自 `os` 模块，它不仅可以执行命令，还能获取命令的输出。
```python
import os

result = os.popen('ls -l').read()
print(result)
```
这里 `os.popen` 执行 `ls -l` 命令，并通过 `read()` 方法读取命令的输出结果。不过，`os.popen` 已被标记为过时，在新的代码中推荐使用 `subprocess` 模块。

### 使用 `subprocess` 模块
`subprocess` 模块是Python 3中用于处理子进程的推荐模块，它提供了更强大、更灵活的功能。
```python
import subprocess

# 执行命令并获取输出
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```
`subprocess.run` 方法接受一个命令和参数的列表作为第一个参数。`capture_output=True` 表示捕获标准输出和标准错误，`text=True` 表示以文本形式返回输出结果。

## 常见实践

### 执行 shell 脚本
假设我们有一个名为 `script.sh` 的 shell 脚本：
```bash
#!/bin/bash
echo "这是一个 shell 脚本"
```
在Python中执行这个脚本：
```python
import subprocess

subprocess.run(['bash','script.sh'], text=True)
```

### 调用外部可执行程序
例如，调用系统中的 `notepad.exe`（Windows系统）：
```python
import subprocess

subprocess.Popen(['notepad.exe'])
```
`Popen` 方法用于启动一个新进程，与 `run` 方法不同，它不会等待进程结束，而是立即返回。

### 获取外部进程输出
我们可以通过 `subprocess.run` 的 `capture_output` 参数获取外部进程的输出：
```python
import subprocess

result = subprocess.run(['echo', '你好，世界'], capture_output=True, text=True)
print(result.stdout)
```

## 最佳实践

### 错误处理
在调用外部进程时，需要妥善处理可能出现的错误。可以通过检查返回码来判断命令是否成功执行：
```python
import subprocess

result = subprocess.run(['false'], capture_output=True, text=True)
if result.returncode != 0:
    print(f"命令执行错误: {result.stderr}")
```

### 安全考量
在调用外部进程时，要注意安全问题，特别是在处理用户输入时。避免直接将用户输入作为命令的一部分执行，以防止命令注入攻击。可以使用 `subprocess` 模块的参数化方式来处理输入：
```python
import subprocess

user_input = "example.txt"
subprocess.run(['ls', user_input], text=True)
```

### 性能优化
如果需要频繁调用外部进程，可以考虑优化性能。例如，使用缓存机制，避免重复执行相同的命令。另外，合理选择调用方式，对于长时间运行的进程，可以使用异步调用，以提高程序的响应速度。

## 小结
本文详细介绍了Python调用外部进程的相关知识，包括基础概念、多种使用方法、常见实践以及最佳实践。通过掌握这些内容，你可以在Python程序中灵活地调用外部工具和程序，扩展程序的功能。在实际应用中，要根据具体需求选择合适的调用方式，并注意错误处理和安全问题，以确保程序的稳定和安全运行。

## 参考资料
- 《Python Cookbook》
- 《Effective Python》