---
title: "Python 在 Ubuntu 上的安装与使用"
description: "Python 是一种广泛使用的高级编程语言，因其简洁的语法、强大的功能和丰富的库而备受欢迎。在 Ubuntu 系统上安装和使用 Python 是许多开发者和数据科学家的日常操作。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握在 Ubuntu 环境中运用 Python 的技能。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
Python 是一种广泛使用的高级编程语言，因其简洁的语法、强大的功能和丰富的库而备受欢迎。在 Ubuntu 系统上安装和使用 Python 是许多开发者和数据科学家的日常操作。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者更好地掌握在 Ubuntu 环境中运用 Python 的技能。

<!-- more -->
## 目录
1. **基础概念**
    - Python 版本
    - Ubuntu 软件包管理
2. **使用方法**
    - 安装 Python
    - 验证安装
    - 运行 Python 脚本
3. **常见实践**
    - 安装 Python 库
    - 创建虚拟环境
4. **最佳实践**
    - 选择合适的 Python 版本
    - 管理依赖
    - 配置开发环境
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本
Python 有两个主要版本：Python 2 和 Python 3。Python 2 已经停止更新，Python 3 是当前的主流版本，具有更好的性能、安全性和新特性。在 Ubuntu 上，默认安装的可能是 Python 2 和 Python 3 中的一个或两个版本。

### Ubuntu 软件包管理
Ubuntu 使用 `apt`（Advanced Package Tool）进行软件包的管理。通过 `apt`，可以方便地安装、更新和卸载系统软件和应用程序，包括 Python 及其相关库。

## 使用方法
### 安装 Python
Ubuntu 仓库中提供了 Python 3 的安装包，可以使用以下命令进行安装：
```bash
sudo apt update
sudo apt install python3
```
如果需要安装 Python 2，可以使用以下命令：
```bash
sudo apt update
sudo apt install python2
```
### 验证安装
安装完成后，可以通过以下命令验证 Python 的版本：
```bash
python3 --version
```
对于 Python 2：
```bash
python2 --version
```
### 运行 Python 脚本
创建一个简单的 Python 脚本 `hello.py`，内容如下：
```python
print("Hello, World!")
```
使用以下命令运行该脚本：
```bash
python3 hello.py
```
如果是 Python 2 脚本，则使用：
```bash
python2 hello.py
```

## 常见实践
### 安装 Python 库
Python 丰富的库是其强大之处之一。可以使用 `pip` 工具来安装 Python 库。`pip` 通常随 Python 一起安装。例如，安装 `numpy` 库：
```bash
pip3 install numpy
```
对于 Python 2：
```bash
pip2 install numpy
```
### 创建虚拟环境
虚拟环境可以隔离不同项目的 Python 环境和依赖。首先安装 `virtualenv`：
```bash
pip3 install virtualenv
```
创建一个虚拟环境，例如命名为 `myenv`：
```bash
virtualenv myenv
```
激活虚拟环境：
```bash
source myenv/bin/activate
```
在虚拟环境中安装的库只在该环境中可用。退出虚拟环境可以使用：
```bash
deactivate
```

## 最佳实践
### 选择合适的 Python 版本
如果是新项目开发，强烈建议使用 Python 3。但如果需要兼容旧项目，可能需要同时维护 Python 2 和 Python 3 环境。

### 管理依赖
使用 `requirements.txt` 文件来记录项目的依赖。可以通过以下命令生成：
```bash
pip freeze > requirements.txt
```
在新环境中安装依赖：
```bash
pip install -r requirements.txt
```
### 配置开发环境
使用 IDE（如 PyCharm、VS Code）可以提高开发效率。在 IDE 中配置 Python 解释器和项目设置，以确保项目的顺利开发。

## 小结
本文详细介绍了在 Ubuntu 上安装和使用 Python 的相关知识，包括基础概念、使用方法、常见实践和最佳实践。通过掌握这些内容，读者可以在 Ubuntu 系统上轻松安装和使用 Python，并进行高效的开发和数据分析等工作。

## 参考资料
- [Python 官方文档](https://docs.python.org/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [The Hitchhiker's Guide to Python](https://docs.python-guide.org/){: rel="nofollow"}