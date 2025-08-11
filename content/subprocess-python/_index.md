---
title: "深入探索 Python 的 subprocess 模块"
description: "在 Python 编程中，我们常常需要与外部进程进行交互，例如运行系统命令、调用其他程序等。`subprocess` 模块就是 Python 标准库中专门用于处理这类任务的强大工具。它提供了一种更高级、更灵活且更强大的方式来创建和管理子进程，相较于旧的 `os.system`、`os.popen` 等函数，`subprocess` 模块在功能和安全性上都有显著提升。本文将全面介绍 `subprocess` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一重要工具。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
在 Python 编程中，我们常常需要与外部进程进行交互，例如运行系统命令、调用其他程序等。`subprocess` 模块就是 Python 标准库中专门用于处理这类任务的强大工具。它提供了一种更高级、更灵活且更强大的方式来创建和管理子进程，相较于旧的 `os.system`、`os.popen` 等函数，`subprocess` 模块在功能和安全性上都有显著提升。本文将全面介绍 `subprocess` 模块的基础概念、使用方法、常见实践以及最佳实践，帮助你熟练掌握这一重要工具。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - 简单调用外部命令
    - 获取命令输出
    - 传递输入给子进程
    - 处理返回值
3. **常见实践**
    - 运行 shell 脚本
    - 调用 Python 脚本
4. **最佳实践**
    - 错误处理
    - 资源管理
    - 安全性考量
5. **小结**
6. **参考资料**

## 基础概念
`subprocess` 模块允许你在 Python 程序中创建新的进程，并与之进行通信。子进程是由父进程（即你的 Python 程序）创建的独立运行的进程。通过 `subprocess` 模块，你可以控制子进程的输入、输出和错误流，获取子进程的返回值，并且可以管理子进程的生命周期，例如等待子进程完成、终止子进程等。

## 使用方法

### 简单调用外部命令
使用 `subprocess.run` 函数可以轻松调用外部命令。以下是一个简单的示例，调用 `ls` 命令列出当前目录下的文件和文件夹：

```python
import subprocess

result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(result.stdout)
```

在这个例子中：
- `subprocess.run` 函数的第一个参数是一个包含命令及其参数的列表。
- `capture_output=True` 表示捕获子进程的标准输出和标准错误。
- `text=True` 表示以文本形式返回输出，而不是字节形式。

### 获取命令输出
如果想要获取子进程的输出，可以使用 `subprocess.run` 的返回值。`result.stdout` 包含标准输出，`result.stderr` 包含标准错误。例如：

```python
import subprocess

result = subprocess.run(['echo', 'Hello, World!'], capture_output=True, text=True)
print(result.stdout)  # 输出: Hello, World!
```

### 传递输入给子进程
有时候我们需要向子进程传递输入。可以通过 `input` 参数来实现。例如，下面的例子将输入传递给 `grep` 命令：

```python
import subprocess

input_text = "This is a sample text\nAnother line"
result = subprocess.run(['grep', 'is'], input=input_text, capture_output=True, text=True)
print(result.stdout)  # 输出: This is a sample text
```

### 处理返回值
子进程执行结束后会返回一个返回值。可以通过 `result.returncode` 获取。返回值为 0 通常表示成功，非 0 表示有错误发生。例如：

```python
import subprocess

result = subprocess.run(['false'], capture_output=True, text=True)
print(result.returncode)  # 输出: 1，表示命令执行失败
```

## 常见实践

### 运行 shell 脚本
假设我们有一个名为 `script.sh` 的 shell 脚本，内容如下：

```bash
#!/bin/bash
echo "This is a shell script"
```

可以使用 `subprocess` 模块运行这个脚本：

```python
import subprocess

result = subprocess.run(['bash','script.sh'], capture_output=True, text=True)
print(result.stdout)  # 输出: This is a shell script
```

### 调用 Python 脚本
如果要调用另一个 Python 脚本，同样可以使用 `subprocess`。假设我们有一个 `another_script.py`，内容如下：

```python
print("This is another Python script")
```

调用它的代码如下：

```python
import subprocess

result = subprocess.run(['python', 'another_script.py'], capture_output=True, text=True)
print(result.stdout)  # 输出: This is another Python script
```

## 最佳实践

### 错误处理
在使用 `subprocess` 时，一定要进行错误处理。可以通过检查 `returncode` 来判断子进程是否成功执行，并根据需要处理错误。例如：

```python
import subprocess

result = subprocess.run(['non_existent_command'], capture_output=True, text=True)
if result.returncode != 0:
    print(f"Error occurred: {result.stderr}")
```

### 资源管理
当创建多个子进程时，要注意资源管理。确保及时释放不再使用的资源，例如通过等待子进程完成并正确处理它们的输出和错误。可以使用 `result.wait()` 方法等待子进程完成：

```python
import subprocess

process = subprocess.Popen(['long_running_command'])
# 做一些其他事情
process.wait()  # 等待子进程完成
```

### 安全性考量
在使用 `subprocess` 时，要注意安全性。避免直接使用用户输入来构建命令，以防止命令注入攻击。如果必须使用用户输入，要进行严格的验证和转义。例如：

```python
import subprocess
import shlex

user_input = "safe_argument"
command = f"command {user_input}"
args = shlex.split(command)
subprocess.run(args, capture_output=True, text=True)
```

## 小结
`subprocess` 模块是 Python 中与外部进程交互的强大工具。通过掌握其基础概念、使用方法、常见实践和最佳实践，你可以在 Python 程序中高效、安全地创建和管理子进程，与各种外部程序进行交互。无论是运行系统命令、调用脚本还是执行其他外部任务，`subprocess` 都能提供灵活且可靠的解决方案。

## 参考资料
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html)
- 《Python 核心编程》
- [Real Python - Working with Subprocess in Python](https://realpython.com/python-subprocess/)