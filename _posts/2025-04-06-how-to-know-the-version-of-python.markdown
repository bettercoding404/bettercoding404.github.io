---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同的 Python 版本在语法、库的支持以及性能等方面可能存在差异。知道自己使用的 Python 版本，有助于确保代码在预期的环境中运行，以及在遇到问题时能够更准确地查找解决方案。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本是非常重要的。不同的 Python 版本在语法、库的支持以及性能等方面可能存在差异。知道自己使用的 Python 版本，有助于确保代码在预期的环境中运行，以及在遇到问题时能够更准确地查找解决方案。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **命令行查看**
    - **在 Python 脚本中查看**
3. **常见实践**
    - **项目初始化时确认版本**
    - **排查兼容性问题时**
4. **最佳实践**
    - **记录项目 Python 版本**
    - **使用虚拟环境并明确版本**
5. **小结**
6. **参考资料**

## 基础概念
Python 有多个主要版本，如 Python 2 和 Python 3，每个主要版本下又有不同的次版本。版本号通常遵循语义化版本规则，格式为 `主版本号.次版本号.修订号`。例如，`3.8.5` 中，`3` 是主版本号，`8` 是次版本号，`5` 是修订号。主版本号的变化通常意味着较大的语法或功能改动，次版本号的更新可能会带来新功能或改进，修订号则主要用于修复 bug。

## 使用方法

### 命令行查看
在不同的操作系统中，都可以通过命令行来查看 Python 版本。
- **Windows 系统**：
    - 打开命令提示符（CMD）。在开始菜单中搜索“命令提示符”并打开。
    - 输入 `python --version` 命令，回车后会显示当前 Python 的版本号。例如：
```bash
C:\Users\user>python --version
Python 3.8.5
```
    - 如果你安装了多个 Python 版本，可能需要指定使用哪个 Python 解释器。例如，如果你安装了 Python 2 和 Python 3，想要查看 Python 2 的版本，可以输入 `python2 --version`（前提是 Python 2 安装路径已添加到系统环境变量中）。
- **Linux 系统**：
    - 打开终端。
    - 输入 `python3 --version` 来查看 Python 3 的版本。例如：
```bash
user@linux:~$ python3 --version
Python 3.9.4
```
    - 若要查看 Python 2 版本，输入 `python2 --version`（如果系统同时安装了 Python 2）。
- **macOS 系统**：
    - 打开终端。
    - 与 Linux 系统类似，输入 `python3 --version` 查看 Python 3 版本，输入 `python2 --version` 查看 Python 2 版本（若已安装）。

### 在 Python 脚本中查看
在 Python 脚本内部，也可以通过代码来获取当前 Python 版本信息。以下是几种常见的方法：
- **使用 `sys` 模块**：
```python
import sys

print(sys.version)
```
运行上述代码，输出结果会包含详细的 Python 版本信息，如 `3.8.5 (default, Jul 28 2020, 12:59:40) [MSC v.1916 64 bit (AMD64)]`，不仅包含版本号，还可能有编译器信息和构建日期等。
- **使用 `platform` 模块**：
```python
import platform

print(platform.python_version())
```
这个方法输出的结果比较简洁，只会显示版本号，例如 `3.8.5`。

## 常见实践

### 项目初始化时确认版本
在开始一个新的 Python 项目时，首先要确认当前开发环境中的 Python 版本是否符合项目要求。例如，某些项目可能要求最低 Python 版本为 3.6，如果使用的版本过低，可能无法运行项目或出现兼容性问题。通过在命令行输入 `python --version` 查看版本后，可以确保项目在合适的环境下进行开发。

### 排查兼容性问题时
当代码在运行过程中出现奇怪的错误或兼容性问题时，查看 Python 版本是排查问题的第一步。不同版本的 Python 对库的支持和语法的解析可能不同。例如，Python 2 和 Python 3 在字符串处理上有很大差异。通过确认当前 Python 版本，可以更有针对性地查找问题所在。如果发现是版本问题，可以考虑升级或降级 Python 版本，或者对代码进行相应的修改以兼容当前版本。

## 最佳实践

### 记录项目 Python 版本
在项目文档中明确记录项目所使用的 Python 版本是一个很好的实践。这样，其他开发人员在接手项目时，可以快速了解项目运行所需的 Python 环境。可以在项目的 README 文件中添加如下内容：
```
### Python 版本要求
本项目基于 Python 3.8 开发，请确保你的开发环境中 Python 版本为 3.8 或以上。
```

### 使用虚拟环境并明确版本
虚拟环境可以为每个项目创建独立的 Python 环境，避免不同项目之间的依赖冲突。在创建虚拟环境时，可以指定使用的 Python 版本。例如，使用 `venv` 模块创建虚拟环境：
```bash
python3 -m venv myenv
source myenv/bin/activate  # 在 Linux 和 macOS 上
myenv\Scripts\activate  # 在 Windows 上
```
创建好虚拟环境并激活后，可以使用 `python --version` 确认虚拟环境中使用的 Python 版本。如果需要指定特定版本的 Python 来创建虚拟环境，可以先安装 `pyenv`（一种 Python 版本管理工具），通过 `pyenv` 安装指定版本的 Python，然后再创建虚拟环境。

## 小结
了解如何查看 Python 版本是 Python 开发过程中的基础技能。通过命令行和 Python 脚本中的多种方法，我们可以方便地获取当前 Python 版本信息。在项目开发过程中，无论是初始化项目还是排查问题，查看 Python 版本都起着重要作用。遵循记录项目 Python 版本和使用虚拟环境明确版本等最佳实践，可以提高项目的可维护性和兼容性。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [《Python 核心编程》](https://book.douban.com/subject/25707974/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}