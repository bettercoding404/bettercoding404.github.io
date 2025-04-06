---
title: "在 Ubuntu 上安装 Python：全面指南"
description: "Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据分析、人工智能等。在 Ubuntu 系统上安装 Python 是许多开发者和数据科学家的基础操作。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并高效运用这一技能。"
date: 2025-04-07
categories: ["python"]
last_modified_at: 2025-04-07
---


## 简介
Python 是一种广泛应用于各种领域的高级编程语言，如 Web 开发、数据分析、人工智能等。在 Ubuntu 系统上安装 Python 是许多开发者和数据科学家的基础操作。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者快速掌握并高效运用这一技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 安装默认版本 Python
    - 安装指定版本 Python
    - 使用虚拟环境
3. 常见实践
    - 安装 Python 包
    - 配置开发环境
4. 最佳实践
    - 版本管理策略
    - 安全安装
5. 小结
6. 参考资料

## 基础概念
Python 有多个版本，目前常用的是 Python 2 和 Python 3。Python 2 逐渐被淘汰，Python 3 是当前的主流版本，具有更好的性能和对新特性的支持。Ubuntu 作为一个流行的 Linux 发行版，默认安装了 Python，但可能不是最新版本或满足特定需求的版本。了解 Python 的不同版本以及 Ubuntu 系统对 Python 的支持情况，对于正确安装和使用 Python 至关重要。

## 使用方法
### 安装默认版本 Python
Ubuntu 仓库中通常包含了 Python 的默认版本。可以使用系统包管理器 `apt` 进行安装：
```bash
sudo apt update
sudo apt install python3 python3-pip
```
上述命令首先更新系统软件包列表（`sudo apt update`），然后安装 Python 3 和 `pip`（Python 的包管理工具）。安装完成后，可以通过以下命令验证安装：
```bash
python3 --version
pip3 --version
```

### 安装指定版本 Python
有时候需要安装特定版本的 Python。可以通过 `deadsnakes` PPA（Personal Package Archive）来实现。以安装 Python 3.8 为例：
1. 添加 `deadsnakes` PPA：
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
2. 更新软件包列表：
```bash
sudo apt update
```
3. 安装 Python 3.8：
```bash
sudo apt install python3.8 python3.8-dev python3.8-venv
```
这里 `python3.8-dev` 提供了开发 Python 3.8 所需的头文件和库，`python3.8-venv` 用于创建虚拟环境。

### 使用虚拟环境
虚拟环境允许在同一系统上隔离不同的 Python 项目及其依赖。使用 `venv` 模块创建虚拟环境：
```bash
python3.8 -m venv myenv
```
上述命令使用 Python 3.8 创建了一个名为 `myenv` 的虚拟环境。激活虚拟环境：
```bash
source myenv/bin/activate
```
激活后，命令行提示符会显示当前处于虚拟环境中。在虚拟环境中安装的包只会影响该环境，不会影响系统全局的 Python 安装。退出虚拟环境使用：
```bash
deactivate
```

## 常见实践
### 安装 Python 包
使用 `pip` 安装 Python 包。在虚拟环境激活状态下，例如安装 `numpy` 包：
```bash
pip install numpy
```
也可以安装指定版本的包：
```bash
pip install numpy==1.19.5
```

### 配置开发环境
常用的 Python 开发环境有 PyCharm、VS Code 等。以 VS Code 为例，安装 Python 扩展后，在打开项目目录时，VS Code 会自动检测到虚拟环境。在项目的 `.vscode` 文件夹下创建 `settings.json` 文件，可以配置 Python 解释器路径：
```json
{
    "python.pythonPath": "/path/to/myenv/bin/python"
}
```

## 最佳实践
### 版本管理策略
使用 `pyenv` 工具可以更好地管理多个 Python 版本。安装 `pyenv` 后，可以通过以下命令安装指定版本的 Python：
```bash
pyenv install 3.9.6
```
`pyenv` 还支持设置全局、局部或会话级别的 Python 版本，方便在不同项目间切换。

### 安全安装
从官方和可信的源安装 Python 包，避免从不可信的渠道下载可能包含恶意代码的包。可以通过配置 `pip` 的源来使用国内的镜像源，提高下载速度和安全性。在 `~/.pip/pip.conf` 文件中添加：
```ini
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
```

## 小结
在 Ubuntu 上安装 Python 有多种方式，从安装默认版本到指定版本，再到使用虚拟环境和最佳实践的版本管理，都为开发者提供了灵活的选择。通过掌握这些方法和实践，读者可以根据自己的项目需求，高效地配置和使用 Python 开发环境。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [`pyenv` 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}