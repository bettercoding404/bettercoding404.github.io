---
title: "深入理解 Python subprocess.run"
description: "在Python编程中，经常需要与外部进程进行交互，例如运行系统命令、调用其他程序等。`subprocess.run` 函数为我们提供了一种简单而强大的方式来实现这一目的。本文将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地利用这一工具。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python编程中，经常需要与外部进程进行交互，例如运行系统命令、调用其他程序等。`subprocess.run` 函数为我们提供了一种简单而强大的方式来实现这一目的。本文将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地利用这一工具。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 基本调用
    - 捕获输出
    - 处理返回码
    - 传递参数
    - 处理标准错误
3. 常见实践
    - 运行系统命令
    - 调用外部程序
4. 最佳实践
    - 错误处理
    - 安全考量
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
`subprocess.run` 是Python标准库 `subprocess` 模块中的一个函数，它用于在Python脚本中运行外部进程，并等待该进程完成。这个函数会阻塞当前线程，直到被调用的外部进程执行完毕，然后返回一个 `CompletedProcess` 对象，该对象包含了关于外部进程执行结果的信息，如返回码、标准输出和标准错误输出等。

## 使用方法

### 基本调用
最简单的用法是直接调用外部命令。例如，要在Python脚本中运行 `ls` 命令（在Unix-like系统上列出目录内容）：

```python
import subprocess

result = subprocess.run(['ls'])
```

在这个例子中，`subprocess.run` 接受一个字符串列表作为参数，列表的第一个元素是要执行的命令，后续元素是该命令的参数。这里 `['ls']` 表示运行 `ls` 命令且不传递额外参数。

### 捕获输出
要捕获外部命令的标准输出，可以使用 `capture_output=True` 参数。例如：

```python
import subprocess

result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
if result.returncode == 0:
    print(result.stdout)
else:
    print(result.stderr)
```

在这个例子中，`capture_output=True` 表示捕获标准输出和标准错误输出，`text=True` 表示以文本形式返回输出，而不是字节形式。`result.stdout` 包含标准输出内容，`result.stderr` 包含标准错误输出内容。

### 处理返回码
`subprocess.run` 返回的 `CompletedProcess` 对象的 `returncode` 属性表示外部进程的返回码。通常，返回码为 0 表示成功，非零表示有错误发生。例如：

```python
import subprocess

result = subprocess.run(['false'])
if result.returncode == 0:
    print("命令成功执行")
else:
    print(f"命令执行失败，返回码: {result.returncode}")
```

### 传递参数
可以在命令列表中添加参数。例如，运行 `grep` 命令来查找文件中包含特定字符串的行：

```python
import subprocess

pattern = "hello"
filename = "example.txt"
result = subprocess.run(['grep', pattern, filename], capture_output=True, text=True)
if result.returncode == 0:
    print(result.stdout)
else:
    print(result.stderr)
```

### 处理标准错误
可以通过 `stderr` 参数指定如何处理标准错误输出。例如，将标准错误输出重定向到标准输出：

```python
import subprocess

result = subprocess.run(['ls', '-invalid_option'], stderr=subprocess.STDOUT, capture_output=True, text=True)
print(result.stdout)
```

在这个例子中，`stderr=subprocess.STDOUT` 表示将标准错误输出重定向到标准输出，这样所有输出都可以通过 `result.stdout` 获取。

## 常见实践

### 运行系统命令
在自动化脚本中，经常需要运行系统命令来执行各种任务，如文件操作、系统配置等。例如，创建一个新目录：

```python
import subprocess

new_dir = "new_directory"
result = subprocess.run(['mkdir', new_dir])
if result.returncode == 0:
    print(f"{new_dir} 目录创建成功")
else:
    print(f"创建目录失败，返回码: {result.returncode}")
```

### 调用外部程序
除了系统命令，还可以调用各种外部程序。例如，使用Python调用 `ffmpeg` 进行视频处理：

```python
import subprocess

input_file = "input.mp4"
output_file = "output.mp4"
command = ['ffmpeg', '-i', input_file, output_file]
result = subprocess.run(command)
if result.returncode == 0:
    print(f"{output_file} 视频处理成功")
else:
    print(f"视频处理失败，返回码: {result.returncode}")
```

## 最佳实践

### 错误处理
在实际应用中，要对外部进程的返回码进行全面的错误处理。不要仅仅检查返回码是否为 0，还应该根据具体的业务逻辑处理不同的错误情况。例如：

```python
import subprocess

result = subprocess.run(['rm', '-rf', 'nonexistent_directory'])
if result.returncode == 0:
    print("目录删除成功（如果存在）")
elif result.returncode == 1:
    print("删除目录时发生错误，可能目录不存在或权限不足")
else:
    print(f"未知错误，返回码: {result.returncode}")
```

### 安全考量
当运行外部命令并传递用户输入作为参数时，要特别注意安全问题，防止命令注入攻击。例如，不要直接拼接用户输入到命令字符串中，而是使用参数列表的方式传递。

**不安全的做法**：

```python
import subprocess

user_input = "; rm -rf /"  # 恶意输入
command = "ls " + user_input
subprocess.run(command, shell=True)
```

**安全的做法**：

```python
import subprocess

user_input = "; rm -rf /"  # 恶意输入
subprocess.run(['ls', user_input])
```

### 性能优化
如果需要多次运行同一个外部进程，可以考虑使用 `subprocess.Popen` 来创建持久的进程对象，而不是每次都使用 `subprocess.run` 重新启动进程。`Popen` 提供了更多的控制和灵活性，但使用起来相对复杂一些。

```python
import subprocess

# 创建持久的进程对象
process = subprocess.Popen(['ping', 'google.com'], stdout=subprocess.PIPE)

# 读取输出
while True:
    output = process.stdout.readline()
    if output == b'' and process.poll() is not None:
        break
    if output:
        print(output.strip())

# 等待进程结束
return_code = process.wait()
print(f"返回码: {return_code}")
```

## 小结
`subprocess.run` 是Python中与外部进程交互的重要工具，通过合理使用它，可以在Python脚本中方便地运行系统命令和调用外部程序。在实际应用中，要注意错误处理、安全考量和性能优化等方面，以确保程序的稳定性和可靠性。

## 参考资料
- 《Python Cookbook》