---
title: "如何查看Python版本"
description: "在Python开发过程中，了解当前使用的Python版本是非常重要的。不同的Python版本在语法、库的兼容性等方面存在差异。知晓版本信息有助于开发者确保代码在目标环境中能够正常运行，并且在遇到问题时可以根据版本特性进行排查和解决。本文将详细介绍查看Python版本的多种方法。"
date: 2025-04-10
categories: ["python"]
last_modified_at: 2025-04-10
---


## 简介
在Python开发过程中，了解当前使用的Python版本是非常重要的。不同的Python版本在语法、库的兼容性等方面存在差异。知晓版本信息有助于开发者确保代码在目标环境中能够正常运行，并且在遇到问题时可以根据版本特性进行排查和解决。本文将详细介绍查看Python版本的多种方法。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在命令行中查看
    - 在Python脚本中查看
3. 常见实践
    - 项目初始化时确认版本
    - 排查兼容性问题时查看版本
4. 最佳实践
    - 记录项目所需Python版本
    - 自动化版本检查
5. 小结
6. 参考资料

## 基础概念
Python有多个主要版本，如Python 2和Python 3，每个主要版本又包含多个次要版本和补丁版本。版本号通常遵循“主版本号.次版本号.补丁版本号”的格式。例如，Python 3.8.5 中，“3”是主版本号，“8”是次版本号，“5”是补丁版本号。主版本号的变化通常意味着较大的语法和功能更新，次版本号的更新会带来一些新特性和功能改进，补丁版本号主要用于修复漏洞。

## 使用方法

### 在命令行中查看
1. **Windows系统**
    - 打开命令提示符（CMD）。如果安装Python时没有将其添加到系统路径，需要先进入Python的安装目录。例如，Python安装在`C:\Python38`，则在命令提示符中输入`C:\Python38\python.exe --version`。
    - 如果Python已经添加到系统路径，可以直接在命令提示符中输入`python --version`。

2. **Linux和macOS系统**
    - 打开终端，输入`python --version` 查看Python版本。如果系统同时安装了Python 2和Python 3，想要查看Python 3的版本，可以使用`python3 --version`。

### 在Python脚本中查看
在Python脚本中，可以使用`sys`模块来获取Python版本信息。示例代码如下：
```python
import sys

print(sys.version)
```
上述代码通过导入`sys`模块，然后使用`sys.version`属性打印出详细的Python版本信息，包括版本号、编译器信息和构建日期等。

如果你只想获取版本号的主要部分，可以使用以下代码：
```python
import sys

print(sys.version_info.major)  # 打印主版本号
print(sys.version_info.minor)  # 打印次版本号
print(sys.version_info.micro)  # 打印补丁版本号
```

## 常见实践

### 项目初始化时确认版本
在开始一个新的Python项目时，首先要确认开发环境中的Python版本是否符合项目要求。例如，项目要求使用Python 3.6及以上版本，开发人员可以在项目初始化脚本中添加查看版本的代码，或者在命令行中查看版本，确保开发环境正确。

### 排查兼容性问题时查看版本
当代码在运行过程中出现兼容性问题，如某些库无法导入或函数调用出错时，首先要查看Python版本。因为不同版本的Python对库的支持情况不同。通过查看版本，可以确定是否是由于版本不兼容导致的问题。例如，某个新特性在Python 3.8中才支持，如果在Python 3.6中使用就会出错。

## 最佳实践

### 记录项目所需Python版本
在项目的文档中明确记录项目所需的Python版本。可以在项目的README文件或者专门的环境配置文档中说明。例如：
```
本项目需要Python 3.7及以上版本运行。
```
这样其他开发人员在接手项目或者部署项目时，可以快速了解项目的版本要求。

### 自动化版本检查
在项目的构建脚本或者启动脚本中添加版本检查逻辑。例如，使用`if`语句在脚本开头检查Python版本，如果版本不符合要求，给出提示并终止脚本运行。示例代码如下：
```python
import sys

required_major = 3
required_minor = 7

if sys.version_info.major < required_major or (sys.version_info.major == required_major and sys.version_info.minor < required_minor):
    print(f"本项目需要Python {required_major}.{required_minor}及以上版本，请升级Python版本。")
    sys.exit(1)

# 以下是项目的正常代码
print("项目开始运行...")
```

## 小结
查看Python版本是Python开发中的基础操作，通过命令行和在Python脚本中都可以方便地获取版本信息。在实际开发中，无论是项目初始化还是排查问题，了解Python版本都至关重要。遵循最佳实践，如记录项目所需版本和自动化版本检查，可以提高开发效率，减少因版本问题导致的错误。

## 参考资料