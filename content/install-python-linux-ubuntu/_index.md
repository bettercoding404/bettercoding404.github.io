---
title: "在 Ubuntu Linux 上安装 Python"
description: "Python 是一种广泛应用的高级编程语言，以其简洁的语法、强大的功能和丰富的库而闻名。在 Ubuntu Linux 系统中安装 Python 是许多开发人员和系统管理员的常见任务。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握这一过程。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
Python 是一种广泛应用的高级编程语言，以其简洁的语法、强大的功能和丰富的库而闻名。在 Ubuntu Linux 系统中安装 Python 是许多开发人员和系统管理员的常见任务。本文将详细介绍在 Ubuntu 上安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握这一过程。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本**
    - **Ubuntu 软件包管理系统**
2. **使用方法**
    - **安装默认 Python 版本**
    - **安装特定 Python 版本**
    - **使用虚拟环境**
3. **常见实践**
    - **更新 Python 包**
    - **安装第三方库**
4. **最佳实践**
    - **管理多个 Python 版本**
    - **优化 Python 开发环境**
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本
Python 有两个主要版本：Python 2 和 Python 3。Python 2 已逐渐停止维护，Python 3 成为主流版本并不断发展。在 Ubuntu 上安装 Python 时，需明确安装的版本。

### Ubuntu 软件包管理系统
Ubuntu 使用 APT（Advanced Package Tool）进行软件包管理。通过 APT，用户可以方便地安装、更新和卸载软件包。在安装 Python 时，也会借助 APT 工具来获取和安装相关软件包。

## 使用方法
### 安装默认 Python 版本
Ubuntu 通常默认安装了 Python 2 和 Python 3。可以通过以下命令检查已安装的版本：
```bash
python --version
python3 --version
```
若要安装最新的默认版本，可以使用以下命令：
```bash
sudo apt update
sudo apt install python3 python3-pip
```
`python3` 是 Python 3 的解释器，`python3-pip` 是 Python 3 的包管理工具。

### 安装特定 Python 版本
有时需要安装特定版本的 Python，例如 Python 3.8。可以通过以下步骤实现：
1. 添加 deadsnakes 软件源：
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
2. 更新软件包列表：
```bash
sudo apt update
```
3. 安装特定版本的 Python：
```bash
sudo apt install python3.8 python3.8-dev python3.8-venv
```
`python3.8-dev` 提供了开发 Python 3.8 应用所需的头文件和库，`python3.8-venv` 用于创建虚拟环境。

### 使用虚拟环境
虚拟环境允许在同一系统上隔离不同的 Python 项目及其依赖。使用 `venv` 模块创建虚拟环境：
1. 创建虚拟环境：
```bash
python3.8 -m venv myenv
```
这将在当前目录下创建一个名为 `myenv` 的虚拟环境。
2. 激活虚拟环境：
```bash
source myenv/bin/activate
```
激活后，命令行提示符会显示当前虚拟环境的名称。
3. 退出虚拟环境：
```bash
deactivate
```

## 常见实践
### 更新 Python 包
使用 `pip` 工具更新已安装的 Python 包：
```bash
pip install --upgrade package_name
```
若要更新所有包，可以使用以下命令：
```bash
pip freeze | grep -v '^-e' | cut -d = -f 1  | xargs -n1 pip install --upgrade
```

### 安装第三方库
使用 `pip` 安装第三方库，例如安装 `numpy`：
```bash
pip install numpy
```
若在虚拟环境中安装，库将被安装到虚拟环境的目录中，不会影响系统全局的 Python 环境。

## 最佳实践
### 管理多个 Python 版本
使用 `pyenv` 工具可以方便地管理多个 Python 版本。安装 `pyenv`：
```bash
curl https://pyenv.run | bash
```
添加 `pyenv` 到环境变量：
```bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```
使用 `pyenv` 安装不同版本的 Python：
```bash
pyenv install 3.7.9
pyenv install 3.9.4
```
切换 Python 版本：
```bash
pyenv global 3.9.4
```

### 优化 Python 开发环境
使用 `pipenv` 工具可以更好地管理项目依赖和虚拟环境。安装 `pipenv`：
```bash
pip install pipenv
```
在项目目录中创建 `Pipfile` 和 `Pipfile.lock`：
```bash
pipenv install
```
进入 `pipenv` 虚拟环境：
```bash
pipenv shell
```
在 `pipenv` 环境中安装和管理依赖更加方便，并且可以通过 `Pipfile.lock` 锁定依赖版本，确保项目在不同环境中的一致性。

## 小结
在 Ubuntu Linux 上安装 Python 有多种方式，从默认版本的安装到特定版本的定制，再到虚拟环境的使用和多个版本的管理。通过掌握这些方法和最佳实践，开发人员可以根据项目需求灵活配置 Python 开发环境，提高开发效率。

## 参考资料
- [Python 官方文档](https://docs.python.org/3/)
- [Ubuntu 官方文档](https://ubuntu.com/docs)
- [pyenv 官方文档](https://github.com/pyenv/pyenv)
- [pipenv 官方文档](https://pipenv.pypa.io/en/latest/)