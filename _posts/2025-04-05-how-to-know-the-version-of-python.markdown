---
title: "如何查看 Python 版本"
description: "在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同版本的 Python 在语法、库的支持以及性能等方面可能存在差异。明确版本信息有助于我们更好地编写代码、解决兼容性问题以及选择合适的库和工具。本文将详细介绍如何查看 Python 版本，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。"
date: 2025-04-05
categories: ["python"]
last_modified_at: 2025-04-05
---


## 简介
在 Python 开发过程中，了解当前使用的 Python 版本至关重要。不同版本的 Python 在语法、库的支持以及性能等方面可能存在差异。明确版本信息有助于我们更好地编写代码、解决兼容性问题以及选择合适的库和工具。本文将详细介绍如何查看 Python 版本，涵盖基础概念、多种使用方法、常见实践场景以及最佳实践建议。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 在命令行中查看
    - 在 Python 脚本中查看
3. 常见实践
    - 检查虚拟环境中的 Python 版本
    - 部署项目时确认 Python 版本
4. 最佳实践
    - 记录项目的 Python 版本
    - 确保开发和生产环境版本一致
5. 小结
6. 参考资料

## 基础概念
Python 有多个主要版本，如 Python 2 和 Python 3，每个主要版本下又有多个次要版本和补丁版本。版本号通常遵循 `主版本号.次版本号.补丁版本号` 的格式，例如 `3.8.10`。主版本号的变更往往伴随着较大的语法和功能改进，次版本号的更新可能引入新的功能或对现有功能进行优化，补丁版本号则主要用于修复 bug。

## 使用方法
### 在命令行中查看
1. **Windows 系统**
    - 打开命令提示符（CMD）。在开始菜单中搜索“命令提示符”并打开。
    - 输入 `python --version` 命令，按下回车键，即可看到 Python 的版本号。例如：
```bash
python --version
Python 3.8.10
```
    - 如果你安装了多个 Python 版本，并且通过路径设置了不同版本的调用方式，例如使用 `python3` 来调用 Python 3 版本，可以输入 `python3 --version` 来查看 Python 3 的版本。
```bash
python3 --version
Python 3.8.10
```
2. **Linux 和 macOS 系统**
    - 打开终端。
    - 同样输入 `python --version` 或 `python3 --version` 命令来查看相应版本的 Python 版本号。例如：
```bash
python --version
Python 2.7.18
python3 --version
Python 3.9.6
```

### 在 Python 脚本中查看
在 Python 脚本中，可以使用 `sys` 模块来获取 Python 版本信息。以下是一个示例代码：
```python
import sys

print(sys.version)
```
运行上述代码，输出结果将包含 Python 的详细版本信息，例如：
```bash
3.8.10 (tags/v3.8.10:3d8993a, May  3 2021, 11:48:03) [MSC v.1928 64 bit (AMD64)]
```
如果只想获取版本号的主要部分，可以使用 `sys.version_info`：
```python
import sys

print(sys.version_info.major)  # 输出主版本号
print(sys.version_info.minor)  # 输出次版本号
print(sys.version_info.micro)  # 输出补丁版本号
```

## 常见实践
### 检查虚拟环境中的 Python 版本
在使用虚拟环境进行项目开发时，需要确保虚拟环境中的 Python 版本符合项目要求。以 `venv` 模块创建的虚拟环境为例：
1. 激活虚拟环境：
    - 在 Windows 系统中，进入虚拟环境的 `Scripts` 目录，然后运行 `activate` 命令。例如，虚拟环境名为 `myenv`：
```bash
cd myenv\Scripts
activate
```
    - 在 Linux 和 macOS 系统中，进入虚拟环境的 `bin` 目录，然后运行 `source activate` 命令：
```bash
source myenv/bin/activate
```
2. 激活虚拟环境后，使用前面介绍的命令行方式查看 Python 版本：
```bash
python --version
Python 3.8.10
```

### 部署项目时确认 Python 版本
在将项目部署到生产环境之前，需要确认生产环境中的 Python 版本与开发环境一致。可以在部署脚本中添加检查 Python 版本的逻辑。例如，使用 shell 脚本检查 Python 3 版本：
```bash
#!/bin/bash

python_version=$(python3 --version 2>&1)
expected_version="Python 3.8.10"

if [[ $python_version == $expected_version ]]; then
    echo "Python 版本符合要求"
else
    echo "Python 版本不匹配，期望版本为 $expected_version，实际版本为 $python_version"
fi
```

## 最佳实践
### 记录项目的 Python 版本
在项目的文档中明确记录所使用的 Python 版本。可以在项目的 `README.md` 文件中添加一个章节，说明项目所需的 Python 版本信息。例如：
```
### Python 版本要求
本项目基于 Python 3.8.10 开发，建议使用相同版本的 Python 以确保兼容性。
```

### 确保开发和生产环境版本一致
使用版本管理工具（如 `pipenv` 或 `poetry`）来管理项目的依赖和 Python 版本。这些工具可以创建项目特定的虚拟环境，并锁定依赖的版本，包括 Python 版本。例如，使用 `pipenv`：
1. 初始化项目：
```bash
pipenv install
```
2. 在 `Pipfile` 文件中可以看到锁定的 Python 版本信息：
```toml
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[packages]

[dev-packages]

[requires]
python_version = "3.8"
```

## 小结
通过本文，我们学习了如何查看 Python 版本，包括在命令行和 Python 脚本中查看的方法。同时，了解了在虚拟环境和项目部署中检查 Python 版本的常见实践，以及记录项目 Python 版本和确保环境一致性的最佳实践。掌握这些知识和技巧，有助于我们在 Python 开发过程中更好地管理项目、解决兼容性问题，提高开发效率和代码质量。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [Python 版本管理最佳实践](https://realpython.com/python-best-practices/){: rel="nofollow"}