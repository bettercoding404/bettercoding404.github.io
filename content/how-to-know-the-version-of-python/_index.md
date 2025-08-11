---
title: "如何查看Python版本"
description: "在Python开发过程中，了解当前使用的Python版本至关重要。不同的Python版本在语法、库的支持以及功能特性上可能存在差异。知晓Python版本能帮助开发者确保代码的兼容性，正确使用对应的库版本，以及更好地排查问题。本文将详细介绍查看Python版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
在Python开发过程中，了解当前使用的Python版本至关重要。不同的Python版本在语法、库的支持以及功能特性上可能存在差异。知晓Python版本能帮助开发者确保代码的兼容性，正确使用对应的库版本，以及更好地排查问题。本文将详细介绍查看Python版本的基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. **基础概念**
2. **使用方法**
    - **命令行方式**
    - **在Python脚本中查看**
3. **常见实践**
    - **开发前确认版本**
    - **部署环境检查**
4. **最佳实践**
    - **自动化版本检查**
    - **版本管理工具结合**
5. **小结**
6. **参考资料**

## 基础概念
Python有多个主要版本，如Python 2和Python 3，每个主要版本下又有不同的次版本和补丁版本。版本号通常遵循语义化版本控制（Semantic Versioning）规范，格式为`主版本号.次版本号.补丁版本号`。例如，`3.8.5` 中，`3` 是主版本号，代表着较大的功能更新和不兼容的改变；`8` 是次版本号，通常包含新功能但保持向后兼容性；`5` 是补丁版本号，主要用于修复漏洞和稳定性改进。

## 使用方法

### 命令行方式
- **Windows系统**
    - 打开命令提示符（CMD）。在开始菜单中搜索“命令提示符”并打开。
    - 输入 `python --version` 命令，回车后将显示Python版本信息。例如：
```bash
python --version
Python 3.8.5
```
    - 如果你安装了多个Python版本，并且配置了环境变量，可以通过指定Python版本的路径来查看特定版本。例如，假设Python 3.9安装在 `C:\Python39` 目录下，在命令提示符中输入 `C:\Python39\python.exe --version` 来查看Python 3.9的版本。

- **Linux系统**
    - 打开终端。
    - 同样输入 `python --version` 命令来查看系统默认Python版本。若要查看Python 3的版本，可输入 `python3 --version`。例如：
```bash
python3 --version
Python 3.9.7
```

- **macOS系统**
    - 打开“终端”应用。
    - 使用 `python --version` 或者 `python3 --version` 命令，操作与Linux系统类似。

### 在Python脚本中查看
在Python脚本中，可以使用 `sys` 模块来获取Python版本信息。示例代码如下：
```python
import sys

print(sys.version)
```
上述代码导入 `sys` 模块，然后使用 `sys.version` 打印出详细的Python版本信息，包括主版本号、次版本号、补丁版本号以及一些编译和平台相关的信息。例如输出可能为：
```
3.8.5 (default, Jul 28 2021, 12:59:40) 
[GCC 9.3.0]
```
如果只想获取版本号的主要部分，可以使用 `sys.version_info`：
```python
import sys

version_info = sys.version_info
print(f"主版本号: {version_info.major}")
print(f"次版本号: {version_info.minor}")
print(f"补丁版本号: {version_info.micro}")
```
这段代码通过 `sys.version_info` 获取版本信息对象，然后分别访问 `major`、`minor` 和 `micro` 属性来打印主版本号、次版本号和补丁版本号。

## 常见实践

### 开发前确认版本
在开始一个新的Python项目开发时，首先要确认开发环境中的Python版本。不同的项目可能依赖特定的Python版本，例如某些旧项目可能仍然基于Python 2运行，而新项目通常推荐使用Python 3的最新版本以享受新特性和更好的性能。通过在命令行中输入 `python --version` 命令，确保开发环境与项目要求的版本一致。

### 部署环境检查
在将Python应用部署到生产环境之前，需要检查目标环境中的Python版本。这可以避免因版本不兼容导致的部署失败或运行时错误。在部署脚本中，可以添加检查Python版本的逻辑，例如：
```python
import sys

required_major = 3
required_minor = 8

if sys.version_info.major != required_major or sys.version_info.minor < required_minor:
    raise SystemExit(f"需要Python {required_major}.{required_minor} 或更高版本，当前版本为 {sys.version}")
```
这段代码检查当前Python版本是否满足项目所需的最低版本要求，如果不满足则抛出异常并提示用户。

## 最佳实践

### 自动化版本检查
在持续集成（CI）流程中，可以自动化Python版本检查。例如，在使用GitLab CI/CD或GitHub Actions时，在 `.gitlab-ci.yml` 或 `.github/workflows` 配置文件中添加检查Python版本的步骤：
```yaml
image: python:3.9

stages:
  - test

test_version:
  stage: test
  script:
    - python --version | grep -q '3.9'
```
上述GitLab CI/CD配置使用Python 3.9镜像，并在测试阶段检查Python版本是否为3.9。如果版本不匹配，`grep -q '3.9'` 命令将返回非零退出码，导致构建失败。

### 版本管理工具结合
结合版本管理工具（如`pyenv` 或 `virtualenv`）来更好地控制Python版本。`pyenv` 允许在同一系统上安装和切换不同的Python版本，`virtualenv` 则可以创建独立的Python虚拟环境，每个环境可以有特定的Python版本和依赖包。例如，使用 `pyenv` 安装特定版本的Python：
```bash
pyenv install 3.9.7
```
然后可以使用 `pyenv local 3.9.7` 在当前项目目录中切换到该版本。使用 `virtualenv` 创建虚拟环境并指定Python版本：
```bash
virtualenv -p python3.9 myenv
```
这将使用Python 3.9创建一个名为 `myenv` 的虚拟环境。

## 小结
了解如何查看Python版本是Python开发和部署过程中的基础技能。通过命令行和在脚本中使用 `sys` 模块等方法，开发者可以方便地获取Python版本信息。在常见实践中，开发前和部署环境检查版本能确保项目的兼容性和稳定性。最佳实践方面，自动化版本检查和结合版本管理工具能进一步提升开发效率和项目的可维护性。

## 参考资料
- [Python官方文档 - sys模块](https://docs.python.org/3/library/sys.html)
- [pyenv官方文档](https://github.com/pyenv/pyenv)
- [virtualenv官方文档](https://virtualenv.pypa.io/en/latest/)