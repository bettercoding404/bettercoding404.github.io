---
title: "Python调用外部进程：从基础到最佳实践"
description: "在Python编程中，调用外部进程是一项非常有用的技能。它允许我们在Python脚本中执行系统命令、运行其他程序或脚本，从而扩展Python的功能。无论是与操作系统进行交互，还是集成不同的工具和服务，调用外部进程都提供了强大的途径。本文将深入探讨Python中调用外部进程的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技术。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，调用外部进程是一项非常有用的技能。它允许我们在Python脚本中执行系统命令、运行其他程序或脚本，从而扩展Python的功能。无论是与操作系统进行交互，还是集成不同的工具和服务，调用外部进程都提供了强大的途径。本文将深入探讨Python中调用外部进程的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技术。

<!-- more -->
## 目录
1. **基础概念**
    - 什么是外部进程
    - 为什么要在Python中调用外部进程
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess`模块
3. **常见实践**
    - 执行系统命令
    - 运行其他脚本
    - 获取命令输出
4. **最佳实践**
    - 错误处理
    - 安全考量
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
### 什么是外部进程
外部进程是指在当前Python程序之外独立运行的程序或脚本。这些进程可以是操作系统的命令（如`ls`、`mkdir`等），也可以是其他编程语言编写的可执行文件。

### 为什么要在Python中调用外部进程
- **系统交互**：Python可以通过调用外部进程与操作系统进行交互，执行系统管理任务，如文件操作、进程管理等。
- **功能扩展**：利用现有的外部工具和程序，扩展Python的功能。例如，调用图像处理工具进行图片处理，调用数据库备份工具进行数据备份等。
- **集成不同技术**：在项目中，可能需要集成多种技术和工具。通过调用外部进程，可以将不同语言编写的程序组合在一起，实现更复杂的功能。

## 使用方法
### `os.system`
`os.system`是Python中最基本的调用外部进程的方法。它接受一个字符串参数，该字符串是要执行的系统命令。

```python
import os

# 执行ls命令
os.system('ls')
```

**注意事项**：
- `os.system`返回命令执行的返回码。如果命令执行成功，返回码通常为0；如果失败，返回非零值。
- 它不会捕获命令的输出。如果需要获取命令输出，`os.popen`或`subprocess`模块更合适。

### `os.popen`
`os.popen`用于打开一个管道，通过这个管道可以获取命令的输出。

```python
import os

# 执行ls命令并获取输出
output = os.popen('ls').read()
print(output)
```

**注意事项**：
- `os.popen`返回一个文件对象，通过调用`read`方法可以读取命令的输出。
- 这种方法在Python 3中已被弃用，推荐使用`subprocess`模块。

### `subprocess`模块
`subprocess`模块是Python 3中推荐的调用外部进程的方法，它提供了更强大、更灵活的功能。

#### 执行命令并忽略输出
```python
import subprocess

# 执行ls命令
subprocess.run(['ls'])
```

#### 执行命令并获取输出
```python
import subprocess

# 执行ls命令并获取输出
result = subprocess.run(['ls'], capture_output=True, text=True)
print(result.stdout)
```

#### 执行命令并处理错误
```python
import subprocess

try:
    result = subprocess.run(['ls', '-invalid_option'], capture_output=True, text=True, check=True)
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，错误信息: {e.stderr}")
```

**参数说明**：
- `capture_output=True`：捕获命令的标准输出和标准错误。
- `text=True`：以文本形式返回输出，而不是字节形式。
- `check=True`：如果命令返回非零退出码，会引发`CalledProcessError`异常。

## 常见实践
### 执行系统命令
```python
import subprocess

# 执行mkdir命令创建目录
subprocess.run(['mkdir', 'new_directory'])
```

### 运行其他脚本
假设我们有一个名为`other_script.py`的Python脚本，内容如下：

```python
# other_script.py
print("这是来自other_script.py的输出")
```

在主脚本中运行它：

```python
import subprocess

# 运行other_script.py
subprocess.run(['python', 'other_script.py'])
```

### 获取命令输出
```python
import subprocess

# 执行df -h命令获取磁盘使用情况
result = subprocess.run(['df', '-h'], capture_output=True, text=True)
print(result.stdout)
```

## 最佳实践
### 错误处理
始终要对外部进程的执行进行错误处理。使用`subprocess`模块时，可以通过`check=True`参数并捕获`CalledProcessError`异常来处理命令执行失败的情况。

### 安全考量
在调用外部进程时，要注意安全问题。避免直接拼接用户输入到命令中，以防命令注入攻击。如果需要使用用户输入，可以使用`subprocess`模块的参数化方式。

### 性能优化
对于频繁调用外部进程的场景，可以考虑优化性能。例如，尽量减少不必要的进程启动和停止，或者使用多线程/多进程并行执行多个外部进程。

## 小结
在Python中调用外部进程是一项强大的功能，通过`os.system`、`os.popen`和`subprocess`模块，我们可以轻松地与操作系统和其他程序进行交互。在实际应用中，要根据具体需求选择合适的方法，并遵循最佳实践，以确保程序的健壮性、安全性和性能。

## 参考资料
- [Python官方文档 - subprocess模块](https://docs.python.org/3/library/subprocess.html)
- [Python调用外部程序的几种方法](https://www.runoob.com/w3cnote/python-call-external-program.html)