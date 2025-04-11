---
title: "深入理解 Python subprocess.run"
description: "在 Python 编程中，我们经常需要与外部系统进行交互，例如执行 shell 命令、调用其他程序等。`subprocess.run` 函数就是 Python 标准库 `subprocess` 模块提供的一个强大工具，它允许我们在 Python 脚本中运行外部命令并获取其执行结果。本文将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地在项目中运用这一功能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 编程中，我们经常需要与外部系统进行交互，例如执行 shell 命令、调用其他程序等。`subprocess.run` 函数就是 Python 标准库 `subprocess` 模块提供的一个强大工具，它允许我们在 Python 脚本中运行外部命令并获取其执行结果。本文将深入探讨 `subprocess.run` 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地在项目中运用这一功能。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **基本调用**
    - **捕获输出**
    - **传递参数**
    - **处理错误**
3. **常见实践**
    - **执行 shell 脚本**
    - **调用外部程序**
4. **最佳实践**
    - **安全性考量**
    - **性能优化**
5. **小结**
6. **参考资料**

## 基础概念
`subprocess.run` 是 Python 3.5 及以上版本中 `subprocess` 模块新增的一个高级接口，用于运行外部命令并等待其完成。它简化了创建子进程、等待子进程完成、获取子进程返回值等一系列操作，提供了一个统一的、更易用的方式来与外部进程进行交互。

## 使用方法

### 基本调用
最简单的用法是直接调用外部命令，不捕获输出，也不处理返回值。例如，我们想要在 Python 脚本中执行 `ls` 命令（在 Linux 或 macOS 系统下）：
```python
import subprocess

subprocess.run(["ls"])
```
在 Windows 系统下，可以使用 `dir` 命令：
```python
import subprocess

subprocess.run(["dir"])
```
这里，`subprocess.run` 的第一个参数是一个字符串列表，列表的第一个元素是要执行的命令，后面的元素是该命令的参数。

### 捕获输出
如果我们想要捕获命令的输出，可以使用 `capture_output=True` 参数。例如，执行 `ls -l` 命令并捕获其输出：
```python
import subprocess

result = subprocess.run(["ls", "-l"], capture_output=True, text=True)
print(result.stdout)
```
在上述代码中，`text=True` 参数表示以文本形式返回输出，而不是字节形式。如果不指定 `text=True`，`stdout` 和 `stderr` 的输出将是字节类型，需要进行解码操作。

### 传递参数
可以通过在命令列表中添加元素来传递参数。例如，我们使用 `grep` 命令在文件中查找特定字符串：
```python
import subprocess

search_string = "hello"
file_path = "example.txt"
result = subprocess.run(["grep", search_string, file_path], capture_output=True, text=True)
print(result.stdout)
```

### 处理错误
`subprocess.run` 会在外部命令执行完成后返回一个 `CompletedProcess` 对象，该对象的 `returncode` 属性表示命令的返回值。如果 `returncode` 为 0，表示命令成功执行；非零值表示有错误发生。我们可以通过检查 `returncode` 来处理错误：
```python
import subprocess

result = subprocess.run(["false"], capture_output=True, text=True)
if result.returncode != 0:
    print(f"Command failed with error: {result.stderr}")
```

## 常见实践

### 执行 shell 脚本
我们可以使用 `subprocess.run` 来执行自定义的 shell 脚本。假设我们有一个名为 `script.sh` 的 shell 脚本：
```bash
#!/bin/bash
echo "This is a shell script"
```
在 Python 中执行该脚本：
```python
import subprocess

subprocess.run(["./script.sh"], shell=True)
```
需要注意的是，使用 `shell=True` 存在一定的安全风险，因为它会执行用户输入的命令，可能导致命令注入攻击。因此，在使用 `shell=True` 时，一定要确保输入的命令是安全的。

### 调用外部程序
`subprocess.run` 也可以用于调用其他外部程序，例如 Python 解释器本身。假设我们有一个名为 `test.py` 的 Python 脚本：
```python
print("This is a test Python script")
```
在另一个 Python 脚本中调用 `test.py`：
```python
import subprocess

subprocess.run(["python", "test.py"], capture_output=True, text=True)
```

## 最佳实践

### 安全性考量
避免使用 `shell=True`，尤其是在处理用户输入的命令时。如果必须使用 `shell=True`，要对用户输入进行严格的验证和过滤，防止恶意命令注入。例如：
```python
import subprocess
user_input = "ls -l"  # 假设这是用户输入，这里只是示例，实际应进行验证
safe_command = f"echo {user_input} | sh"
subprocess.run(safe_command, shell=True, executable="/bin/bash")
```

### 性能优化
在需要频繁调用外部命令的场景下，可以考虑使用缓存机制来减少重复执行相同命令的开销。另外，合理设置 `subprocess.run` 的参数，例如根据实际需求选择是否捕获输出，以避免不必要的资源消耗。

## 小结
`subprocess.run` 为 Python 开发者提供了一个方便、强大的工具来与外部系统进行交互。通过掌握其基础概念、使用方法、常见实践和最佳实践，我们能够更加高效、安全地在 Python 脚本中执行外部命令，实现与其他程序或系统的集成。在实际应用中，要根据具体需求合理选择参数，并注意安全性和性能方面的问题。

## 参考资料
- [Python 官方文档 - subprocess](https://docs.python.org/3/library/subprocess.html){: rel="nofollow"}
- [Real Python - Working with External Programs in Python](https://realpython.com/python-subprocess/){: rel="nofollow"}