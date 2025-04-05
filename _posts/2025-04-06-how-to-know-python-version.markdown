---
title: "如何查看Python版本"
description: "在Python开发过程中，了解当前使用的Python版本至关重要。不同的Python版本在语法、库的使用以及功能特性上可能存在差异。知道自己使用的版本有助于编写兼容的代码，避免因版本不兼容导致的错误。本文将详细介绍如何查看Python版本，涵盖不同操作系统下的多种方法，并通过实际示例进行说明。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
在Python开发过程中，了解当前使用的Python版本至关重要。不同的Python版本在语法、库的使用以及功能特性上可能存在差异。知道自己使用的版本有助于编写兼容的代码，避免因版本不兼容导致的错误。本文将详细介绍如何查看Python版本，涵盖不同操作系统下的多种方法，并通过实际示例进行说明。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **命令行方式**
    - **在Python脚本中查看**
3. **常见实践**
    - **Windows系统实践**
    - **Linux系统实践**
    - **macOS系统实践**
4. **最佳实践**
5. **小结**
6. **参考资料**

## 基础概念
Python有多个主要版本，如Python 2和Python 3，每个主要版本下又有多个次版本。Python 2于2000年发布，Python 3于2008年发布，Python 3在语法和功能上对Python 2进行了许多改进和升级，并且Python 2在2020年1月1日停止官方维护。查看Python版本可以让开发者确定当前环境支持的语法和库版本，确保代码的正确性和兼容性。

## 使用方法

### 命令行方式
在不同操作系统的命令行中，都可以使用简单的命令来查看Python版本。

**Windows系统**：
打开命令提示符（CMD），输入以下命令：
```bash
python --version
```
如果系统同时安装了Python 2和Python 3，并且Python 2的路径在系统环境变量中靠前，那么上述命令可能显示Python 2的版本。若想明确查看Python 3版本，可以输入：
```bash
python3 --version
```

**Linux系统**：
在终端中，输入以下命令查看Python版本：
```bash
python --version
```
大多数Linux发行版默认安装Python 2和Python 3。若要查看Python 3版本，可使用：
```bash
python3 --version
```

**macOS系统**：
打开终端，使用以下命令：
```bash
python --version
```
macOS默认安装Python 2。如果安装了Python 3，可以使用：
```bash
python3 --version
```

### 在Python脚本中查看
在Python脚本内部，也可以通过代码获取当前Python版本信息。使用`sys`模块：
```python
import sys

print(sys.version)
```
上述代码会输出详细的Python版本信息，包括主版本号、次版本号、修订号以及一些编译信息。如果只想获取主版本号和次版本号，可以使用以下代码：
```python
import sys

print(sys.version_info.major, sys.version_info.minor)
```

## 常见实践

### Windows系统实践
1. 打开命令提示符。
2. 输入`python --version`，查看Python版本。如果系统安装了多个Python版本，注意确认输出的版本是否是你预期使用的版本。
3. 如果安装了Python 3且路径已添加到环境变量中，输入`python3 --version`查看Python 3版本。

### Linux系统实践
1. 打开终端。
2. 输入`python --version`查看Python版本。若系统默认Python版本不是你想要的（比如默认Python 2，而你想使用Python 3），输入`python3 --version`查看Python 3版本。
3. 可以将查看版本的命令添加到别名中，方便快速查看。例如，在`~/.bashrc`文件中添加`alias pyv="python --version"`，保存后执行`source ~/.bashrc`，之后在终端输入`pyv`即可查看Python版本。

### macOS系统实践
1. 打开终端。
2. 输入`python --version`查看默认安装的Python 2版本。
3. 如果安装了Python 3，输入`python3 --version`查看Python 3版本。可以通过`brew`安装Python 3，安装完成后直接在终端使用上述命令查看版本。

## 最佳实践
1. **项目初始化时检查版本**：在开始一个新的Python项目时，首先要确定项目所需的Python版本，并在项目文档中明确记录。在开发环境搭建过程中，使用上述方法检查Python版本是否符合要求。
2. **版本管理工具**：使用虚拟环境和版本管理工具，如`virtualenv`和`pipenv`。这些工具可以创建独立的Python环境，并指定使用的Python版本。例如，使用`virtualenv`创建一个指定Python 3版本的虚拟环境：
```bash
virtualenv -p python3 myenv
```
进入虚拟环境后，使用`python --version`命令可以确认当前环境使用的Python版本。
3. **持续集成（CI）环境配置**：在CI环境中，确保使用的Python版本与本地开发环境一致。可以在CI配置文件（如`.travis.yml`或`.circleci/config.yml`）中指定Python版本。例如，在`.travis.yml`中配置Python 3.8：
```yaml
language: python
python:
  - 3.8
```

## 小结
通过命令行方式和在Python脚本内部查看Python版本是开发过程中的基本操作。在不同操作系统下，命令行查看方式略有不同，但核心命令类似。在Python脚本中使用`sys`模块可以方便地获取版本信息。遵循最佳实践，如项目初始化时检查版本、使用版本管理工具以及在CI环境中配置版本，可以确保开发过程的顺利进行，避免因版本不兼容导致的问题。

## 参考资料
1. [Python官方文档](https://docs.python.org/){: rel="nofollow"}
2. [Windows命令提示符使用教程](https://docs.microsoft.com/zh-cn/windows-server/administration/windows-commands/using-the-command-prompt){: rel="nofollow"}
3. [Linux终端命令教程](https://www.tutorialspoint.com/unix/unix-using-terminal.htm){: rel="nofollow"}
4. [macOS终端使用指南](https://support.apple.com/zh-cn/guide/terminal/welcome/mac){: rel="nofollow"}