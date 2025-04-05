---
title: "在 Ubuntu 上安装 Python：从基础到最佳实践"
description: "Python 作为一种广泛应用的高级编程语言，在数据科学、人工智能、Web 开发等众多领域都占据着重要地位。Ubuntu 作为一款流行的 Linux 操作系统，为 Python 的安装和使用提供了良好的环境。本文将详细介绍在 Ubuntu 上安装 Python 的相关知识，涵盖基础概念、具体使用方法、常见实践以及最佳实践，帮助读者轻松掌握在 Ubuntu 系统中安装和运用 Python 的技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
---


## 简介
Python 作为一种广泛应用的高级编程语言，在数据科学、人工智能、Web 开发等众多领域都占据着重要地位。Ubuntu 作为一款流行的 Linux 操作系统，为 Python 的安装和使用提供了良好的环境。本文将详细介绍在 Ubuntu 上安装 Python 的相关知识，涵盖基础概念、具体使用方法、常见实践以及最佳实践，帮助读者轻松掌握在 Ubuntu 系统中安装和运用 Python 的技能。

<!-- more -->
## 目录
1. 基础概念
2. 使用方法
    - 安装默认版本 Python
    - 安装特定版本 Python
3. 常见实践
    - 使用虚拟环境
    - 安装 Python 包
4. 最佳实践
    - 版本管理
    - 环境配置
5. 小结
6. 参考资料

## 基础概念
### Python 版本
Python 有多个主要版本，如 Python 2 和 Python 3。Python 2 已经停止维护，Python 3 是当前的主流版本，具备更好的性能、安全性以及新特性。在 Ubuntu 系统中，默认可能安装了 Python 2 和 Python 3 中的一个或两个版本。

### Ubuntu 软件包管理系统
Ubuntu 使用 `apt`（Advanced Package Tool）作为其软件包管理系统。通过 `apt`，用户可以方便地安装、更新和卸载软件包及其依赖项。在安装 Python 时，我们将借助 `apt` 来获取和安装相关的软件包。

## 使用方法

### 安装默认版本 Python
在大多数 Ubuntu 版本中，Python 3 是默认安装的。可以通过以下命令来检查是否已经安装以及安装的版本：
```bash
python3 --version
```
如果系统提示命令未找到，说明没有安装 Python 3，可以使用以下命令进行安装：
```bash
sudo apt update
sudo apt install python3
```
上述命令中，`sudo apt update` 用于更新软件包列表，确保获取到最新的软件包信息；`sudo apt install python3` 则用于安装 Python 3 及其依赖项。

### 安装特定版本 Python
有时候我们可能需要安装特定版本的 Python，比如 Python 3.8 或 Python 3.9。可以通过以下步骤实现：

1. **添加软件源**
对于 Ubuntu 20.04 及以上版本，可以使用以下命令添加官方的 Python 软件源：
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
2. **更新软件包列表**
```bash
sudo apt update
```
3. **安装特定版本 Python**
例如，安装 Python 3.8：
```bash
sudo apt install python3.8
```

安装完成后，可以通过 `python3.8 --version` 命令来验证安装的版本是否正确。

## 常见实践

### 使用虚拟环境
虚拟环境可以帮助我们在同一系统中创建多个相互隔离的 Python 环境，每个环境可以有不同的 Python 版本和安装包。这在开发多个不同项目时非常有用，避免了不同项目之间的依赖冲突。

1. **安装虚拟环境工具**
```bash
sudo apt install python3 - venv
```
2. **创建虚拟环境**
```bash
python3 -m venv myenv
```
上述命令在当前目录下创建了一个名为 `myenv` 的虚拟环境。

3. **激活虚拟环境**
在终端中进入虚拟环境目录并激活它：
```bash
source myenv/bin/activate
```
激活后，终端提示符会显示当前处于虚拟环境中。

4. **退出虚拟环境**
```bash
deactivate
```

### 安装 Python 包
在虚拟环境激活的状态下，可以使用 `pip` 来安装 Python 包。例如，安装 `numpy` 包：
```bash
pip install numpy
```
如果需要安装特定版本的包，可以指定版本号：
```bash
pip install numpy==1.19.5
```

## 最佳实践

### 版本管理
为了更好地管理 Python 版本，可以使用 `pyenv`。`pyenv` 是一个简单的 Python 版本管理工具，允许用户在不同版本的 Python 之间轻松切换。

1. **安装 `pyenv`**
```bash
curl https://pyenv.run | bash
```
2. **配置环境变量**
将以下内容添加到 `~/.bashrc` 文件中：
```bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```
然后执行 `source ~/.bashrc` 使配置生效。

3. **安装 Python 版本**
使用 `pyenv` 安装特定版本的 Python，例如 Python 3.9.7：
```bash
pyenv install 3.9.7
```
4. **设置全局版本或局部版本**
设置全局版本：
```bash
pyenv global 3.9.7
```
在特定项目目录下设置局部版本：
```bash
cd myproject
pyenv local 3.9.7
```

### 环境配置
在开发项目时，为了确保项目环境的一致性，可以使用 `requirements.txt` 文件来记录项目所依赖的 Python 包及其版本。

1. **生成 `requirements.txt` 文件**
在虚拟环境中，使用以下命令生成 `requirements.txt` 文件：
```bash
pip freeze > requirements.txt
```
2. **安装依赖**
在新的环境中，可以使用以下命令安装 `requirements.txt` 文件中记录的所有依赖包：
```bash
pip install -r requirements.txt
```

## 小结
本文详细介绍了在 Ubuntu 上安装 Python 的相关内容，包括基础概念、不同版本的安装方法、常见实践以及最佳实践。通过掌握这些知识，读者能够根据自己的需求在 Ubuntu 系统中灵活安装和管理 Python 环境，为后续的开发和学习打下坚实的基础。

## 参考资料
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [Python 官方文档](https://docs.python.org/3/){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}