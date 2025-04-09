---
title: "在 Ubuntu 上安装 Python"
description: "Python 是一种广泛使用的高级编程语言，以其简洁的语法和强大的功能在数据科学、Web 开发、自动化脚本等众多领域备受青睐。Ubuntu 作为一款流行的 Linux 发行版，为安装和使用 Python 提供了良好的环境。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者顺利在 Ubuntu 系统中开启 Python 编程之旅。"
date: 2025-04-09
categories: ["python"]
last_modified_at: 2025-04-09
---


## 简介
Python 是一种广泛使用的高级编程语言，以其简洁的语法和强大的功能在数据科学、Web 开发、自动化脚本等众多领域备受青睐。Ubuntu 作为一款流行的 Linux 发行版，为安装和使用 Python 提供了良好的环境。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者顺利在 Ubuntu 系统中开启 Python 编程之旅。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本**
    - **Ubuntu 软件包管理系统**
2. **使用方法**
    - **使用 Ubuntu 官方软件源安装 Python**
    - **使用源码编译安装 Python**
3. **常见实践**
    - **安装特定版本的 Python**
    - **管理 Python 虚拟环境**
4. **最佳实践**
    - **更新系统和软件包**
    - **使用包管理器安装依赖**
    - **配置开发环境**
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本
Python 有多个主要版本，如 Python 2 和 Python 3。Python 2 曾广泛使用，但现在已逐渐停止维护，Python 3 成为主流版本，具备更好的性能、安全性和新特性。在 Ubuntu 上安装 Python 时，需明确要安装的版本。

### Ubuntu 软件包管理系统
Ubuntu 使用 `apt`（Advanced Package Tool）作为软件包管理系统。通过 `apt`，可以轻松地安装、更新和卸载软件包。在安装 Python 及其相关库时，`apt` 发挥着重要作用。

## 使用方法
### 使用 Ubuntu 官方软件源安装 Python
1. **更新软件包列表**
在安装 Python 之前，首先更新系统的软件包列表，以确保获取到最新的软件信息。打开终端，输入以下命令：
```bash
sudo apt update
```
2. **安装 Python 3**
Ubuntu 官方软件源提供了 Python 3 的安装包，可以使用以下命令进行安装：
```bash
sudo apt install python3
```
3. **安装 Python 2（可选，不推荐长期使用）**
如果确实需要 Python 2，可使用以下命令安装：
```bash
sudo apt install python2
```
4. **安装 Python 开发工具**
安装开发工具包可以帮助开发 Python 应用程序，例如安装 Python 3 的开发头文件和库：
```bash
sudo apt install python3-dev
```

### 使用源码编译安装 Python
1. **下载 Python 源码**
从 Python 官方网站（https://www.python.org/downloads/source/）下载所需版本的 Python 源码。例如，下载 Python 3.9.10 的源码：
```bash
wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz
```
2. **解压源码**
使用以下命令解压下载的源码包：
```bash
tar -xvf Python-3.9.10.tgz
```
3. **进入源码目录**
```bash
cd Python-3.9.10
```
4. **配置编译选项**
```bash
./configure --enable-optimizations
```
5. **编译和安装**
```bash
make -j $(nproc)
sudo make install
```

## 常见实践
### 安装特定版本的 Python
有时候需要安装特定版本的 Python，例如 Python 3.8。可以通过 Ubuntu 的 `deadsnakes` PPA（Personal Package Archive）来实现。
1. **添加 `deadsnakes` PPA**
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
2. **更新软件包列表**
```bash
sudo apt update
```
3. **安装 Python 3.8**
```bash
sudo apt install python3.8
```

### 管理 Python 虚拟环境
虚拟环境可以隔离不同项目的 Python 依赖，避免版本冲突。使用 `venv` 模块创建虚拟环境：
1. **安装 `venv` 模块（如果未安装）**
```bash
sudo apt install python3-venv
```
2. **创建虚拟环境**
在项目目录中，使用以下命令创建名为 `myenv` 的虚拟环境：
```bash
python3 -m venv myenv
```
3. **激活虚拟环境**
```bash
source myenv/bin/activate
```
4. **退出虚拟环境**
```bash
deactivate
```

## 最佳实践
### 更新系统和软件包
在安装 Python 之前，确保系统和软件包是最新的，这可以提高系统的稳定性和安全性，同时避免安装过程中出现依赖问题。定期运行 `sudo apt update` 和 `sudo apt upgrade` 命令。

### 使用包管理器安装依赖
在安装 Python 库和依赖时，优先使用 Ubuntu 的包管理器 `apt`。例如，安装 `numpy` 库：
```bash
sudo apt install python3-numpy
```
这样安装的库会与系统更好地集成，并且便于管理和更新。

### 配置开发环境
为了提高开发效率，可以配置适合 Python 开发的环境。例如，安装代码编辑器（如 Visual Studio Code），并安装 Python 扩展。同时，配置好代码格式化工具（如 `black`）和代码检查工具（如 `pylint`）。

## 小结
在 Ubuntu 上安装 Python 有多种方法，每种方法都有其适用场景。通过 Ubuntu 官方软件源安装简单快捷，适合大多数用户；而通过源码编译安装可以获取最新版本的 Python，但过程相对复杂。在实际使用中，根据需求选择合适的安装方式，并注意管理 Python 版本和虚拟环境，遵循最佳实践，能够更高效地进行 Python 开发。

## 参考资料
- [Python 官方网站](https://www.python.org/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [Python 在 Ubuntu 上的安装教程](https://docs.python-guide.org/starting/install3/linux/){: rel="nofollow"}