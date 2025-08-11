---
title: "在 Linux Ubuntu 上安装 Python"
description: "Python 是一种广泛使用的高级编程语言，以其简洁的语法、强大的功能和丰富的库而闻名。在 Linux Ubuntu 系统上安装 Python 是许多开发人员和数据科学家的基础操作。本文将详细介绍在 Ubuntu 系统上安装 Python 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握这一关键技能。"
date: 2025-04-06
categories: ["python"]
last_modified_at: 2025-04-06
cascade:
  - type: docs
---


## 简介
Python 是一种广泛使用的高级编程语言，以其简洁的语法、强大的功能和丰富的库而闻名。在 Linux Ubuntu 系统上安装 Python 是许多开发人员和数据科学家的基础操作。本文将详细介绍在 Ubuntu 系统上安装 Python 的相关知识，包括基础概念、使用方法、常见实践以及最佳实践，帮助读者轻松掌握这一关键技能。

<!-- more -->
## 目录
1. 基础概念
2. 安装 Python 的方法
    - 使用系统包管理器安装
    - 从源代码安装
    - 使用 pyenv 安装
3. 常见实践
    - 安装特定版本的 Python
    - 管理 Python 虚拟环境
4. 最佳实践
    - 保持系统更新
    - 选择合适的安装方式
    - 合理使用虚拟环境
5. 小结
6. 参考资料

## 基础概念
### Python 版本
Python 有两个主要版本：Python 2 和 Python 3。Python 2 是较旧的版本，已经在 2020 年停止更新。Python 3 是当前的主流版本，具有更好的性能、安全性和新特性。在 Ubuntu 上安装 Python 时，通常建议安装 Python 3。

### 安装方式
- **系统包管理器安装**：使用 Ubuntu 的系统包管理器（如 apt）可以快速安装 Python 及其常用的库。这种方式适合初学者和需要快速搭建开发环境的用户。
- **从源代码安装**：从 Python 官方网站下载源代码并进行编译安装，可以获取最新版本的 Python 并进行自定义配置。但这种方式相对复杂，需要一定的技术经验。
- **使用 pyenv 安装**：pyenv 是一个用于管理多个 Python 版本的工具，它允许在同一系统上轻松切换不同版本的 Python，适合需要同时使用多个 Python 版本的开发人员。

## 安装 Python 的方法

### 使用系统包管理器安装
1. **更新系统包列表**
    ```bash
    sudo apt update
    ```
2. **安装 Python 3**
    ```bash
    sudo apt install python3
    ```
3. **安装 Python 3 的包管理器 pip**
    ```bash
    sudo apt install python3-pip
    ```

### 从源代码安装
1. **下载 Python 源代码**
    从 Python 官方网站（https://www.python.org/downloads/source/）下载所需版本的 Python 源代码。例如，下载 Python 3.9.12：
    ```bash
    wget https://www.python.org/ftp/python/3.9.12/Python-3.9.12.tgz
    ```
2. **解压源代码**
    ```bash
    tar -xvf Python-3.9.12.tgz
    ```
3. **进入源代码目录并配置**
    ```bash
    cd Python-3.9.12
   ./configure --enable-optimizations
    ```
4. **编译并安装**
    ```bash
    make -j $(nproc)
    sudo make install
    ```

### 使用 pyenv 安装
1. **安装 pyenv**
    ```bash
    curl https://pyenv.run | bash
    ```
2. **配置 pyenv**
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
    查看可安装的 Python 版本：
    ```bash
    pyenv install --list
    ```
    安装指定版本的 Python，例如 Python 3.10.8：
    ```bash
    pyenv install 3.10.8
    ```
4. **设置全局 Python 版本**
    ```bash
    pyenv global 3.10.8
    ```

## 常见实践

### 安装特定版本的 Python
使用系统包管理器安装特定版本的 Python 可能受到 Ubuntu 软件源的限制。使用 pyenv 可以更方便地安装特定版本的 Python。例如，安装 Python 3.8.10：
```bash
pyenv install 3.8.10
```

### 管理 Python 虚拟环境
虚拟环境可以隔离不同项目的 Python 依赖，避免依赖冲突。使用 `venv` 模块创建虚拟环境：
1. **创建虚拟环境**
    ```bash
    python3 -m venv myenv
    ```
2. **激活虚拟环境**
    - 在 Linux 上：
    ```bash
    source myenv/bin/activate
    ```
    - 在 Windows 上：
    ```bash
    myenv\Scripts\activate
    ```
3. **退出虚拟环境**
    ```bash
    deactivate
    ```

## 最佳实践

### 保持系统更新
定期更新 Ubuntu 系统可以确保系统的安全性和稳定性，同时也可能包含 Python 及其相关库的更新。使用以下命令更新系统：
```bash
sudo apt update
sudo apt upgrade
```

### 选择合适的安装方式
根据项目需求和个人经验选择合适的安装方式。如果只是进行简单的 Python 开发，使用系统包管理器安装即可；如果需要最新版本或自定义配置，从源代码安装或使用 pyenv 更合适。

### 合理使用虚拟环境
为每个项目创建独立的虚拟环境，避免不同项目之间的依赖冲突。在虚拟环境中安装项目所需的库，确保项目的可移植性和稳定性。

## 小结
本文详细介绍了在 Linux Ubuntu 上安装 Python 的基础概念、多种安装方法、常见实践以及最佳实践。通过系统包管理器、源代码安装和 pyenv 等方式，读者可以根据自己的需求选择合适的安装方式。同时，合理管理虚拟环境和保持系统更新可以提高开发效率和项目的稳定性。希望本文能帮助读者更好地掌握在 Ubuntu 上安装和使用 Python 的技巧。

## 参考资料
- [Python 官方网站](https://www.python.org/)
- [Ubuntu 官方文档](https://ubuntu.com/docs)
- [pyenv 官方文档](https://github.com/pyenv/pyenv)