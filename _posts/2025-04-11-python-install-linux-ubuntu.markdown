---
title: "在 Ubuntu 上安装 Python：深入指南"
description: "Python 作为一种广泛应用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有着举足轻重的地位。在 Ubuntu 系统上安装 Python 是开启 Python 编程之旅的重要一步。本文将详细介绍在 Ubuntu 系统中安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一过程。"
date: 2025-04-11
categories: ["python"]
last_modified_at: 2025-04-11
---


## 简介
Python 作为一种广泛应用的高级编程语言，在数据科学、Web 开发、自动化脚本等众多领域都有着举足轻重的地位。在 Ubuntu 系统上安装 Python 是开启 Python 编程之旅的重要一步。本文将详细介绍在 Ubuntu 系统中安装 Python 的基础概念、使用方法、常见实践以及最佳实践，帮助读者全面掌握这一过程。

<!-- more -->
## 目录
1. **基础概念**
    - **Python 版本**
    - **Ubuntu 软件包管理系统**
2. **使用方法**
    - **使用 apt 安装 Python**
    - **使用源码编译安装 Python**
    - **使用 pyenv 安装多个 Python 版本**
3. **常见实践**
    - **安装 Python 依赖包**
    - **创建虚拟环境**
4. **最佳实践**
    - **选择合适的 Python 版本**
    - **管理项目依赖**
5. **小结**
6. **参考资料**

## 基础概念
### Python 版本
Python 有两个主要版本：Python 2 和 Python 3。Python 2 虽然仍在一些旧项目中使用，但 Python 3 是当前的主流版本，拥有更好的性能、安全性和对新特性的支持。Ubuntu 通常默认安装了 Python 2 和 Python 3，但版本可能不是最新的，具体取决于 Ubuntu 的发行版本。

### Ubuntu 软件包管理系统
Ubuntu 使用 apt（Advanced Package Tool）作为软件包管理系统。通过 apt，用户可以轻松地安装、更新和卸载软件包。在安装 Python 及其相关软件包时，apt 是一个常用且便捷的工具。

## 使用方法
### 使用 apt 安装 Python
Ubuntu 官方软件源中包含了 Python 及其相关的软件包，使用 apt 安装 Python 非常简单。

1. **更新软件包列表**
在安装之前，先更新软件包列表，确保获取到最新的软件信息：
```bash
sudo apt update
```
2. **安装 Python 3**
安装 Python 3 的基本命令：
```bash
sudo apt install python3
```
这将安装 Ubuntu 官方源中默认版本的 Python 3。

3. **安装 Python 2（可选）**
如果需要 Python 2，可以使用以下命令安装：
```bash
sudo apt install python2
```

### 使用源码编译安装 Python
有时候，官方源中的 Python 版本可能不是你需要的，这时候可以通过源码编译安装特定版本的 Python。

1. **安装编译依赖**
```bash
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
```
2. **下载 Python 源码**
到 Python 官方网站下载所需版本的源码，例如 Python 3.9.10：
```bash
wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz
```
3. **解压并编译安装**
```bash
tar -xzf Python-3.9.10.tgz
cd Python-3.9.10
./configure --enable-optimizations
make -j $(nproc)
sudo make altinstall
```
`--enable-optimizations` 选项可以优化编译过程，`make -j $(nproc)` 使用多核编译加速编译过程，`altinstall` 避免覆盖系统默认的 Python 版本。

### 使用 pyenv 安装多个 Python 版本
`pyenv` 是一个用于管理多个 Python 版本的工具。

1. **安装 pyenv**
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
然后执行：
```bash
source ~/.bashrc
```
3. **安装 Python 版本**
列出可安装的 Python 版本：
```bash
pyenv install --list
```
安装指定版本，例如 Python 3.10.5：
```bash
pyenv install 3.10.5
```
4. **设置全局或局部 Python 版本**
设置全局版本：
```bash
pyenv global 3.10.5
```
在特定项目目录下设置局部版本：
```bash
cd your_project_directory
pyenv local 3.10.5
```

## 常见实践
### 安装 Python 依赖包
安装好 Python 后，通常需要安装各种依赖包。可以使用 `pip` 工具（Python 3 中为 `pip3`）来安装。

安装单个包：
```bash
pip3 install package_name
```
安装多个包，可以将包名依次列出：
```bash
pip3 install package1 package2 package3
```
也可以从 `requirements.txt` 文件中安装多个依赖包：
```bash
pip3 install -r requirements.txt
```
`requirements.txt` 文件内容格式如下：
```
package1==version1
package2==version2
package3==version3
```

### 创建虚拟环境
虚拟环境可以隔离不同项目的 Python 依赖，避免相互干扰。

使用 `venv` 模块创建虚拟环境（Python 3 自带）：
```bash
python3 -m venv myenv
```
激活虚拟环境：
```bash
source myenv/bin/activate
```
在虚拟环境中安装的包只会存在于该环境中。退出虚拟环境：
```bash
deactivate
```

## 最佳实践
### 选择合适的 Python 版本
在开始新项目时，优先选择 Python 3 的最新稳定版本。如果项目有兼容性要求，例如与一些仅支持 Python 2 的旧系统集成，才考虑使用 Python 2。同时，关注 Python 官方发布的版本信息和安全公告，及时更新到最新版本以获取性能提升和安全修复。

### 管理项目依赖
使用 `requirements.txt` 文件记录项目的依赖及其版本号。在项目开发过程中，定期更新依赖并测试，确保兼容性。可以使用工具如 `pip-tools` 来生成和管理 `requirements.txt` 文件，使依赖管理更加规范和可控。

## 小结
本文详细介绍了在 Ubuntu 系统上安装 Python 的多种方法，包括使用 apt 安装默认版本、通过源码编译安装特定版本以及使用 pyenv 管理多个版本。同时，阐述了安装依赖包和创建虚拟环境的常见实践，以及选择合适 Python 版本和管理项目依赖的最佳实践。通过掌握这些知识，读者可以更加高效地在 Ubuntu 上进行 Python 开发。

## 参考资料
- [Python 官方网站](https://www.python.org/){: rel="nofollow"}
- [Ubuntu 官方文档](https://ubuntu.com/docs){: rel="nofollow"}
- [pyenv 官方文档](https://github.com/pyenv/pyenv){: rel="nofollow"}