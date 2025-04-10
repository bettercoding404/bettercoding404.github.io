---
title: "在 Ubuntu 上安装 Python：从基础到最佳实践"
description: "Python 作为一种广泛应用于软件开发、数据科学、人工智能等众多领域的编程语言，在 Ubuntu 系统上安装并正确配置它是许多开发者和学习者的重要任务。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、具体使用方法、常见实践场景以及最佳实践，帮助读者快速掌握相关技能并在开发中高效运用。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
Python 作为一种广泛应用于软件开发、数据科学、人工智能等众多领域的编程语言，在 Ubuntu 系统上安装并正确配置它是许多开发者和学习者的重要任务。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、具体使用方法、常见实践场景以及最佳实践，帮助读者快速掌握相关技能并在开发中高效运用。

<!-- more -->
## 目录
1. **基础概念**
2. **安装方法**
    - **使用 Ubuntu 官方软件源安装**
    - **从源码编译安装**
3. **常见实践**
    - **安装特定版本的 Python**
    - **管理 Python 虚拟环境**
4. **最佳实践**
    - **更新 Python 及相关包**
    - **配置开发环境**
5. **小结**
6. **参考资料**

## 基础概念
Python 有多个版本，如 Python 2 和 Python 3，目前 Python 3 是主流版本，因为 Python 2 已于 2020 年停止官方维护。在 Ubuntu 系统中，安装 Python 意味着将 Python 解释器以及相关的标准库和工具安装到系统中，以便能够运行 Python 代码。

Ubuntu 提供了软件包管理系统（如 apt）来简化软件的安装、更新和卸载过程。通过这个系统，可以方便地安装 Python 及其相关的包。

## 安装方法

### 使用 Ubuntu 官方软件源安装
这是最简便的安装方式，适用于大多数用户。

1. **更新软件包列表**
在终端中运行以下命令，更新系统的软件包列表，确保获取到最新的软件信息：
```bash
sudo apt update
```

2. **安装 Python 3**
对于 Ubuntu 系统，通常默认安装的是 Python 3。可以使用以下命令安装 Python 3 及其相关的常用开发包：
```bash
sudo apt install python3 python3-pip
```
`python3` 是 Python 3 的解释器，`python3-pip` 是 Python 3 的包管理工具，用于安装和管理 Python 包。

3. **验证安装**
安装完成后，可以在终端中输入以下命令来验证 Python 3 是否安装成功：
```bash
python3 --version
```
如果安装正确，将显示 Python 3 的版本号，例如 `Python 3.8.10`。

### 从源码编译安装
这种方法适合需要安装特定版本 Python 或者对安装过程有更高控制权的用户。

1. **下载 Python 源码**
首先，从 Python 官方网站（https://www.python.org/downloads/source/）下载所需版本的 Python 源码。例如，要下载 Python 3.9.6 版本，可以使用以下命令：
```bash
wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz
```

2. **解压源码**
下载完成后，解压下载的文件：
```bash
tar -xvzf Python-3.9.6.tgz
```

3. **进入源码目录并配置**
进入解压后的目录，并运行配置脚本：
```bash
cd Python-3.9.6
./configure --enable-optimizations
```
`--enable-optimizations` 参数用于优化编译后的 Python 解释器性能。

4. **编译和安装**
运行以下命令进行编译和安装：
```bash
make -j$(nproc)
sudo make install
```
`make -j$(nproc)` 中的 `-j$(nproc)` 参数表示使用系统的所有可用处理器核心进行编译，以加快编译速度。

5. **验证安装**
同样，通过以下命令验证安装是否成功：
```bash
python3 --version
```

## 常见实践

### 安装特定版本的 Python
有时候，项目可能需要特定版本的 Python。除了从源码编译安装特定版本外，还可以使用 `deadsnakes` PPA（Personal Package Archive）来安装不同版本的 Python。

1. **添加 `deadsnakes` PPA**
在终端中运行以下命令添加 PPA：
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```

2. **更新软件包列表**
```bash
sudo apt update
```

3. **安装特定版本的 Python**
例如，要安装 Python 3.10，可以运行以下命令：
```bash
sudo apt install python3.10 python3.10-pip
```

### 管理 Python 虚拟环境
虚拟环境允许在同一系统上创建多个独立的 Python 环境，每个环境可以有不同版本的 Python 包，避免包之间的冲突。

1. **安装 `virtualenv`**
首先，使用 `pip` 安装 `virtualenv`：
```bash
pip3 install virtualenv
```

2. **创建虚拟环境**
在项目目录中创建一个虚拟环境，例如名为 `myenv`：
```bash
virtualenv -p python3 myenv
```
`-p python3` 参数指定使用 Python 3 创建虚拟环境。

3. **激活虚拟环境**
在 Linux 系统中，激活虚拟环境的命令如下：
```bash
source myenv/bin/activate
```
激活后，命令行提示符会显示当前处于虚拟环境中。

4. **安装项目所需的包**
在虚拟环境中，可以使用 `pip` 安装项目所需的包，例如安装 `numpy`：
```bash
pip install numpy
```

5. **退出虚拟环境**
完成项目开发后，使用以下命令退出虚拟环境：
```bash
deactivate
```

## 最佳实践

### 更新 Python 及相关包
定期更新 Python 及其安装的包可以获得新功能、修复的漏洞以及性能提升。

1. **更新 Python 解释器**
如果是通过 Ubuntu 官方软件源安装的 Python，可以使用以下命令更新：
```bash
sudo apt update
sudo apt upgrade python3 python3-pip
```

2. **更新已安装的包**
在虚拟环境中，可以使用 `pip` 更新已安装的包：
```bash
pip install --upgrade pip
pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade
```
第一条命令更新 `pip` 本身，第二条命令列出所有过时的包并更新它们。

### 配置开发环境
为了提高开发效率，可以配置一些开发工具和环境。

1. **安装代码编辑器**
例如安装 Visual Studio Code：
```bash
sudo snap install code --classic
```

2. **安装 Python 扩展**
在 Visual Studio Code 中，打开扩展面板，搜索并安装 “Python” 扩展，以获得代码高亮、自动完成、调试等功能。

3. **配置虚拟环境路径**
在 Visual Studio Code 中，打开命令面板（Ctrl + Shift + P），输入 “Python: Select Interpreter”，然后选择虚拟环境中的 Python 解释器路径，例如 `myenv/bin/python`。

## 小结
本文详细介绍了在 Ubuntu 上安装 Python 的多种方法，包括使用官方软件源安装和从源码编译安装。同时，探讨了常见实践场景，如安装特定版本的 Python 和管理虚拟环境。最佳实践部分提供了更新 Python 及相关包以及配置开发环境的建议。通过掌握这些内容，读者可以在 Ubuntu 系统上顺利安装和使用 Python，满足不同项目的开发需求。

## 参考资料
- [Python 官方网站](https://www.python.org/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [`deadsnakes` PPA 官网](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa){: rel="nofollow"}
- [Visual Studio Code 官网](https://code.visualstudio.com/){: rel="nofollow"}