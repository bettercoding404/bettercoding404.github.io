---
title: "在Python中保存 shell 输出到变量"
description: "在Python编程中，经常需要与系统的 shell 进行交互，获取 shell 命令执行后的输出结果，并将其保存到变量中以便后续处理。这一操作在很多场景下都非常有用，比如系统监控脚本、自动化部署工具等。本文将详细介绍如何在Python中把 shell 输出保存到变量，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在Python编程中，经常需要与系统的 shell 进行交互，获取 shell 命令执行后的输出结果，并将其保存到变量中以便后续处理。这一操作在很多场景下都非常有用，比如系统监控脚本、自动化部署工具等。本文将详细介绍如何在Python中把 shell 输出保存到变量，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 使用 `os.system`
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. **常见实践**
    - 获取系统信息
    - 执行外部脚本并获取输出
4. **最佳实践**
    - 错误处理
    - 安全性考量
5. **小结**
6. **参考资料**

## 基础概念
在Python中与 shell 进行交互并保存输出到变量，核心在于调用系统 shell 来执行命令，并捕获命令执行的输出内容。不同的方法在功能、易用性和安全性上有所差异。

## 使用方法

### 使用 `os.system`
`os.system` 函数可以在Python中执行 shell 命令，但它的返回值是命令的退出状态码，而不是命令的输出。不过可以通过重定向标准输出到文件，再读取文件内容来间接获取输出。

```python
import os

# 执行命令并将输出重定向到文件
os.system('ls -l > output.txt')

# 读取文件内容
with open('output.txt', 'r') as f:
    output = f.read()

print(output)
```

### 使用 `os.popen`
`os.popen` 函数会返回一个文件对象，通过这个对象可以读取命令的输出。

```python
import os

# 执行命令并获取输出
output = os.popen('ls -l').read()

print(output)
```

### 使用 `subprocess` 模块
`subprocess` 模块是Python 3中推荐的与外部进程交互的方式，它提供了更强大和灵活的功能。

```python
import subprocess

# 使用 subprocess.run
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
output = result.stdout

print(output)

# 或者使用 subprocess.Popen
process = subprocess.Popen(['ls', '-l'], stdout=subprocess.PIPE, text=True)
output, _ = process.communicate()

print(output)
```

## 常见实践

### 获取系统信息
通过执行系统命令获取系统信息，如内存使用情况。

```python
import subprocess

# 获取内存使用信息
result = subprocess.run(['free', '-h'], capture_output=True, text=True)
memory_info = result.stdout

print(memory_info)
```

### 执行外部脚本并获取输出
执行外部的 shell 脚本并获取其输出。

```python
import subprocess

# 执行外部脚本
result = subprocess.run(['./external_script.sh'], capture_output=True, text=True)
script_output = result.stdout

print(script_output)
```

## 最佳实践

### 错误处理
在执行 shell 命令时，需要处理可能出现的错误。`subprocess` 模块提供了很好的错误处理机制。

```python
import subprocess

try:
    result = subprocess.run(['nonexistent_command'], capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"命令执行出错: {e}")
    print(f"错误输出: {e.stderr}")
```

### 安全性考量
避免直接将用户输入作为 shell 命令执行，以防止命令注入攻击。如果必须使用用户输入，要进行严格的输入验证和过滤。

```python
import subprocess

user_input = "safe_input"
command = ['ls', user_input]
result = subprocess.run(command, capture_output=True, text=True)
```

## 小结
在Python中保存 shell 输出到变量有多种方法，`os.system`、`os.popen` 和 `subprocess` 模块各有特点。`subprocess` 模块由于其强大的功能和良好的安全性，是推荐的使用方式。在实际应用中，要注意错误处理和安全性考量，以确保程序的稳定和安全运行。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}