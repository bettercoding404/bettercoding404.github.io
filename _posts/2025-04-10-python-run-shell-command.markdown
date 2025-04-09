---
title: "Python 运行 Shell 命令：从基础到最佳实践"
description: "在 Python 编程中，能够运行 Shell 命令是一项非常实用的技能。它允许我们将 Python 的强大数据处理和逻辑控制能力与 Shell 脚本的系统操作功能相结合。无论是进行文件管理、系统监控，还是与其他基于命令行的工具交互，运行 Shell 命令都能极大地扩展 Python 程序的应用范围。本文将详细介绍如何在 Python 中运行 Shell 命令，包括基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在 Python 编程中，能够运行 Shell 命令是一项非常实用的技能。它允许我们将 Python 的强大数据处理和逻辑控制能力与 Shell 脚本的系统操作功能相结合。无论是进行文件管理、系统监控，还是与其他基于命令行的工具交互，运行 Shell 命令都能极大地扩展 Python 程序的应用范围。本文将详细介绍如何在 Python 中运行 Shell 命令，包括基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - `os.system`
    - `os.popen`
    - `subprocess` 模块
3. **常见实践**
    - 文件操作
    - 系统监控
    - 调用外部工具
4. **最佳实践**
    - 错误处理
    - 安全考量
    - 性能优化
5. **小结**
6. **参考资料**

## 基础概念
在 Linux 和 Unix 系统中，Shell 是用户与操作系统内核进行交互的接口。用户通过在 Shell 中输入命令来执行各种系统操作，如文件管理、进程控制等。在 Windows 系统中，与之类似的概念是命令提示符（CMD）或 PowerShell。

Python 作为一种高级编程语言，提供了多种方式来调用这些 Shell 命令。通过运行 Shell 命令，Python 程序可以直接与操作系统进行交互，实现更复杂的系统级任务。

## 使用方法

### `os.system`
`os.system` 是 Python 标准库 `os` 模块中的一个函数，用于在系统 shell 中执行命令。其基本语法如下：
```python
import os

return_code = os.system('command')
```
这里，`command` 是要执行的 Shell 命令，`return_code` 是命令执行后的返回码。返回码为 0 表示命令执行成功，非 0 表示有错误发生。

示例：
```python
import os

return_code = os.system('ls -l')
print(f"Command return code: {return_code}")
```
在这个示例中，`os.system` 执行了 `ls -l` 命令，用于列出当前目录下的文件和文件夹详细信息，并打印出命令的返回码。

### `os.popen`
`os.popen` 同样来自 `os` 模块，它用于打开一个管道，执行指定的 Shell 命令，并返回一个文件对象，通过这个文件对象可以读取命令的输出。语法如下：
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
此示例中，`os.popen` 执行 `ls -l` 命令，并将命令输出读取到 `output` 变量中，最后打印输出内容。

### `subprocess` 模块
`subprocess` 模块是 Python 3 中推荐使用的运行 Shell 命令的方式，它提供了更强大和灵活的功能。

#### 简单执行命令
```python
import subprocess

result = subprocess.run('command', shell=True)
```
`subprocess.run` 会阻塞当前 Python 进程，直到命令执行完成。`result` 是一个 `CompletedProcess` 对象，包含了命令执行的结果信息，如返回码等。

#### 获取命令输出
```python
import subprocess

result = subprocess.run('command', shell=True, capture_output=True, text=True)
output = result.stdout
error = result.stderr
```
这里，`capture_output=True` 表示捕获命令的标准输出和标准错误输出，`text=True` 表示以文本形式返回输出内容。`result.stdout` 包含标准输出，`result.stderr` 包含标准错误输出。

示例：
```python
import subprocess

result = subprocess.run('ls -l', shell=True, capture_output=True, text=True)
print("Standard output:")
print(result.stdout)
print("Standard error:")
print(result.stderr)
```

## 常见实践

### 文件操作
可以使用 Python 运行 Shell 命令来进行文件的复制、移动、删除等操作。
```python
import subprocess

# 复制文件
subprocess.run('cp source_file target_file', shell=True)
# 移动文件
subprocess.run('mv source_file target_directory', shell=True)
# 删除文件
subprocess.run('rm file_to_delete', shell=True)
```

### 系统监控
通过运行 Shell 命令获取系统信息，如 CPU 使用率、内存使用情况等。
```python
import subprocess

# 获取 CPU 使用率
result = subprocess.run('top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\\1/" | awk \'{print 100 - $1}\'', shell=True, capture_output=True, text=True)
cpu_usage = result.stdout.strip()
print(f"CPU usage: {cpu_usage}%")

# 获取内存使用情况
result = subprocess.run('free -h | grep Mem | awk \'{print $3 "/" $2}\'', shell=True, capture_output=True, text=True)
memory_usage = result.stdout.strip()
print(f"Memory usage: {memory_usage}")
```

### 调用外部工具
许多优秀的命令行工具可以通过 Python 运行 Shell 命令来调用，比如图像处理工具 `ImageMagick`。
```python
import subprocess

# 使用 ImageMagick 调整图片大小
subprocess.run('convert input_image.jpg -resize 50% output_image.jpg', shell=True)
```

## 最佳实践

### 错误处理
在运行 Shell 命令时，一定要进行错误处理。使用 `subprocess` 模块时，可以通过检查 `result.returncode` 来判断命令是否执行成功。
```python
import subprocess

result = subprocess.run('command_that_might_fail', shell=True, capture_output=True, text=True)
if result.returncode != 0:
    print(f"Command failed with error: {result.stderr}")
else:
    print(f"Command output: {result.stdout}")
```

### 安全考量
在使用 `shell=True` 时要格外小心，因为这可能会导致安全风险，特别是当命令参数来自用户输入时。为了安全起见，尽量避免使用 `shell=True`，如果必须使用，要对用户输入进行严格的验证和过滤。
```python
# 安全的方式，不使用 shell=True
import subprocess

command_args = ['ls', '-l']
result = subprocess.run(command_args, capture_output=True, text=True)
```

### 性能优化
如果需要频繁运行 Shell 命令，考虑使用 `subprocess.Popen` 来创建持久的进程对象，而不是每次都重新启动新的进程，以提高性能。
```python
import subprocess

# 创建持久的进程对象
process = subprocess.Popen(['command', 'arg1', 'arg2'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# 与进程交互
output, error = process.communicate()
```

## 小结
本文详细介绍了在 Python 中运行 Shell 命令的相关知识，包括基础概念、多种使用方法、常见实践以及最佳实践。`os.system` 和 `os.popen` 简单易用，但功能相对有限；`subprocess` 模块则提供了更强大、灵活且安全的方式来运行 Shell 命令。在实际应用中，要根据具体需求选择合适的方法，并注意错误处理、安全和性能等方面的问题。

## 参考资料
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}