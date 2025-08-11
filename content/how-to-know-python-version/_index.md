---
title: "如何查看Python版本"
description: "在Python开发过程中，了解当前使用的Python版本是非常重要的。不同的Python版本在语法、库的支持以及功能特性上可能存在差异。知道Python版本有助于确保代码在预期的环境中运行，并且在遇到问题时能够根据版本特性进行有效的排查和解决。本文将详细介绍查看Python版本的多种方法，涵盖基础概念、使用方法、常见实践以及最佳实践。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python开发过程中，了解当前使用的Python版本是非常重要的。不同的Python版本在语法、库的支持以及功能特性上可能存在差异。知道Python版本有助于确保代码在预期的环境中运行，并且在遇到问题时能够根据版本特性进行有效的排查和解决。本文将详细介绍查看Python版本的多种方法，涵盖基础概念、使用方法、常见实践以及最佳实践。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **在命令行中查看**
    - **在Python脚本中查看**
3. **常见实践**
    - **开发环境搭建时查看版本**
    - **部署项目前确认版本**
4. **最佳实践**
    - **自动化脚本检查版本**
    - **记录项目依赖的Python版本**
5. **小结**
6. **参考资料**

## 基础概念
Python有多个主要版本，如Python 2和Python 3。Python 2在2020年1月1日停止官方维护，Python 3是目前广泛使用的版本，并且在不断发展和更新。每个主要版本又有多个次要版本，例如Python 3.8、Python 3.9等。版本号通常遵循语义化版本控制规则，格式为`主版本号.次版本号.修订号`，例如`3.9.5`。主版本号的变化通常意味着不兼容的语法或重大功能更新，次版本号的更新可能包含新功能和一些兼容性改进，修订号则主要用于修复漏洞。

## 使用方法

### 在命令行中查看
- **Windows系统**
    - 打开命令提示符（CMD）。在开始菜单中搜索“命令提示符”并打开。
    - 输入以下命令查看Python版本：
```bash
python --version
```
    - 如果安装了多个Python版本，并且配置了正确的环境变量，上述命令会显示当前默认使用的Python版本。例如，输出可能是`Python 3.9.5`。
    - 如果你安装了Python Launcher for Windows，可以使用更灵活的方式指定查看特定版本。例如，要查看Python 3.8的版本：
```bash
py -3.8 --version
```
- **Linux系统**
    - 打开终端。
    - 输入命令查看Python版本：
```bash
python3 --version
```
    - 这将显示系统中Python 3的版本号。在一些Linux系统中，`python`命令可能指向Python 2，所以使用`python3`来确保查看的是Python 3版本。例如，输出可能是`Python 3.8.10`。
- **macOS系统**
    - 打开终端。
    - 同样使用以下命令查看Python版本：
```bash
python3 --version
```
    - 输出示例：`Python 3.9.6`

### 在Python脚本中查看
在Python脚本中，可以使用`sys`模块来获取Python版本信息。以下是一个简单的示例代码：
```python
import sys

print(sys.version)
```
运行上述代码，输出结果将包含Python的完整版本信息，例如：
```
3.9.5 (default, May  6 2021, 11:36:51) 
[Clang 12.0.0 (clang-1200.0.32.29)]
```
`sys.version`返回的是一个包含版本号、编译日期和编译器信息的字符串。如果只需要获取版本号，可以使用`sys.version_info`，它返回一个包含主版本号、次版本号、修订号等信息的元组。示例代码如下：
```python
import sys

version_info = sys.version_info
print(f"主版本号: {version_info.major}")
print(f"次版本号: {version_info.minor}")
print(f"修订号: {version_info.micro}")
```
输出结果类似：
```
主版本号: 3
次版本号: 9
修订号: 5
```

## 常见实践

### 开发环境搭建时查看版本
在搭建新的Python开发环境时，首先要确认安装的Python版本是否符合项目要求。例如，某些项目可能要求Python 3.8以上版本，通过上述命令行或脚本方式查看版本后，可以确保开发环境的正确性。如果版本不符合要求，需要重新安装或升级Python。

### 部署项目前确认版本
在将Python项目部署到生产环境之前，同样需要确认目标环境中的Python版本。这可以避免因版本差异导致的兼容性问题。例如，一些较新的语法特性在旧版本中可能无法运行。可以在部署脚本中添加查看版本的命令，将版本信息记录下来，以便在出现问题时进行追溯。

## 最佳实践

### 自动化脚本检查版本
为了确保在不同环境中项目的正常运行，可以编写自动化脚本检查Python版本。例如，在项目的启动脚本中添加版本检查功能：
```python
import sys

required_major = 3
required_minor = 8

if sys.version_info.major != required_major or sys.version_info.minor < required_minor:
    raise SystemExit(f"项目需要Python {required_major}.{required_minor} 或更高版本")

# 项目的其他代码逻辑
```
这样，当在不符合要求的Python版本环境中运行项目时，会立即抛出错误提示，提醒开发者解决版本问题。

### 记录项目依赖的Python版本
在项目的文档中明确记录项目所依赖的Python版本。可以在项目的README文件或者专门的环境说明文档中添加相关信息。例如：
```
### 项目依赖
- **Python版本**: 3.8 及以上
```
同时，在项目的`setup.py`或`requirements.txt`文件中也可以添加对Python版本的约束（如果适用），方便其他开发者快速了解项目的版本需求。

## 小结
查看Python版本是Python开发过程中的基本操作。通过命令行和脚本中的多种方法，我们可以轻松获取Python版本信息。在实际开发和部署中，养成查看版本的习惯，并遵循最佳实践，如自动化版本检查和记录版本依赖，有助于提高项目的稳定性和可维护性，减少因版本问题导致的错误和兼容性问题。

## 参考资料
- [Python官方文档](https://docs.python.org/3/)
- [Python Version Management Best Practices](https://www.techwithtim.net/tutorials/game-development-with-python/python-version-management/)