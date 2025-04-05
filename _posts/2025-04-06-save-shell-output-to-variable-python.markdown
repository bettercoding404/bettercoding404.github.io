---
title: "在Python中保存 shell 输出到变量"
description: "在Python编程中，经常需要与操作系统的 shell 进行交互，获取 shell 命令执行的输出并将其保存到变量中，以便后续处理。这一操作在自动化脚本编写、系统管理以及数据采集等多个场景下都非常有用。本文将详细介绍如何在Python中实现将 shell 输出保存到变量，包括基础概念、使用方法、常见实践和最佳实践。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，经常需要与操作系统的 shell 进行交互，获取 shell 命令执行的输出并将其保存到变量中，以便后续处理。这一操作在自动化脚本编写、系统管理以及数据采集等多个场景下都非常有用。本文将详细介绍如何在Python中实现将 shell 输出保存到变量，包括基础概念、使用方法、常见实践和最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 执行简单命令并获取输出
    - 处理带参数的命令
    - 处理命令执行错误
4. 最佳实践
    - 选择合适的方法
    - 处理大输出
    - 安全考量
5. 小结
6. 参考资料

## 基础概念
在Python中，与 shell 进行交互意味着在Python脚本中执行 shell 命令。保存 shell 输出到变量就是获取这些命令执行后返回的结果，并将其存储在Python的变量中，这样就可以在脚本中对这些输出进行进一步的处理，例如分析、统计或者作为其他操作的输入。

## 使用方法

### 使用 `os.popen`
`os.popen` 是Python标准库 `os` 模块中的一个函数，它可以打开一个管道，执行 shell 命令并返回命令的输出。

```python
import os

# 执行命令并将输出保存到变量
output = os.popen('ls -l').read()
print(output)
```

在上述代码中，`os.popen('ls -l')` 打开一个管道执行 `ls -l` 命令，`.read()` 方法读取命令的输出并将其赋值给 `output` 变量。

### 使用 `subprocess` 模块
`subprocess` 模块是Python 2.4 及以上版本推荐使用的与外部进程交互的模块，它提供了更强大和灵活的功能。

```python
import subprocess

# 执行命令并将输出保存到变量
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
output = result.stdout
print(output)
```

在这段代码中，`subprocess.run` 执行 `ls -l` 命令，`capture_output=True` 表示捕获标准输出和标准错误，`text=True` 表示以文本模式返回输出。`result.stdout` 就是命令的标准输出，将其赋值给 `output` 变量。

## 常见实践

### 执行简单命令并获取输出
比如获取当前目录下的文件列表：

```python
import subprocess

result = subprocess.run(['ls'], capture_output=True, text=True)
file_list = result.stdout.splitlines()
for file in file_list:
    print(file)
```

### 处理带参数的命令
例如，使用 `grep` 命令在文件中查找特定字符串：

```python
import subprocess

search_term = "error"
file_path = "example.log"
result = subprocess.run(['grep', search_term, file_path], capture_output=True, text=True)
matches = result.stdout.splitlines()
for match in matches:
    print(match)
```

### 处理命令执行错误
在使用 `subprocess` 模块时，可以通过检查 `result.returncode` 来判断命令是否执行成功：

```python
import subprocess

result = subprocess.run(['non_existent_command'], capture_output=True, text=True)
if result.returncode != 0:
    print(f"Command failed with error: {result.stderr}")
else:
    output = result.stdout
    print(output)
```

## 最佳实践

### 选择合适的方法
对于简单的命令执行和输出获取，`os.popen` 可能足够，但对于更复杂的需求，如处理命令的返回码、标准错误输出等，`subprocess` 模块是更好的选择。

### 处理大输出
如果命令的输出非常大，一次性读取可能会导致内存问题。可以考虑逐行读取输出，例如：

```python
import subprocess

process = subprocess.Popen(['ls', '-l'], stdout=subprocess.PIPE, text=True)
while True:
    line = process.stdout.readline()
    if not line:
        break
    print(line.strip())
```

### 安全考量
当执行用户输入的命令时，要注意防止命令注入攻击。避免直接拼接用户输入到命令字符串中，尽量使用 `subprocess` 模块的参数形式。

## 小结
在Python中保存 shell 输出到变量是一项非常实用的技能。通过 `os.popen` 和 `subprocess` 模块，我们可以方便地执行 shell 命令并获取输出。在实际应用中，要根据具体需求选择合适的方法，并注意处理命令执行的错误和安全问题。

## 参考资料