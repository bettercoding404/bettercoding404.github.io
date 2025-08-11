---
title: "在Python中保存Shell输出到变量"
description: "在Python编程中，经常需要与系统的Shell进行交互并获取其执行命令后的输出结果。将这些输出保存到变量中，有助于进一步处理这些信息，比如进行数据提取、状态判断等操作。本文将详细介绍如何在Python中把Shell输出保存到变量里，涵盖基础概念、使用方法、常见实践及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python编程中，经常需要与系统的Shell进行交互并获取其执行命令后的输出结果。将这些输出保存到变量中，有助于进一步处理这些信息，比如进行数据提取、状态判断等操作。本文将详细介绍如何在Python中把Shell输出保存到变量里，涵盖基础概念、使用方法、常见实践及最佳实践。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.system`
    - 使用`os.popen`
    - 使用`subprocess`模块
3. 常见实践
    - 获取系统信息
    - 执行命令并检查返回状态
4. 最佳实践
    - 错误处理
    - 安全性考量
5. 小结
6. 参考资料

## 基础概念
在Python中与Shell进行交互，本质上是通过调用系统提供的接口来执行Shell命令。当命令执行完毕后，会产生输出，这个输出可能是文本信息（如命令执行结果的显示内容）、错误信息等。将这些输出捕获并存储到Python变量中，就可以在Python程序内部对其进行各种处理，而无需依赖于外部的Shell环境。

## 使用方法

### 使用`os.system`
`os.system`是Python标准库`os`模块中的一个函数，它可以在操作系统的Shell中执行命令。然而，`os.system`返回的是命令执行的状态码，而不是命令的输出。不过可以通过重定向标准输出到文件，然后读取文件内容来间接获取输出。

```python
import os

# 执行命令并将输出重定向到文件
os.system('ls -l > output.txt')

# 读取文件内容
with open('output.txt', 'r') as f:
    output = f.read()

print(output)
```

### 使用`os.popen`
`os.popen`函数会打开一个管道连接到Shell命令，返回一个类似文件对象的东西，可以读取命令的输出。

```python
import os

# 执行命令并获取输出
output = os.popen('ls -l').read()

print(output)
```

### 使用`subprocess`模块
`subprocess`模块是Python 3推荐使用的与外部进程进行交互的模块，功能强大且安全。

```python
import subprocess

# 使用check_output方法获取命令输出
result = subprocess.check_output(['ls', '-l'])

# 由于输出是字节类型，需要解码为字符串
output = result.decode('utf-8')

print(output)
```

## 常见实践

### 获取系统信息
通过执行`uname -a`命令可以获取系统的详细信息，并将其保存到变量中进行分析。

```python
import subprocess

# 获取系统信息
system_info = subprocess.check_output(['uname', '-a']).decode('utf-8')

print(system_info)
```

### 执行命令并检查返回状态
有时候不仅需要获取命令输出，还需要检查命令是否成功执行。`subprocess`模块可以方便地实现这一点。

```python
import subprocess

try:
    result = subprocess.run(['ls', '-l'], capture_output=True, text=True)
    if result.returncode == 0:
        output = result.stdout
        print(f"命令成功执行，输出: {output}")
    else:
        error = result.stderr
        print(f"命令执行失败，错误信息: {error}")
except Exception as e:
    print(f"发生异常: {e}")
```

## 最佳实践

### 错误处理
在执行Shell命令时，可能会遇到各种错误，如命令不存在、权限不足等。因此，完善的错误处理机制非常重要。使用`try - except`块来捕获异常，并根据不同的异常类型进行处理。

### 安全性考量
当在Python中执行Shell命令时，要注意安全性。避免使用用户输入直接构建Shell命令，以防注入攻击。如果必须使用用户输入，可以使用`subprocess`模块的参数化方式来确保安全。

```python
import subprocess

user_input = "example_dir"
# 安全的方式使用用户输入
result = subprocess.run(['ls', user_input], capture_output=True, text=True)
```

## 小结
在Python中保存Shell输出到变量有多种方法，`os.system`、`os.popen`和`subprocess`模块各有特点。`subprocess`模块由于其强大的功能和更好的安全性，成为推荐的使用方式。在实际应用中，要注意错误处理和安全性考量，确保程序的稳定和安全运行。

## 参考资料
- 《Python核心编程》