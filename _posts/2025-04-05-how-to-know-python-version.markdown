---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同的 Python 版本在语法、功能和库的支持上可能会有差异。知晓版本信息有助于确保代码在预期的环境中运行，避免因版本不兼容导致的问题。本文将详细介绍查看 Python 版本的多种方法，帮助你在各种场景下快速获取版本信息。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同的 Python 版本在语法、功能和库的支持上可能会有差异。知晓版本信息有助于确保代码在预期的环境中运行，避免因版本不兼容导致的问题。本文将详细介绍查看 Python 版本的多种方法，帮助你在各种场景下快速获取版本信息。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **在命令行中查看**
    - **在 Python 脚本中查看**
3. **常见实践**
    - **不同操作系统下的实践**
    - **在虚拟环境中的实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
Python 有多个主要版本，如 Python 2 和 Python 3，每个主要版本又有不同的次要版本和补丁版本。版本号的格式通常为 `主版本号.次版本号.补丁版本号`。例如，`3.8.10` 中，`3` 是主版本号，`8` 是次版本号，`10` 是补丁版本号。主版本的更新通常会带来较大的语法和功能变化，次版本更新会增加一些新特性，而补丁版本主要用于修复漏洞。

## 使用方法

### 在命令行中查看
- **Windows 系统**
    打开命令提示符（CMD），输入 `python --version` 命令，即可显示当前安装的 Python 版本号。例如：
    ```bash
    C:\Users\user>python --version
    Python 3.8.10
    ```
    如果你安装了多个 Python 版本，并配置了环境变量，通过指定 Python 解释器路径也能查看特定版本的信息。比如安装了 Python 2.7 和 Python 3.8，Python 2.7 的安装路径为 `C:\Python27`，则在命令提示符中输入 `C:\Python27\python.exe --version` 可以查看 Python 2.7 的版本。
- **Linux 系统**
    在终端中输入 `python --version` 或 `python3 --version`，这取决于你想要查看的是 Python 2 还是 Python 3 的版本。例如：
    ```bash
    user@linux:~$ python --version
    Python 2.7.18
    user@linux:~$ python3 --version
    Python 3.9.7
    ```
- **macOS 系统**
    打开终端，输入 `python --version` 或 `python3 --version` 命令来查看相应版本信息，操作与 Linux 系统类似。

### 在 Python 脚本中查看
在 Python 脚本中，可以使用 `sys` 模块来获取版本信息。示例代码如下：
```python
import sys

print(sys.version)
```
运行上述代码，输出结果类似：
```bash
3.8.10 (tags/v3.8.10:3d8993a, May  3 2021, 11:48:03) [MSC v.1928 64 bit (AMD64)]
```
除了 `sys.version` 输出完整的版本信息外，还可以使用 `sys.version_info` 获取更详细的版本组件信息，例如：
```python
import sys

version_info = sys.version_info
print(f"主版本号: {version_info.major}")
print(f"次版本号: {version_info.minor}")
print(f"补丁版本号: {version_info.micro}")
```
输出结果为：
```bash
主版本号: 3
次版本号: 8
补丁版本号: 10
```

## 常见实践

### 不同操作系统下的实践
- **Windows 系统**：在安装 Python 时，建议将 Python 安装路径添加到系统环境变量中，这样在命令提示符中可以直接使用 `python` 命令。如果安装了多个版本，要注意环境变量中 Python 路径的顺序，确保使用的是期望的版本。
- **Linux 系统**：大多数 Linux 发行版默认安装了 Python 2 和 Python 3。可以通过更新包管理器（如 `apt-get` 或 `yum`）来升级 Python 版本。在使用不同版本时，要注意脚本开头的 shebang 行，例如 `#!/usr/bin/python` 或 `#!/usr/bin/python3`，以确保脚本使用正确的 Python 解释器执行。
- **macOS 系统**：macOS 自带了 Python 2，但通常建议安装 Python 3 进行开发。可以使用 Homebrew 等包管理器来安装和管理 Python 版本。在终端中设置 `PATH` 变量，以便能够方便地切换不同版本的 Python。

### 在虚拟环境中的实践
虚拟环境允许你在同一系统上创建多个隔离的 Python 环境，每个环境可以有不同的 Python 版本和安装的库。创建虚拟环境后，可以在虚拟环境的命令行中使用上述方法查看当前环境中的 Python 版本。
例如，使用 `venv` 模块创建虚拟环境：
```bash
python3 -m venv myenv
source myenv/bin/activate  # 在 Linux 和 macOS 上
myenv\Scripts\activate  # 在 Windows 上
```
激活虚拟环境后，输入 `python --version` 可以查看该虚拟环境中使用的 Python 版本。

## 最佳实践
- **项目文档记录**：在项目文档中明确记录项目所使用的 Python 版本，方便团队成员和后续维护人员了解环境要求。
- **自动化检查**：在项目的构建脚本或持续集成（CI）流程中，添加检查 Python 版本的步骤，确保在不同环境中使用正确的版本运行项目。例如，可以使用 shell 脚本结合 `python --version` 命令来进行版本检查，并在版本不匹配时输出错误信息。
- **版本管理工具**：使用版本管理工具（如 `pyenv`）来管理多个 Python 版本，并能够方便地在不同项目中切换所需的版本。`pyenv` 可以在 Linux、macOS 和 Windows（通过 WSL）上使用。

## 小结
本文介绍了多种查看 Python 版本的方法，包括在命令行和 Python 脚本中查看。同时，阐述了在不同操作系统和虚拟环境中的常见实践以及最佳实践。了解 Python 版本信息是确保代码兼容性和项目顺利运行的重要基础，希望读者通过本文的学习，能够熟练掌握查看和管理 Python 版本的技巧。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [The Hitchhiker's Guide to Python](https://docs.python-guide.org/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}