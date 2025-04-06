---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同版本的 Python 在语法、标准库以及第三方库的兼容性上都可能存在差异。知晓 Python 版本有助于开发者选择合适的代码写法、调试问题以及确保项目在不同环境中的顺利运行。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同版本的 Python 在语法、标准库以及第三方库的兼容性上都可能存在差异。知晓 Python 版本有助于开发者选择合适的代码写法、调试问题以及确保项目在不同环境中的顺利运行。本文将详细介绍查看 Python 版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **在命令行中查看**
    - **在 Python 脚本中查看**
3. **常见实践**
    - **新项目初始化时确认版本**
    - **解决兼容性问题时查看版本**
4. **最佳实践**
    - **环境隔离与版本管理**
    - **自动化版本检查**
5. **小结**
6. **参考资料**

## 基础概念
Python 有多个大版本，如 Python 2 和 Python 3，每个大版本又包含多个小版本。版本号通常遵循语义化版本控制规则，格式为 `主版本号.次版本号.修订号`。例如，`3.8.5` 中，`3` 是主版本号，代表了较大的功能更新和不兼容的语法变化；`8` 是次版本号，通常包含新功能和一些兼容性改进；`5` 是修订号，主要用于修复 bug。不同版本在功能和特性上有所不同，所以明确当前使用的版本对于开发工作十分关键。

## 使用方法

### 在命令行中查看
在不同操作系统下，通过命令行查看 Python 版本的方式略有不同，但大致思路一致。

#### Windows 系统
1. 打开命令提示符（CMD）：可以通过在开始菜单中搜索“命令提示符”来打开。
2. 输入命令：
    - 如果安装的是 Python 2，输入 `python -V`（注意 `-V` 是大写），示例输出：`Python 2.7.18`
    - 如果安装的是 Python 3，输入 `python -V`，示例输出：`Python 3.9.6`
    - 若系统同时安装了 Python 2 和 Python 3，并且想指定查看某个版本，可以使用对应的可执行文件路径，例如 `C:\Python27\python.exe -V` 或 `C:\Python39\python.exe -V`

#### Linux 系统
1. 打开终端：可以通过快捷键（如 Ctrl + Alt + T）打开。
2. 输入命令：
    - 对于 Python 2，输入 `python -V`，输出类似 `Python 2.7.18`
    - 对于 Python 3，输入 `python3 -V`，输出类似 `Python 3.8.10`

#### macOS 系统
1. 打开终端：可以在“应用程序” - “实用工具”中找到“终端”并打开。
2. 输入命令：
    - 查看 Python 2 版本：`python -V`，输出如 `Python 2.7.16`
    - 查看 Python 3 版本：`python3 -V`，输出如 `Python 3.9.7`

### 在 Python 脚本中查看
在 Python 脚本内部，也可以获取当前 Python 的版本信息。这在编写跨版本兼容的代码或者需要在脚本中记录版本信息时非常有用。

```python
import sys

print(sys.version)
```

上述代码通过导入 `sys` 模块，然后使用 `sys.version` 来获取完整的 Python 版本信息，包括主版本号、次版本号、修订号以及一些编译信息等。示例输出：`3.9.6 (default, Jun 28 2021, 15:26:21) [MSC v.1929 64 bit (AMD64)]`

如果只想获取版本号的主要部分，可以使用以下方式：

```python
import sys

print(sys.version_info.major)  # 输出主版本号
print(sys.version_info.minor)  # 输出次版本号
print(sys.version_info.micro)  # 输出修订号
```

## 常见实践

### 新项目初始化时确认版本
在开始一个新的 Python 项目时，首先要明确项目将基于哪个 Python 版本进行开发。通过在命令行中查看 Python 版本，可以确保开发环境与项目预期的版本一致。例如，如果项目计划使用 Python 3.8 及以上版本的新特性，那么在初始化项目时就要确认开发环境中的 Python 版本是否满足要求。

### 解决兼容性问题时查看版本
当代码在运行过程中出现兼容性问题，如语法错误或者某些库无法正常导入时，查看 Python 版本是解决问题的第一步。不同版本的 Python 对语法和库的支持有所不同。例如，Python 2 和 Python 3 在字符串处理、异常处理等方面有较大差异。通过查看版本，可以确定问题是否是由于版本不兼容导致的，进而有针对性地进行代码修改或库版本调整。

## 最佳实践

### 环境隔离与版本管理
使用虚拟环境工具（如 `venv` 或 `virtualenv`）来隔离不同项目的 Python 环境，并为每个项目指定特定的 Python 版本。例如，使用 `venv` 创建虚拟环境并指定 Python 版本：

```bash
# 创建一个基于 Python 3.8 的虚拟环境
python3.8 -m venv my_project_env
```

然后激活虚拟环境（在 Windows 下）：

```bash
my_project_env\Scripts\activate
```

在 Linux 和 macOS 下：

```bash
source my_project_env/bin/activate
```

这样可以确保每个项目都有独立的 Python 环境，避免不同项目之间的版本冲突。

### 自动化版本检查
在项目的 CI/CD 流程中，可以添加自动化的版本检查步骤。例如，在 `setup.py` 或 `requirements.txt` 文件中指定项目所需的 Python 版本范围，然后在持续集成工具（如 Jenkins、GitLab CI/CD 等）中配置检查脚本，确保在每次构建时都检查当前环境的 Python 版本是否符合要求。

## 小结
了解如何查看 Python 版本是 Python 开发中的基础技能。通过命令行和脚本内的方法，开发者可以轻松获取版本信息。在实际项目中，无论是新项目初始化还是解决兼容性问题，查看版本都起着关键作用。遵循环境隔离与版本管理以及自动化版本检查等最佳实践，可以提高开发效率，确保项目的稳定性和兼容性。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [Python 版本管理最佳实践](https://realpython.com/python-virtual-environments-a-primer/){: rel="nofollow"}
- [Python 版本号规范](https://www.python.org/dev/peps/pep-0440/){: rel="nofollow"}