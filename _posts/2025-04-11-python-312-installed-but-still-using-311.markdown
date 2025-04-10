---
title: "Python 3.12 已安装但仍在使用 3.11：深入解析与实践"
description: "在 Python 的世界里，版本的升级常常带来新的特性和优化。有时我们会遇到这样的情况：明明已经安装了 Python 3.12，但系统或项目却仍然在使用 Python 3.11。理解这种现象背后的原因以及如何正确处理，对于开发者来说至关重要。本文将详细探讨这一主题，帮助你更好地管理 Python 版本，确保项目能顺利运行在期望的 Python 版本上。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
在 Python 的世界里，版本的升级常常带来新的特性和优化。有时我们会遇到这样的情况：明明已经安装了 Python 3.12，但系统或项目却仍然在使用 Python 3.11。理解这种现象背后的原因以及如何正确处理，对于开发者来说至关重要。本文将详细探讨这一主题，帮助你更好地管理 Python 版本，确保项目能顺利运行在期望的 Python 版本上。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本管理**
    - **版本共存原理**
2. **为什么安装了 3.12 却仍使用 3.11**
    - **环境变量问题**
    - **虚拟环境设置**
3. **使用方法**
    - **检查当前 Python 版本**
    - **切换到 Python 3.12**
4. **常见实践**
    - **项目中的版本指定**
    - **多版本开发环境搭建**
5. **最佳实践**
    - **使用版本管理工具**
    - **自动化版本切换脚本**
6. **小结**
7. **参考资料**

## 基础概念
### Python 版本管理
Python 版本管理是确保不同项目能使用特定 Python 版本的关键。由于不同版本的 Python 在语法、库支持等方面存在差异，有效的版本管理能避免兼容性问题。常见的 Python 版本管理方式有系统默认安装、虚拟环境（如 venv、virtualenv）以及版本管理工具（如 pyenv、conda）。

### 版本共存原理
Python 允许不同版本在同一系统中共存。这是因为每个版本都有独立的安装路径和环境配置。例如，Python 3.11 和 Python 3.12 的库文件和可执行文件分别存放在不同目录下，互不干扰。然而，系统如何选择使用哪个版本，则取决于环境变量和相关配置。

## 为什么安装了 3.12 却仍使用 3.11
### 环境变量问题
环境变量决定了系统在执行 `python` 命令时查找的路径。如果系统的 `PATH` 环境变量中，Python 3.11 的路径排在 Python 3.12 之前，那么执行 `python` 命令时，系统会优先找到并使用 Python 3.11。

例如，在 Linux 系统中，`PATH` 环境变量可能类似如下设置：
```bash
export PATH="/usr/local/bin/python3.11:$PATH"
```
在这种情况下，`/usr/local/bin/python3.11` 会被优先搜索，导致使用 Python 3.11。

### 虚拟环境设置
如果项目使用了虚拟环境，虚拟环境的 Python 版本可能在创建时就固定为 3.11。虚拟环境会复制系统 Python 的相关配置和库，若创建虚拟环境时默认使用的是 Python 3.11，那么在该虚拟环境中执行的 Python 代码都会基于 3.11 运行。

例如，使用 `venv` 创建虚拟环境时：
```bash
python3.11 -m venv myenv
source myenv/bin/activate
```
这里创建的虚拟环境 `myenv` 就基于 Python 3.11，激活该环境后，使用的就是 Python 3.11。

## 使用方法
### 检查当前 Python 版本
在命令行中，可以使用以下命令检查当前 Python 版本：
```python
python --version
```
如果安装了多个 Python 版本，也可以通过指定完整路径来检查特定版本：
```bash
/path/to/python3.12 --version
```
### 切换到 Python 3.12
#### 修改环境变量
在 Linux 或 macOS 中，可以通过修改 `PATH` 环境变量，将 Python 3.12 的路径放在前面：
```bash
export PATH="/usr/local/bin/python3.12:$PATH"
```
在 Windows 中，可以通过“系统属性” -> “高级” -> “环境变量”来编辑 `PATH` 变量，将 Python 3.12 的路径添加到靠前位置。

#### 虚拟环境切换
如果项目使用虚拟环境，可以重新创建基于 Python 3.12 的虚拟环境：
```bash
python3.12 -m venv myenv312
source myenv312/bin/activate
```

## 常见实践
### 项目中的版本指定
在项目的 `requirements.txt` 文件中，可以指定项目所需的 Python 版本。例如：
```
python_version >= '3.12'
```
这样在部署项目时，可以确保项目运行在符合要求的 Python 版本上。

### 多版本开发环境搭建
为了在同一系统中方便地切换不同 Python 版本进行开发，可以使用版本管理工具如 `pyenv`。安装 `pyenv` 后，可以通过以下命令安装不同版本的 Python：
```bash
pyenv install 3.11
pyenv install 3.12
```
然后通过 `pyenv global` 或 `pyenv local` 命令来切换全局或项目局部的 Python 版本：
```bash
pyenv global 3.12
```

## 最佳实践
### 使用版本管理工具
除了 `pyenv`，`conda` 也是一个强大的版本管理工具。`conda` 不仅可以管理 Python 版本，还能管理各种依赖库。通过 `conda` 创建环境时，可以指定 Python 版本：
```bash
conda create -n myenv312 python=3.12
conda activate myenv312
```
### 自动化版本切换脚本
为了更方便地切换 Python 版本，可以编写自动化脚本。例如，在 Linux 中，可以编写一个 `switch_python_version.sh` 脚本：
```bash
#!/bin/bash

if [ "$1" == "3.11" ]; then
    export PATH="/usr/local/bin/python3.11:$PATH"
elif [ "$1" == "3.12" ]; then
    export PATH="/usr/local/bin/python3.12:$PATH"
else
    echo "Usage: $0 [3.11|3.12]"
fi
```
保存脚本后，通过 `chmod +x switch_python_version.sh` 赋予执行权限，就可以通过 `./switch_python_version.sh 3.12` 快速切换到 Python 3.12。

## 小结
在 Python 开发中，处理安装了新的 Python 3.12 但仍使用 3.11 的情况，关键在于理解环境变量、虚拟环境和版本管理工具的作用。通过正确配置环境变量、合理使用虚拟环境以及借助版本管理工具，我们可以轻松实现 Python 版本的切换和管理，确保项目在合适的 Python 版本上稳定运行。

## 参考资料
- [Python官方文档](https://docs.python.org/){: rel="nofollow"}
- [pyenv官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}
- [conda官方文档](https://docs.conda.io/en/latest/){: rel="nofollow"}