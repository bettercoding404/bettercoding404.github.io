---
title: "Python运行Shell命令：从基础到最佳实践"
description: "在Python编程中，有时我们需要调用系统的Shell命令来完成一些特定任务，比如文件操作、系统管理、执行外部脚本等。掌握如何在Python中运行Shell命令，能够极大地扩展Python的应用场景，增强其与操作系统的交互能力。本文将深入探讨Python运行Shell命令的相关知识，从基础概念到具体使用方法，再到常见实践和最佳实践，帮助你全面掌握这一重要技能。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在Python编程中，有时我们需要调用系统的Shell命令来完成一些特定任务，比如文件操作、系统管理、执行外部脚本等。掌握如何在Python中运行Shell命令，能够极大地扩展Python的应用场景，增强其与操作系统的交互能力。本文将深入探讨Python运行Shell命令的相关知识，从基础概念到具体使用方法，再到常见实践和最佳实践，帮助你全面掌握这一重要技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess`模块
3. **常见实践**
    - 文件操作
    - 系统管理
    - 执行外部脚本
4. **最佳实践**
    - 错误处理
    - 安全考量
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
Shell命令是操作系统提供的一种文本界面交互方式，用于执行各种系统操作。在Python中运行Shell命令，就是通过Python代码调用系统的Shell环境来执行相应的命令。这涉及到Python与操作系统之间的进程通信，将Python代码的指令传递给Shell，然后获取Shell执行命令后的结果反馈。

## 使用方法

### `os.system`
`os.system`是Python标准库`os`模块中的一个函数，用于在操作系统中执行Shell命令。它的语法很简单：
```python
import os

# 执行ls命令列出当前目录下的文件和文件夹
return_code = os.system('ls')
print(f"命令返回码: {return_code}")
```
在这个例子中，`os.system`执行了`ls`命令，并返回一个整数表示命令的执行状态。返回值为0表示命令成功执行，非零值表示有错误发生。

### `os.popen`
`os.popen`也是`os`模块中的函数，它可以执行Shell命令并返回一个文件对象，通过这个文件对象可以读取命令的输出结果。
```python
import os

# 执行ls命令并读取输出
result = os.popen('ls').read()
print(result)
```
这里，`os.popen('ls').read()`读取了`ls`命令的输出内容并存储在`result`变量中，然后打印出来。

### `subprocess`模块
`subprocess`模块是Python 3推荐使用的执行Shell命令的方式，它提供了更强大、更灵活的功能，能够更好地处理命令的输入、输出和错误。

**执行命令并获取输出**
```python
import subprocess

# 执行ls命令并获取输出
result = subprocess.run(['ls'], capture_output=True, text=True)
print(result.stdout)
```
在这个例子中，`subprocess.run`函数执行了`ls`命令。`capture_output=True`表示捕获命令的标准输出和标准错误，`text=True`表示以文本形式返回输出结果。`result.stdout`存储了命令的标准输出内容。

**执行命令并传递输入**
```python
import subprocess

# 执行echo命令并传递输入
result = subprocess.run(['echo', 'Hello, World!'], capture_output=True, text=True)
print(result.stdout)
```
这里通过`subprocess.run`执行`echo`命令，并传递了`Hello, World!`作为输入内容。

## 常见实践

### 文件操作
在Python中，可以使用Shell命令进行文件的复制、移动、删除等操作。
```python
import subprocess

# 复制文件
source_file = 'example.txt'
destination_file = 'new_example.txt'
subprocess.run(['cp', source_file, destination_file])
```
这段代码使用`cp`命令复制了一个文件。

### 系统管理
执行系统管理相关的Shell命令，如查看系统信息、进程管理等。
```python
import subprocess

# 查看系统内存使用情况
subprocess.run(['free', '-h'])
```
这里使用`free -h`命令查看系统内存使用情况。

### 执行外部脚本
可以通过Python调用外部的Shell脚本或其他可执行脚本。
```python
import subprocess

# 执行一个外部的Shell脚本
script_path = 'your_script.sh'
subprocess.run(['bash', script_path])
```
这段代码使用`bash`命令执行了一个外部的Shell脚本。

## 最佳实践

### 错误处理
在执行Shell命令时，要进行充分的错误处理，以确保程序的稳定性。
```python
import subprocess

try:
    result = subprocess.run(['ls', '-invalid_option'], capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，错误信息: {e.stderr}")
```
在这个例子中，使用`check=True`参数，如果命令执行失败会抛出`subprocess.CalledProcessError`异常，通过捕获这个异常来处理错误。

### 安全考量
当使用用户输入来构建Shell命令时，要特别注意安全问题，防止命令注入攻击。
```python
import subprocess
user_input = input("请输入文件名: ")
safe_input = subprocess.list2cmdline([user_input])
subprocess.run(['ls', safe_input], capture_output=True, text=True)
```
这里通过`subprocess.list2cmdline`将用户输入转换为安全的命令格式。

### 性能优化
如果需要频繁执行Shell命令，可以考虑缓存结果或优化命令执行的频率。
```python
import subprocess
import time

cached_result = None
last_execution_time = 0

def get_system_info():
    global cached_result, last_execution_time
    current_time = time.time()
    if cached_result is None or current_time - last_execution_time > 60:  # 每60秒更新一次
        result = subprocess.run(['uname', '-a'], capture_output=True, text=True)
        cached_result = result.stdout
        last_execution_time = current_time
    return cached_result

print(get_system_info())
```
这段代码通过缓存系统信息的输出，减少了频繁执行`uname -a`命令的次数，提高了性能。

## 小结
在Python中运行Shell命令为我们提供了强大的系统交互能力。通过`os.system`、`os.popen`和`subprocess`模块等不同方法，我们可以灵活地执行各种Shell命令，并获取相应的输出结果。在实际应用中，要注意错误处理、安全考量和性能优化等最佳实践，以确保程序的稳定、安全和高效运行。

## 参考资料
- 《Python Cookbook》