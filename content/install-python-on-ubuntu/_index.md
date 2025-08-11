---
title: "在 Ubuntu 上安装 Python"
description: "Python 是一种广泛使用的高级编程语言，因其简洁的语法和丰富的库而备受青睐。在 Ubuntu 操作系统上安装 Python 是许多开发者和数据科学家的常见需求。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松完成安装并掌握相关技巧。"
date: 2025-04-13
categories: ["python"]
last_modified_at: 2025-04-13
cascade:
  - type: docs
---


## 简介
Python 是一种广泛使用的高级编程语言，因其简洁的语法和丰富的库而备受青睐。在 Ubuntu 操作系统上安装 Python 是许多开发者和数据科学家的常见需求。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松完成安装并掌握相关技巧。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 安装默认版本 Python
    - 安装指定版本 Python
3. 常见实践
    - 安装 Python 包管理工具
    - 虚拟环境的使用
4. 最佳实践
    - 配置环境变量
    - 保持 Python 环境整洁
5. 小结
6. 参考资料

## 基础概念
Python 有多个版本，如 Python 2 和 Python 3，目前 Python 3 是主流版本。Ubuntu 作为一个流行的 Linux 发行版，自带了 Python，但版本可能不是最新的。安装 Python 意味着将 Python 解释器及其相关库文件部署到系统中，以便用户可以编写和运行 Python 代码。

## 使用方法

### 安装默认版本 Python
Ubuntu 的软件源中包含了 Python 包，通过系统的包管理器 `apt` 可以轻松安装默认版本的 Python。
1. **更新软件源**
在安装任何软件之前，建议先更新软件源，以确保获取到最新的软件包信息。
```bash
sudo apt update
```
2. **安装 Python 3**
Ubuntu 通常默认提供 Python 3，使用以下命令进行安装：
```bash
sudo apt install python3
```
3. **安装 Python 2（可选）**
虽然 Python 2 已不再维护，但某些旧项目可能仍依赖它。如果需要安装 Python 2，可以使用以下命令：
```bash
sudo apt install python2
```

### 安装指定版本 Python
有时候，我们需要安装特定版本的 Python，例如 Python 3.9 或 Python 3.10。可以通过以下步骤实现：
1. **添加官方 Python 仓库**
对于 Ubuntu 20.04 及以上版本，可以添加官方的 Python 仓库来获取更多版本选择。
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
2. **更新软件源**
```bash
sudo apt update
```
3. **安装指定版本 Python**
例如，安装 Python 3.9：
```bash
sudo apt install python3.9
```

## 常见实践

### 安装 Python 包管理工具
Python 有两个常用的包管理工具：`pip` 和 `pip3`。`pip` 用于 Python 2，`pip3` 用于 Python 3。在 Ubuntu 上，安装 Python 时通常会自动安装相应的 `pip` 版本。但为了确保是最新版本，可以使用以下命令更新：
```bash
sudo apt install python3-pip
pip3 install --upgrade pip
```

### 虚拟环境的使用
虚拟环境是隔离 Python 项目依赖的重要工具，每个项目可以拥有自己独立的 Python 环境，避免不同项目之间的依赖冲突。
1. **安装 `venv` 模块**
`venv` 是 Python 3 自带的虚拟环境创建工具，通常已经安装。如果没有安装，可以使用以下命令：
```bash
sudo apt install python3-venv
```
2. **创建虚拟环境**
在项目目录下，使用以下命令创建虚拟环境：
```bash
python3 -m venv myenv
```
这将在当前目录下创建一个名为 `myenv` 的虚拟环境。
3. **激活虚拟环境**
在 Linux 系统中，使用以下命令激活虚拟环境：
```bash
source myenv/bin/activate
```
激活后，命令行提示符会显示虚拟环境的名称，此时安装的 Python 包将只在该虚拟环境中生效。
4. **退出虚拟环境**
当完成项目开发后，使用以下命令退出虚拟环境：
```bash
deactivate
```

## 最佳实践

### 配置环境变量
为了方便在任何目录下运行 Python 脚本，可以将 Python 安装目录添加到系统的环境变量中。例如，将 Python 3.9 的安装目录添加到环境变量：
1. **编辑 `~/.bashrc` 文件**
```bash
nano ~/.bashrc
```
2. **在文件末尾添加以下内容**
```bash
export PATH="/usr/bin/python3.9:$PATH"
```
3. **保存并退出编辑器，然后使配置生效**
```bash
source ~/.bashrc
```

### 保持 Python 环境整洁
定期清理不再使用的 Python 包和虚拟环境，避免占用过多磁盘空间。可以使用 `pip` 的 `uninstall` 命令卸载不需要的包，删除虚拟环境目录来清理虚拟环境。

## 小结
本文详细介绍了在 Ubuntu 上安装 Python 的相关知识，包括基础概念、不同版本的安装方法、常见实践以及最佳实践。通过掌握这些内容，读者可以轻松在 Ubuntu 系统上安装并配置适合自己需求的 Python 环境，为后续的开发和学习打下坚实的基础。

## 参考资料
- [Ubuntu 官方文档](https://ubuntu.com/docs)
- [Python 官方文档](https://docs.python.org/3/)
- [Ask Ubuntu](https://askubuntu.com/)