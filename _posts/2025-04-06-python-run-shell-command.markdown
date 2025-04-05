---
title: "Python 运行 Shell 命令：从基础到最佳实践"
description: "在 Python 编程中，经常需要与操作系统进行交互，其中运行 Shell 命令是一项非常实用的功能。通过在 Python 脚本中运行 Shell 命令，可以实现诸如文件操作、系统配置、执行外部工具等多种任务。本文将深入探讨如何在 Python 中运行 Shell 命令，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 编程中，经常需要与操作系统进行交互，其中运行 Shell 命令是一项非常实用的功能。通过在 Python 脚本中运行 Shell 命令，可以实现诸如文件操作、系统配置、执行外部工具等多种任务。本文将深入探讨如何在 Python 中运行 Shell 命令，包括基础概念、不同的使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用 `os.system`
    - 使用 `os.popen`
    - 使用 `subprocess` 模块
3. 常见实践
    - 文件操作
    - 系统配置
    - 执行外部工具
4. 最佳实践
    - 安全性考量
    - 错误处理
    - 性能优化
5. 小结
6. 参考资料

## 基础概念
Shell 命令是操作系统提供的用于与系统进行交互的文本指令。在类 Unix 系统（如 Linux 和 macOS）以及 Windows 系统中都有各自的 Shell 环境（如 bash 在 Linux 和 macOS 中，CMD 和 PowerShell 在 Windows 中）。在 Python 中运行 Shell 命令，本质上是通过 Python 提供的接口调用系统的 Shell 来执行相应的指令，并获取执行结果。

## 使用方法

### 使用 `os.system`
`os.system` 是 Python 标准库 `os` 模块中用于运行 Shell 命令的函数。它会阻塞当前 Python 进程，直到 Shell 命令执行完成。
```python
import os

# 运行简单的 Shell 命令，例如列出当前目录下的文件
return_code = os.system('ls -l')
print(f"命令执行返回码: {return_code}")
```
在上述代码中，`os.system` 执行了 `ls -l` 命令，并返回命令执行的返回码。返回码为 0 表示命令成功执行，非 0 表示有错误发生。

### 使用 `os.popen`
`os.popen` 也是 `os` 模块中的函数，它可以打开一个管道来读取 Shell 命令的输出。
```python
import os

# 运行 Shell 命令并读取输出
output = os.popen('ls -l').read()
print(output)
```
这里 `os.popen` 执行 `ls -l` 命令，并将命令的输出通过 `read()` 方法读取出来并打印。

### 使用 `subprocess` 模块
`subprocess` 模块是 Python 3 推荐使用的运行 Shell 命令的方式，它提供了更强大和灵活的功能。
```python
import subprocess

# 运行 Shell 命令并获取输出和返回码
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
print(f"命令输出: {result.stdout}")
print(f"命令返回码: {result.returncode}")
```
在上述代码中，`subprocess.run` 函数执行了 `ls -l` 命令。`capture_output=True` 表示捕获命令的标准输出和标准错误，`text=True` 表示以文本形式返回输出结果。`result.stdout` 包含标准输出内容，`result.returncode` 包含命令的返回码。

## 常见实践

### 文件操作
可以使用 Shell 命令结合 Python 进行文件操作，例如复制文件。
```python
import subprocess

source_file = 'example.txt'
destination_folder = 'backup/'

# 使用 cp 命令复制文件
subprocess.run(['cp', source_file, destination_folder], check=True)
```
上述代码使用 `subprocess.run` 执行 `cp` 命令，将 `example.txt` 文件复制到 `backup/` 文件夹中。`check=True` 表示如果命令执行失败（返回码非 0），会抛出异常。

### 系统配置
通过运行 Shell 命令可以进行系统配置，比如安装软件包（在 Linux 中）。
```python
import subprocess

# 在 Ubuntu 系统中安装软件包
package_name = 'python3-pip'
subprocess.run(['sudo', 'apt', 'install', package_name], check=True)
```
这段代码在 Ubuntu 系统中使用 `sudo apt install` 命令安装 `python3-pip` 软件包。

### 执行外部工具
可以使用 Python 运行外部工具，例如图像处理工具 `convert`（ImageMagick 工具集中的命令）。
```python
import subprocess

input_image = 'input.jpg'
output_image = 'output.png'

# 使用 convert 命令转换图像格式
subprocess.run(['convert', input_image, output_image], check=True)
```
上述代码使用 `convert` 命令将 `input.jpg` 图像转换为 `output.png` 格式。

## 最佳实践

### 安全性考量
- **避免使用用户输入直接构建 Shell 命令**：如果使用用户输入构建 Shell 命令，可能会导致命令注入攻击。例如：
```python
import subprocess

user_input = "; rm -rf /"  # 恶意输入
# 以下代码存在安全风险
subprocess.run(f'ls {user_input}', shell=True, check=True)
```
为了避免这种情况，应尽量使用参数化的方式传递用户输入，而不是直接嵌入到命令字符串中。

### 错误处理
在运行 Shell 命令时，要进行充分的错误处理。对于 `subprocess.run`，可以通过捕获异常来处理错误。
```python
import subprocess

try:
    subprocess.run(['non_existent_command'], check=True)
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，返回码: {e.returncode}，错误信息: {e.stderr}")
```
### 性能优化
- **避免频繁启动 Shell 进程**：每次调用 `subprocess.run` 等函数都会启动一个新的 Shell 进程，这会带来一定的性能开销。如果需要执行多个相关的 Shell 命令，可以考虑将它们合并为一个命令执行。
- **使用合适的方法**：根据具体需求选择合适的运行 Shell 命令的方法。如果只关心命令的返回码，`os.system` 可能就足够了；如果需要获取输出并进行更精细的控制，`subprocess` 模块会是更好的选择。

## 小结
在 Python 中运行 Shell 命令是一项强大的功能，通过不同的方法可以实现与操作系统的灵活交互。`os.system` 和 `os.popen` 是较简单的方式，而 `subprocess` 模块提供了更丰富和安全的功能。在实际应用中，要根据具体需求选择合适的方法，并注意安全性、错误处理和性能优化等方面的问题。

## 参考资料
- [Python 官方文档 - subprocess 模块](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Python 官方文档 - os 模块](https://docs.python.org/3/library/os.html){: rel="nofollow"}