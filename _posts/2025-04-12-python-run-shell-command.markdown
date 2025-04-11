---
title: "Python运行Shell命令：从入门到实践"
description: "在Python编程中，常常需要与操作系统进行交互，其中运行Shell命令是一项非常实用的功能。通过Python运行Shell命令，可以轻松地自动化执行系统任务、获取系统信息、调用外部工具等。本文将深入探讨Python运行Shell命令的相关知识，帮助读者掌握这一强大的功能。"
date: 2025-04-12
categories: ["python"]
last_modified_at: 2025-04-12
---


## 简介
在Python编程中，常常需要与操作系统进行交互，其中运行Shell命令是一项非常实用的功能。通过Python运行Shell命令，可以轻松地自动化执行系统任务、获取系统信息、调用外部工具等。本文将深入探讨Python运行Shell命令的相关知识，帮助读者掌握这一强大的功能。

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
    - 传递参数
4. **最佳实践**
    - 错误处理
    - 安全考量
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
Shell命令是操作系统提供的一种文本界面，用于与系统进行交互。在Python中运行Shell命令，就是利用Python的相关函数或模块，在Python程序内部调用系统的Shell解释器来执行相应的命令。这为Python程序扩展了更强大的系统操作能力。

## 使用方法

### `os.system`
`os.system`是Python标准库`os`模块中的一个函数，用于在系统中执行Shell命令。它的语法如下：
```python
import os
os.system('command')
```
示例：
```python
import os
os.system('ls -l')
```
在这个示例中，`os.system`执行了`ls -l`命令，用于列出当前目录下的文件和目录详细信息。`os.system`会返回命令执行的状态码，0表示成功，非0表示失败。但它有一个局限性，就是无法获取命令的输出结果。

### `os.popen`
`os.popen`同样来自`os`模块，它可以执行Shell命令并返回一个文件对象，通过这个文件对象可以读取命令的输出结果。语法如下：
```python
import os
result = os.popen('command').read()
```
示例：
```python
import os
result = os.popen('ls -l').read()
print(result)
```
这里通过`os.popen`执行`ls -l`命令，并将输出结果读取到`result`变量中，然后打印出来。不过，`os.popen`已经被标记为过时，在Python 3中推荐使用`subprocess`模块。

### `subprocess`模块
`subprocess`模块是Python 3中用于处理子进程的标准模块，提供了更强大、更灵活的方式来运行Shell命令。

- **执行命令并获取输出**
```python
import subprocess
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```
在这个示例中，`subprocess.run`执行了`ls -l`命令，`capture_output=True`表示捕获命令的标准输出和标准错误输出，`text=True`表示以文本形式返回输出结果。`result.stdout`存储了命令的标准输出内容。

- **执行命令并检查返回码**
```python
import subprocess
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
if result.returncode == 0:
    print("命令执行成功")
else:
    print("命令执行失败，错误信息：", result.stderr)
```
这里通过检查`result.returncode`来判断命令是否执行成功，如果返回码为0则表示成功，否则表示失败，并打印出错误信息。

## 常见实践

### 执行简单命令
```python
import subprocess
subprocess.run(['date'])
```
这个示例执行了`date`命令，用于显示当前日期和时间。

### 获取命令输出
```python
import subprocess
result = subprocess.run(['df', '-h'], capture_output=True, text=True)
print(result.stdout)
```
`df -h`命令用于查看磁盘使用情况，通过上述代码可以获取并打印出该命令的输出结果。

### 传递参数
```python
import subprocess
param = 'example.txt'
result = subprocess.run(['grep', 'keyword', param], capture_output=True, text=True)
print(result.stdout)
```
在这个示例中，将`example.txt`作为参数传递给`grep`命令，用于在该文件中查找包含`keyword`的行，并打印出结果。

## 最佳实践

### 错误处理
在运行Shell命令时，需要对可能出现的错误进行处理，以确保程序的稳定性。可以通过检查返回码或捕获异常来处理错误。
```python
import subprocess
try:
    result = subprocess.run(['nonexistent_command'], capture_output=True, text=True)
except FileNotFoundError:
    print("命令不存在")
else:
    if result.returncode != 0:
        print("命令执行失败，错误信息：", result.stderr)
```

### 安全考量
在运行用户输入的Shell命令时，要特别注意安全问题，防止命令注入攻击。尽量避免使用用户输入直接构建命令字符串，可以使用`subprocess.run`的参数形式传递参数。
```python
import subprocess
user_input = 'example.txt'
result = subprocess.run(['ls', user_input], capture_output=True, text=True)
```

### 性能优化
如果需要频繁运行Shell命令，可以考虑使用缓存机制来减少重复执行相同命令的开销。另外，合理选择执行命令的方式，避免不必要的资源消耗。

## 小结
通过本文的介绍，我们学习了Python运行Shell命令的基础概念、多种使用方法、常见实践以及最佳实践。`os.system`和`os.popen`虽然简单易用，但存在一定局限性，而`subprocess`模块则提供了更强大、更安全和灵活的方式来运行Shell命令。在实际应用中，需要根据具体需求选择合适的方法，并注意错误处理、安全考量和性能优化等方面的问题。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Python官方文档 - os模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}