---
title: "Python运行Shell命令：从基础到最佳实践"
description: "在Python编程中，有时我们需要调用系统的Shell命令来完成一些任务，比如文件操作、系统管理或者运行外部程序等。Python提供了多种方式来运行Shell命令，每种方式都有其特点和适用场景。本文将详细介绍Python运行Shell命令的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
在Python编程中，有时我们需要调用系统的Shell命令来完成一些任务，比如文件操作、系统管理或者运行外部程序等。Python提供了多种方式来运行Shell命令，每种方式都有其特点和适用场景。本文将详细介绍Python运行Shell命令的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一重要技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 使用`os.system`
    - 使用`os.popen`
    - 使用`subprocess`模块
3. 常见实践
    - 执行简单命令
    - 获取命令输出
    - 传递参数
    - 处理命令错误
4. 最佳实践
    - 安全性考量
    - 性能优化
    - 可维护性
5. 小结
6. 参考资料

## 基础概念
在操作系统中，Shell是用户与操作系统内核之间的接口。Shell命令是用户通过Shell向操作系统发出的指令，用于执行各种任务，如文件操作、进程管理等。Python作为一种功能强大的编程语言，提供了多种机制来运行这些Shell命令，使得我们可以在Python脚本中方便地调用系统功能。

## 使用方法

### 使用`os.system`
`os.system`是Python标准库`os`模块中的一个函数，用于在操作系统中执行Shell命令。它的语法很简单：
```python
import os

# 执行ls命令
os.system('ls')
```
在这个例子中，`os.system`函数执行了`ls`命令，列出了当前目录下的文件和文件夹。`os.system`函数返回命令的退出状态码，0表示成功执行，非0表示执行过程中出现错误。

### 使用`os.popen`
`os.popen`函数也是`os`模块中的一个方法，它可以执行Shell命令并返回一个文件对象，通过这个文件对象可以读取命令的输出。示例如下：
```python
import os

# 执行ls命令并获取输出
result = os.popen('ls').read()
print(result)
```
在这个例子中，`os.popen('ls')`返回一个文件对象，调用`read()`方法读取命令的输出，并将其打印出来。

### 使用`subprocess`模块
`subprocess`模块是Python 2.4及以上版本推荐使用的运行Shell命令的方式，它提供了更强大、更灵活的功能。以下是一些常见的使用方式：

**执行命令并等待完成**
```python
import subprocess

# 执行ls命令
subprocess.run(['ls'])
```
`subprocess.run`函数接受一个命令列表作为参数，执行命令并等待其完成。如果需要获取命令的输出，可以使用`capture_output=True`参数：
```python
import subprocess

# 执行ls命令并获取输出
result = subprocess.run(['ls'], capture_output=True, text=True)
print(result.stdout)
```
在这个例子中，`text=True`参数指定输出以文本形式返回，`result.stdout`包含了命令的标准输出。

**执行命令并获取实时输出**
```python
import subprocess

# 执行一个长时间运行的命令，实时获取输出
process = subprocess.Popen(['ping', 'www.example.com'], stdout=subprocess.PIPE, text=True)
while True:
    output = process.stdout.readline()
    if output == '' and process.poll() is not None:
        break
    if output:
        print(output.strip())
```
在这个例子中，使用`subprocess.Popen`创建一个进程对象，通过循环读取标准输出并实时打印。

## 常见实践

### 执行简单命令
执行简单的Shell命令，如`ls`、`mkdir`等，可以直接使用上述方法。例如，创建一个新目录：
```python
import os

os.system('mkdir new_directory')
```
或者使用`subprocess`模块：
```python
import subprocess

subprocess.run(['mkdir', 'new_directory'])
```

### 获取命令输出
要获取命令的输出，可以使用`os.popen`或者`subprocess`模块的相关方法。例如，获取`df -h`命令的输出以查看磁盘使用情况：
```python
import subprocess

result = subprocess.run(['df', '-h'], capture_output=True, text=True)
print(result.stdout)
```

### 传递参数
有时候我们需要向Shell命令传递参数。例如，使用`grep`命令在文件中查找特定字符串：
```python
import subprocess

search_string = 'hello'
file_path = 'example.txt'
result = subprocess.run(['grep', search_string, file_path], capture_output=True, text=True)
print(result.stdout)
```

### 处理命令错误
在运行Shell命令时，可能会出现错误。`subprocess`模块提供了方便的错误处理机制。例如：
```python
import subprocess

try:
    result = subprocess.run(['nonexistent_command'], capture_output=True, text=True, check=True)
except subprocess.CalledProcessError as e:
    print(f"命令执行失败，错误码: {e.returncode}")
    print(f"标准错误输出: {e.stderr}")
```
在这个例子中，`check=True`参数会在命令返回非零退出状态码时抛出`subprocess.CalledProcessError`异常，我们可以捕获这个异常并处理错误。

## 最佳实践

### 安全性考量
在运行Shell命令时，要特别注意安全性。避免直接拼接用户输入到Shell命令中，以防注入攻击。例如，不要这样做：
```python
import os
user_input = "rm -rf /"  # 危险的用户输入
os.system(f'{user_input}')
```
如果用户输入恶意命令，可能会导致系统数据丢失。推荐使用`subprocess`模块，并将参数作为列表传递：
```python
import subprocess
user_input = "example.txt"
subprocess.run(['ls', user_input])
```

### 性能优化
对于频繁运行的Shell命令，考虑使用缓存机制来提高性能。例如，如果某个命令的输出不经常变化，可以将其结果缓存起来，避免重复执行命令。

### 可维护性
为了提高代码的可维护性，将运行Shell命令的逻辑封装成函数。例如：
```python
import subprocess

def run_shell_command(command):
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"命令执行失败，错误码: {e.returncode}")
        return ""

# 使用封装的函数
output = run_shell_command(['ls', '-l'])
print(output)
```

## 小结
本文介绍了Python运行Shell命令的多种方法，包括`os.system`、`os.popen`和`subprocess`模块。我们探讨了常见的实践场景，如执行命令、获取输出、传递参数和处理错误。同时，也强调了最佳实践，包括安全性、性能优化和可维护性方面的考虑。通过掌握这些知识，读者可以在Python编程中更加高效、安全地运行Shell命令，完成各种系统相关的任务。

## 参考资料
- 《Python Cookbook》