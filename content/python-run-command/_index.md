---
title: "Python运行命令：从基础到实践"
description: "在Python编程中，运行命令是一项非常重要的技能。无论是执行系统命令，还是调用其他程序或脚本，了解如何在Python中运行命令都能极大地扩展我们程序的功能边界。本文将深入探讨Python运行命令的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一关键技能。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，运行命令是一项非常重要的技能。无论是执行系统命令，还是调用其他程序或脚本，了解如何在Python中运行命令都能极大地扩展我们程序的功能边界。本文将深入探讨Python运行命令的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握这一关键技能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess`模块
3. **常见实践**
    - 执行系统命令
    - 运行外部脚本
4. **最佳实践**
    - 安全考量
    - 错误处理
5. **小结**
6. **参考资料**

## 基础概念
在Python中，运行命令通常指的是在Python程序内部执行系统命令或调用外部程序。这可以通过不同的模块和函数来实现。这些方法允许我们与操作系统进行交互，完成诸如文件操作、进程管理等任务。

## 使用方法

### `os.system`
`os.system`是Python标准库`os`模块中的一个函数，用于在操作系统的命令行中执行命令。

```python
import os

# 执行ls命令（在Linux或MacOS上）
os.system('ls')

# 执行dir命令（在Windows上）
os.system('dir')
```

### `os.popen`
`os.popen`函数也来自`os`模块，它可以打开一个管道连接到一个外部命令，并返回一个文件对象，通过这个对象可以读取命令的输出。

```python
import os

# 执行ls命令并读取输出
output = os.popen('ls').read()
print(output)
```

### `subprocess`模块
`subprocess`模块是Python 2.4及以上版本推荐使用的处理子进程的模块，它提供了更强大、更灵活的功能。

```python
import subprocess

# 执行ls命令并获取返回值
result = subprocess.run(['ls'], capture_output=True, text=True)
print(result.stdout)
```

在上述代码中，`subprocess.run`是`subprocess`模块中的一个函数，`['ls']`是要执行的命令和参数列表，`capture_output=True`表示捕获命令的标准输出和标准错误，`text=True`表示以文本形式返回输出。

## 常见实践

### 执行系统命令
执行系统命令是非常常见的需求。例如，我们想要在Python脚本中创建一个新的目录，可以使用以下代码：

```python
import subprocess

# 在Linux或MacOS上创建目录
subprocess.run(['mkdir', 'new_directory'])

# 在Windows上创建目录
subprocess.run(['mkdir', 'new_directory'])
```

### 运行外部脚本
我们还可以在Python中运行其他脚本。假设我们有一个名为`external_script.py`的脚本，内容如下：

```python
# external_script.py
print("This is an external script.")
```

在主Python脚本中运行它：

```python
import subprocess

subprocess.run(['python', 'external_script.py'])
```

## 最佳实践

### 安全考量
在运行命令时，要特别注意安全问题。避免直接拼接用户输入到命令中，以防命令注入攻击。例如，不要这样做：

```python
import os
user_input = "evil_command; rm -rf /"
os.system('ls'+ user_input)  # 非常危险，可能导致系统文件被删除
```

正确的做法是使用`subprocess`模块并将参数作为列表传递：

```python
import subprocess
user_input = "valid_argument"
subprocess.run(['ls', user_input])
```

### 错误处理
在运行命令时，要对可能出现的错误进行处理。`subprocess.run`函数可以返回一个`CompletedProcess`对象，通过检查它的`returncode`属性可以判断命令是否成功执行。

```python
import subprocess

result = subprocess.run(['nonexistent_command'], capture_output=True, text=True)
if result.returncode!= 0:
    print(f"Command failed with error: {result.stderr}")
```

## 小结
本文介绍了Python运行命令的基础概念、不同的使用方法（包括`os.system`、`os.popen`和`subprocess`模块）、常见实践以及最佳实践。通过合理运用这些知识，我们可以在Python程序中灵活地执行系统命令和调用外部程序，同时确保程序的安全性和稳定性。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html)
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html)