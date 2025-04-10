---
title: "Python运行Shell命令：从基础到最佳实践"
description: "在Python编程中，能够运行Shell命令是一项非常实用的技能。这使得Python可以与操作系统进行交互，执行各种系统级任务，如文件操作、系统配置管理、调用外部工具等。本文将深入探讨Python运行Shell命令的相关知识，帮助你掌握这一强大的功能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在Python编程中，能够运行Shell命令是一项非常实用的技能。这使得Python可以与操作系统进行交互，执行各种系统级任务，如文件操作、系统配置管理、调用外部工具等。本文将深入探讨Python运行Shell命令的相关知识，帮助你掌握这一强大的功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess`模块
3. **常见实践**
    - 执行简单命令
    - 获取命令输出
    - 处理命令错误
4. **最佳实践**
    - 安全性考量
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在Python中运行Shell命令，本质上是通过Python程序调用操作系统的Shell环境来执行特定的命令。不同的操作系统（如Linux、Windows、macOS）都有各自的Shell，如Linux和macOS常用的Bash，Windows的CMD或PowerShell。Python提供了多种方式来实现这一功能，每种方式都有其特点和适用场景。

## 使用方法

### `os.system`
`os.system`是Python标准库`os`模块中一个简单的函数，用于在操作系统的Shell中执行命令。其基本语法如下：
```python
import os

return_code = os.system('command')
```
示例：
```python
import os

return_code = os.system('ls -l')
print(f"命令返回码: {return_code}")
```
在上述示例中，`os.system`执行了`ls -l`命令来列出当前目录下的文件和目录详细信息，并返回命令的执行结果（返回码）。返回码为0表示命令成功执行，非零值表示有错误发生。

### `os.popen`
`os.popen`函数也来自`os`模块，它不仅可以执行命令，还可以获取命令的输出。语法如下：
```python
import os

file_object = os.popen('command')
output = file_object.read()
file_object.close()
```
示例：
```python
import os

file_object = os.popen('ls -l')
output = file_object.read()
file_object.close()
print(output)
```
这里通过`os.popen`执行`ls -l`命令，并使用`read`方法读取命令输出，最后关闭文件对象。

### `subprocess`模块
`subprocess`模块是Python 2.4及以上版本推荐使用的处理子进程的模块，它提供了更强大、更灵活的功能来运行Shell命令。
- **执行命令并获取输出**
```python
import subprocess

result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```
在这个示例中，`subprocess.run`函数执行了`ls -l`命令。`capture_output=True`表示捕获标准输出和标准错误输出，`text=True`表示以文本形式返回输出结果。
- **执行命令并检查返回码**
```python
import subprocess

try:
    result = subprocess.run(['ls', 'non_existent_directory'], check=True)
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，返回码: {e.returncode}")
```
`check=True`参数会使`subprocess.run`在命令返回非零返回码时抛出`CalledProcessError`异常，通过捕获这个异常可以处理命令执行失败的情况。

## 常见实践

### 执行简单命令
比如创建一个新目录，可以使用以下代码：
```python
import subprocess

subprocess.run(['mkdir', 'new_directory'], check=True)
```

### 获取命令输出
获取系统磁盘使用情况的信息：
```python
import subprocess

result = subprocess.run(['df', '-h'], capture_output=True, text=True)
print(result.stdout)
```

### 处理命令错误
在复制文件时，如果源文件不存在，捕获并处理错误：
```python
import subprocess

try:
    subprocess.run(['cp','source_file.txt', 'destination_folder'], check=True)
except subprocess.CalledProcessError as e:
    print(f"复制文件失败，返回码: {e.returncode}")
```

## 最佳实践

### 安全性考量
在运行用户输入的命令时要格外小心，避免命令注入攻击。例如，不要直接将用户输入拼接成命令字符串，而应该使用`subprocess`模块的参数形式来传递输入。
错误示例：
```python
import os
user_input = "evil_command; rm -rf /"  # 模拟恶意输入
os.system(f'command {user_input}')
```
正确示例：
```python
import subprocess
user_input = "valid_argument"
subprocess.run(['command', user_input], check=True)
```

### 性能优化
对于频繁执行的命令，考虑缓存结果或优化命令本身。例如，如果需要多次获取系统时间，可以使用Python的`time`模块，而不是每次都调用系统命令。
```python
import time

current_time = time.strftime("%Y-%m-%d %H:%M:%S")
print(current_time)
```

## 小结
本文详细介绍了Python运行Shell命令的基础概念、多种使用方法、常见实践以及最佳实践。`os.system`和`os.popen`简单易用，但功能相对有限；`subprocess`模块则提供了更强大、灵活和安全的方式来处理子进程和运行Shell命令。在实际应用中，应根据具体需求选择合适的方法，并注意安全性和性能方面的问题。

## 参考资料
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}