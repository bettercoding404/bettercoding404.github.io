---
title: "深入理解 Python subprocess.run：强大的子进程管理工具"
description: "在 Python 编程中，我们常常需要在程序内部执行外部命令或脚本。`subprocess.run` 函数为我们提供了一种简单而强大的方式来实现这一需求。它允许我们启动一个新的子进程，等待其完成，并获取执行结果。这篇博客将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一工具。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在 Python 编程中，我们常常需要在程序内部执行外部命令或脚本。`subprocess.run` 函数为我们提供了一种简单而强大的方式来实现这一需求。它允许我们启动一个新的子进程，等待其完成，并获取执行结果。这篇博客将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助你更好地掌握这一工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本语法
    - 传递参数
    - 获取输出
    - 处理错误
3. 常见实践
    - 执行系统命令
    - 运行外部脚本
4. 最佳实践
    - 安全考量
    - 异步执行
5. 小结
6. 参考资料

## 基础概念
`subprocess.run` 是 Python `subprocess` 模块中的一个函数，用于运行新的进程。它会阻塞当前进程，直到子进程完成执行。`subprocess.run` 的设计目的是提供一个更高级、更易用的接口来管理子进程，替代了早期版本中一些较为复杂和不安全的函数，如 `os.system`。

## 使用方法

### 基本语法
`subprocess.run` 的基本语法如下：
```python
import subprocess

result = subprocess.run(args, *, stdin=None, input=None, stdout=None, stderr=None, shell=False)
```
- `args`：这是一个字符串或字符串序列，指定要执行的命令及其参数。如果 `args` 是字符串，并且 `shell=True`，则该字符串将被作为一个完整的 shell 命令执行。如果 `args` 是序列，第一个元素通常是要执行的命令，后续元素是该命令的参数。
- `stdin`、`stdout` 和 `stderr`：这些参数用于指定标准输入、标准输出和标准错误的处理方式。默认值为 `None`，表示使用父进程的标准输入、输出和错误。可以将其设置为 `subprocess.PIPE` 来捕获输出，设置为 `subprocess.DEVNULL` 来忽略输出。
- `input`：如果指定了 `input` 参数，它将被作为标准输入传递给子进程。这意味着 `stdin` 参数应该为 `None`。
- `shell`：默认值为 `False`。当 `shell=True` 时，Python 将通过 shell 来执行命令。这在执行一些复杂的 shell 命令时很有用，但也存在安全风险，稍后会详细讨论。

### 传递参数
传递参数非常简单，只需要将参数作为 `args` 序列的一部分。例如，要执行 `ls -l` 命令：
```python
import subprocess

result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```
在这个例子中，`['ls', '-l']` 是 `args` 参数，`capture_output=True` 表示捕获标准输出和标准错误，`text=True` 表示以文本形式返回输出，而不是字节流。

### 获取输出
要获取子进程的输出，可以使用 `capture_output=True` 参数。然后通过 `result.stdout` 和 `result.stderr` 属性访问输出。例如：
```python
import subprocess

result = subprocess.run(['echo', 'Hello, World!'], capture_output=True, text=True)
print(result.stdout)
```
这里，`result.stdout` 将包含 `'Hello, World!\n'`。

### 处理错误
`subprocess.run` 会在子进程返回非零退出码时抛出 `subprocess.CalledProcessError` 异常。可以通过捕获这个异常来处理错误：
```python
import subprocess

try:
    result = subprocess.run(['false'], check=True)
except subprocess.CalledProcessError as e:
    print(f"Command failed with return code {e.returncode}")
```
在这个例子中，`check=True` 表示如果子进程返回非零退出码，将抛出异常。

## 常见实践

### 执行系统命令
执行系统命令是 `subprocess.run` 的常见用途之一。例如，要获取当前目录下的文件列表：
```python
import subprocess

result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```

### 运行外部脚本
你还可以使用 `subprocess.run` 运行外部的 Python 脚本或其他脚本语言编写的脚本。例如，假设有一个名为 `script.py` 的 Python 脚本：
```python
# script.py
print("This is a sample script")
```
可以使用以下代码运行它：
```python
import subprocess

result = subprocess.run(['python','script.py'], capture_output=True, text=True)
print(result.stdout)
```

## 最佳实践

### 安全考量
当使用 `shell=True` 时，需要特别小心安全问题。因为 `shell=True` 会通过 shell 执行命令，这可能导致命令注入漏洞。例如：
```python
import subprocess

user_input = "; rm -rf /"  # 恶意输入
subprocess.run(f"echo {user_input}", shell=True)
```
在这个例子中，如果用户输入包含恶意命令，可能会导致严重的系统损坏。因此，除非绝对必要，应避免使用 `shell=True`。如果必须使用，要确保对输入进行严格的验证和过滤。

### 异步执行
如果你希望在不阻塞当前进程的情况下执行子进程，可以使用 `subprocess.Popen` 类，并结合 `asyncio` 库实现异步执行。例如：
```python
import asyncio
import subprocess

async def run_command():
    process = await asyncio.create_subprocess_exec('ls', '-l', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = await process.communicate()
    print(stdout.decode())

asyncio.run(run_command())
```
在这个例子中，`asyncio.create_subprocess_exec` 启动一个子进程并返回一个 `asyncio.subprocess.Process` 对象，允许我们异步等待子进程完成并获取输出。

## 小结
`subprocess.run` 是 Python 中一个强大且灵活的工具，用于管理子进程。通过掌握其基本概念、使用方法、常见实践和最佳实践，你可以在 Python 程序中安全、高效地执行外部命令和脚本。记住要注意安全问题，特别是在使用 `shell=True` 时，并且可以根据需要使用异步执行来提高程序的性能。

## 参考资料
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html)
- [Effective Python - 条款 45：使用 subprocess 模块管理子进程](https://item.jd.com/11978806.html)

希望这篇博客对你理解和使用 `python subprocess.run` 有所帮助！如果你有任何问题或建议，欢迎在评论区留言。