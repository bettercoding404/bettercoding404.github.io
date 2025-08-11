---
title: "Python 运行 Shell 命令：从基础到最佳实践"
description: "在 Python 编程中，有时我们需要调用系统的 Shell 命令来执行一些系统级任务，比如文件操作、系统配置修改、运行外部程序等。Python 提供了多种方式来运行 Shell 命令，每种方式都有其特点和适用场景。本文将详细介绍 Python 运行 Shell 命令的相关知识，帮助你在不同的需求下选择最合适的方法。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，有时我们需要调用系统的 Shell 命令来执行一些系统级任务，比如文件操作、系统配置修改、运行外部程序等。Python 提供了多种方式来运行 Shell 命令，每种方式都有其特点和适用场景。本文将详细介绍 Python 运行 Shell 命令的相关知识，帮助你在不同的需求下选择最合适的方法。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess` 模块
3. **常见实践**
    - 执行简单命令
    - 获取命令输出
    - 传递参数
4. **最佳实践**
    - 安全性考量
    - 错误处理
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
Shell 是用户与操作系统内核之间的接口程序，它接收用户输入的命令并将其传递给内核执行。在 Python 中运行 Shell 命令，本质上是通过 Python 程序调用系统的 Shell 环境来执行相应的命令。这使得我们可以利用 Python 的灵活性和强大的编程能力，结合 Shell 命令的丰富功能，完成复杂的系统任务。

## 使用方法

### `os.system`
`os.system` 是 Python 标准库 `os` 模块中的一个函数，用于在操作系统中执行 Shell 命令。它的语法很简单：
```python
import os

# 执行简单的 ls 命令
os.system('ls')
```
在上述代码中，`os.system` 会启动一个新的 Shell 进程来执行 `ls` 命令，并将命令的输出打印到控制台。`os.system` 返回一个整数值，0 表示命令执行成功，其他值表示有错误发生。

### `os.popen`
`os.popen` 同样来自 `os` 模块，它用于打开一个管道来执行 Shell 命令，并返回一个文件对象，通过这个文件对象可以读取命令的输出。示例代码如下：
```python
import os

# 执行命令并读取输出
result = os.popen('ls').read()
print(result)
```
这里 `os.popen` 执行 `ls` 命令，并将输出作为字符串返回，通过 `read` 方法读取这个字符串并打印出来。

### `subprocess` 模块
`subprocess` 模块是 Python 3 推荐使用的运行 Shell 命令的方式，它提供了更强大和灵活的功能。下面是一些基本的使用示例：
```python
import subprocess

# 执行命令并等待完成
subprocess.run(['ls', '-l'])

# 执行命令并获取输出
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```
在第一个示例中，`subprocess.run` 执行 `ls -l` 命令并等待命令完成。第二个示例中，通过设置 `capture_output=True` 和 `text=True`，`subprocess.run` 会捕获命令的输出并以文本形式存储在 `result.stdout` 中。

## 常见实践

### 执行简单命令
在很多情况下，我们只需要执行一个简单的 Shell 命令，比如创建一个目录。使用 `subprocess` 模块可以这样做：
```python
import subprocess

# 创建一个名为 test_dir 的目录
subprocess.run(['mkdir', 'test_dir'])
```

### 获取命令输出
获取命令输出是很常见的需求，例如获取系统的网络配置信息。下面是使用 `subprocess` 模块的示例：
```python
import subprocess

# 获取网络配置信息
result = subprocess.run(['ifconfig'], capture_output=True, text=True)
print(result.stdout)
```

### 传递参数
有时候我们需要向 Shell 命令传递参数，比如压缩文件时指定文件名。示例代码如下：
```python
import subprocess

file_name = 'example.txt'
# 使用 gzip 压缩文件
subprocess.run(['gzip', file_name])
```

## 最佳实践

### 安全性考量
在运行 Shell 命令时，安全性是非常重要的。避免直接将用户输入拼接成 Shell 命令，因为这可能导致命令注入攻击。例如：
```python
import subprocess

user_input = '; rm -rf /'  # 恶意输入
# 错误做法，可能导致系统文件被删除
subprocess.run('ls'+ user_input, shell=True)
```
正确的做法是将参数作为列表传递给 `subprocess.run`：
```python
import subprocess

user_input = 'example.txt'
subprocess.run(['ls', user_input])
```

### 错误处理
在运行 Shell 命令时，要进行适当的错误处理。`subprocess` 模块的 `run` 方法返回的结果对象有一个 `returncode` 属性，可以用来检查命令是否执行成功：
```python
import subprocess

result = subprocess.run(['ls', 'non_existent_dir'])
if result.returncode!= 0:
    print(f'命令执行失败，错误码: {result.returncode}')
```

### 性能优化
如果需要频繁执行 Shell 命令，考虑性能优化是很有必要的。例如，可以减少不必要的进程启动开销。另外，对于一些复杂的命令，可以考虑将其封装成脚本文件，然后在 Python 中调用脚本，这样可以提高执行效率。

## 小结
本文介绍了 Python 运行 Shell 命令的基础概念、多种使用方法、常见实践以及最佳实践。`os.system` 和 `os.popen` 是比较简单的方式，但功能相对有限。`subprocess` 模块则提供了更强大、灵活且安全的功能，是推荐使用的方法。在实际应用中，要根据具体需求选择合适的方式，并注意安全性、错误处理和性能优化等方面的问题。

## 参考资料
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html)
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html)